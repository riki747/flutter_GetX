import 'package:tflite_flutter/tflite_flutter.dart';

enum DelegateType { cpu, gpu, nnapi }

class ClassifierWithDelegate {
  Future<Interpreter> _createInterpreter(DelegateType delegate) async {
    final options = InterpreterOptions();

    switch (delegate) {
      case DelegateType.gpu:
        options.addDelegate(GpuDelegateV2());
        break;
      case DelegateType.nnapi:
        options.useNnApiForAndroid = true;
        break;
      case DelegateType.cpu:
        options.threads = 4;
        break;
    }

    return await Interpreter.fromAsset(
      'assets/ml/model.tflite',
      options: options,
    );
  }
}