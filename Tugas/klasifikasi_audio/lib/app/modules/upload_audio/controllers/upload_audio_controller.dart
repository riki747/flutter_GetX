import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class UploadAudioController extends GetxController {
  Interpreter? _interpreter;
  List<String> _labels = [];

  final selectedFileName = "No file selected".obs;
  final predictedLabel = "Select an Audio file".obs;
  final confidence = 0.0.obs;
  final allPredictions = <Map<String, dynamic>>[].obs;

  // Kapasitas mangkok AI Teachable Machine
  static const int _expectedInputSize = 44032;

  @override
  void onInit() {
    super.onInit();
    _loadModelAndLabels();
  }

  @override
  void onClose() {
    _interpreter?.close();
    super.onClose();
  }

  Future<void> _loadModelAndLabels() async {
    try {
      final labelData = await rootBundle.loadString('assets/ml/labels.txt');
      _labels = labelData.split('\n').where((line) => line.isNotEmpty)
          .map((line) => line.split(' ').sublist(1).join(' ')).toList();

      _interpreter = await Interpreter.fromAsset('assets/ml/soundclassifier_with_metadata.tflite');
    } catch (e) {
      predictedLabel.value = "Failed to load model";
    }
  }

  Future<void> pickAndClassifyFile() async {
    try {
      // Bebas pilih file audio apa aja tanpa batasan
      FilePickerResult? result = await FilePicker.pickFiles(type: FileType.audio);

      if (result != null && result.files.isNotEmpty) {
        String? path = result.files.first.path;
        if (path != null) {
          selectedFileName.value = result.files.first.name;
          predictedLabel.value = "Analyzing audio...";
          confidence.value = 0.0;
          allPredictions.clear();

          File file = File(path);
          Uint8List bytes = await file.readAsBytes();

          if (bytes.length < 100) {
            predictedLabel.value = "File is too short or corrupted";
            return;
          }

          // DETEKSI OTOMATIS: Apakah ini file WAV murni atau MP3 terkode?
          Uint8List audioData;
          final isWav = path.toLowerCase().endsWith('.wav');

          if (isWav) {
            // Kalau WAV, lewati 44 byte pertama (Header standar)
            audioData = bytes.length > 44 ? bytes.sublist(44) : bytes;
          } else {
            // JALUR NINJA MP3: Kita ambil potongan tengah datanya 
            // (melewati metadata ID3 tag di awal MP3 yang bikin suara jadi kresek)
            final skipOffset = bytes.length > 5000 ? 2048 : 0;
            audioData = bytes.sublist(skipOffset);
          }

          // Konversi aman menggunakan ByteData
          final byteData = ByteData.sublistView(audioData);
          final totalSamples = audioData.lengthInBytes ~/ 2;
          final int16Data = Int16List(totalSamples);

          for (int i = 0; i < totalSamples; i++) {
            int16Data[i] = byteData.getInt16(i * 2, Endian.little);
          }

          // Slicing & Padding genap ke angka 44.032
          List<int> samplesToProcess = [];
          if (int16Data.length >= _expectedInputSize) {
            samplesToProcess = int16Data.sublist(0, _expectedInputSize);
          } else {
            samplesToProcess = int16Data.toList();
            while (samplesToProcess.length < _expectedInputSize) {
              samplesToProcess.add(0);
            }
          }

          // Lempar ke model AI
          _runInference(samplesToProcess);
        }
      }
    } catch (e) {
      predictedLabel.value = "Error reading file";
      print("Error: $e");
    }
  }

  void _runInference(List<int> pcmData) {
    if (_interpreter == null || _labels.isEmpty) return;

    List<double> inputData = pcmData.map((e) => e / 32768.0).toList();
    var input = [inputData];
    var output = List.generate(1, (_) => List.filled(_labels.length, 0.0));

    try {
      _interpreter!.run(input, output);
      List<double> probabilities = output[0];
      
      List<Map<String, dynamic>> tempResults = [];
      double maxProb = 0.0;
      int maxIndex = 0;

      for (int i = 0; i < _labels.length; i++) {
        tempResults.add({
          'label': _labels[i],
          'score': probabilities[i],
        });

        if (probabilities[i] > maxProb) {
          maxProb = probabilities[i];
          maxIndex = i;
        }
      }

      tempResults.sort((a, b) => b['score'].compareTo(a['score']));
      allPredictions.assignAll(tempResults);

      // Threshold 60% -> Vonis Background Noise
      if (maxProb < 0.6) {
        predictedLabel.value = _labels[0]; 
        confidence.value = probabilities[0];
      } else {
        predictedLabel.value = _labels[maxIndex];
        confidence.value = maxProb;
      }
    } catch (e) {
      predictedLabel.value = "Inference Error";
    }
  }
}