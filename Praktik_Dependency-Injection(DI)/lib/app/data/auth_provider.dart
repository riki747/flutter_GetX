import 'package:get/get.dart';

class AuthService extends GetxService {
  // Simulasikan status login
  final RxBool isLoggedIn = false.obs;

  Future<AuthService> init() async {
    // Simulasi delay cek token lokal
    await Future.delayed(const Duration(seconds: 2));
    isLoggedIn.value = false; // Set true jika ingin simulasi sudah login
    return this;
  }

  void login() {
    isLoggedIn.value = true;
    print("User Logged In");
  }

  void logout() {
    isLoggedIn.value = false;
    print("User Logged Out");
  }
}