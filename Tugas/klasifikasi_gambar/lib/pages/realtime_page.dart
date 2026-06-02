import 'package:flutter/material.dart'; // 1. Ini yang bikin State & setState tidak merah
import 'package:camera/camera.dart';
import '../services/classifier_service.dart';

// 2. Ini induk StatefulWidget yang tadinya hilang
class RealtimePage extends StatefulWidget {
  const RealtimePage({Key? key}) : super(key: key);

  @override
  State<RealtimePage> createState() => _RealtimeState();
}

class _RealtimeState extends State<RealtimePage> {
  CameraController? _camCtrl;
  final _classifier = ClassifierService();
  bool _isProcessing = false;
  Map<String, double>? _results;

  @override
  void initState() {
    super.initState();
    _classifier.loadModel();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _camCtrl = CameraController(
      cameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    await _camCtrl!.initialize();

    // Stream setiap frame untuk klasifikasi
    _camCtrl!.startImageStream((CameraImage image) {
      if (!_isProcessing && _classifier.isReady) {
        _isProcessing = true;
        _classifyFrame(image);
      }
    });
    setState(() {});
  }

  Future<void> _classifyFrame(CameraImage camImg) async {
    // 3. Ini akan TETAP MERAH sampai kamu menyelesaikan Langkah 2 di bawah
    final results = await _classifier.classifyFromCameraImage(camImg);
    if (mounted) {
      setState(() {
        _results = results;
        _isProcessing = false;
      });
    }
  }

  // Kamu juga butuh fungsi build() agar tampilannya tidak blank/error
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Realtime Scan')),
      body: _camCtrl == null || !_camCtrl!.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : CameraPreview(_camCtrl!),
    );
  }
}