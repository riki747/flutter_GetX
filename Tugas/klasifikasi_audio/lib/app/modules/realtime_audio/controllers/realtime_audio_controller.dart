import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class RealtimeAudioController extends GetxController {
  final _audioRecorder = AudioRecorder();
  StreamSubscription<Uint8List>? _audioStreamSubscription;
  Interpreter? _interpreter;
  List<String> _labels = [];

  final isRecording = false.obs;
  final predictedLabel = "Ready to record".obs;
  final confidence = 0.0.obs;

  // RxList untuk menampung semua hasil label dan skornya agar bisa tampil di UI
  final allPredictions = <Map<String, dynamic>>[].obs;

  // Supaya 44.032 sampel setara dengan ~2 detik, kita gunakan Sample Rate 22050 Hz
  // (44032 / 22050 = 1.99 detik)
  static const int _sampleRate = 22050; 
  static const int _expectedInputSize = 44032; 
  
  List<int> _audioBuffer = [];

  @override
  void onInit() {
    super.onInit();
    _loadModelAndLabels();
  }

  @override
  void onClose() {
    _stopRecording();
    _audioRecorder.dispose();
    _interpreter?.close();
    super.onClose();
  }

  Future<void> _loadModelAndLabels() async {
    try {
      final labelData = await rootBundle.loadString('assets/ml/labels.txt');
      _labels = labelData.split('\n').where((line) => line.isNotEmpty)
          .map((line) => line.split(' ').sublist(1).join(' ')).toList();

      _interpreter = await Interpreter.fromAsset('assets/ml/soundclassifier_with_metadata.tflite');
      predictedLabel.value = "Ready to record";
    } catch (e) {
      predictedLabel.value = "Failed to load model";
    }
  }

  Future<void> toggleRecording() async {
    if (isRecording.value) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    try {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) return;

      if (await _audioRecorder.hasPermission()) {
        final stream = await _audioRecorder.startStream(const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: _sampleRate, // Gunakan 22050 Hz
          numChannels: 1,
        ));

        _audioBuffer.clear();
        isRecording.value = true;
        _audioStreamSubscription = stream.listen((Uint8List data) => _processAudioData(data));
      }
    } catch (e) {
      predictedLabel.value = "Error: $e";
    }
  }

  Future<void> _stopRecording() async {
    await _audioStreamSubscription?.cancel();
    _audioStreamSubscription = null;
    await _audioRecorder.stop();
    isRecording.value = false;
    allPredictions.clear();
  }

  void _processAudioData(Uint8List data) {
    final byteData = ByteData.sublistView(data);
    final totalSamples = data.lengthInBytes ~/ 2;
    final int16Data = Int16List(totalSamples);

    for (int i = 0; i < totalSamples; i++) {
      int16Data[i] = byteData.getInt16(i * 2, Endian.little);
    }

    _audioBuffer.addAll(int16Data);

    // Jika sudah terkumpul 44.032 sampel (~2 detik)
    if (_audioBuffer.length >= _expectedInputSize) {
      List<int> samplesToProcess = _audioBuffer.sublist(_audioBuffer.length - _expectedInputSize);
      
      // Kita bersihkan buffer total (tanpa overlap) agar tiap 2 detik benar-benar prediksi baru
      _audioBuffer.clear(); 
      
      _runInference(samplesToProcess);
    }
  }

 void _runInference(List<int> pcmData) {
    if (_interpreter == null || _labels.isEmpty) return;

    // --- BAGIAN BOOSTER & NORMALISASI ---
    double booster = 1.5; // Naikkan ke 2.0 jika masih kurang peka
    List<double> inputData = pcmData.map((e) {
      // Mengubah angka PCM ke desimal dan dikalikan booster
      double normalized = (e / 32768.0) * booster;
      // Batasi agar tetap di rentang -1.0 sampai 1.0
      return normalized.clamp(-1.0, 1.0);
    }).toList();
    // ------------------------------------

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

      // Threshold: Jika di bawah 60%, anggap Background Noise (Label 0)
      if (maxProb < 0.6) {
        predictedLabel.value = _labels[0]; 
        confidence.value = probabilities[0];
      } else {
        predictedLabel.value = _labels[maxIndex];
        confidence.value = maxProb;
      }

    } catch (e) {
      print("Inference Error: $e");
    }
  }
}