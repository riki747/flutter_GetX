import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/data/auth_provider.dart'; // Sesuaikan path

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inject AuthService menggunakan Get.put secara synchronous/asynchronous
  await Get.putAsync(() => AuthService().init());

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}