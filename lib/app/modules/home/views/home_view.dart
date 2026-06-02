import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dependency Injection Practicum'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Reaktif mendengarkan perubahan state dari AuthService
            Obx(() => Text(
                  controller.authService.isLoggedIn.value 
                      ? 'Status: Logged In' 
                      : 'Status: Logged Out',
                  style: const TextStyle(fontSize: 20),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.handleAuthAction(),
              child: Obx(() => Text(
                controller.authService.isLoggedIn.value ? 'Logout' : 'Login'
              )),
            ),
          ],
        ),
      ),
    );
  }
}