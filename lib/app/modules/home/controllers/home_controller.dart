import 'package:get/get.dart';
import '../../../data/auth_provider.dart'; // Sesuaikan path

class HomeController extends GetxController {
  // Mengambil instance AuthService yang sudah di-inject di main.dart
  final authService = Get.find<AuthService>();

  void handleAuthAction() {
    if (authService.isLoggedIn.value) {
      authService.logout();
    } else {
      authService.login();
    }
  }
}