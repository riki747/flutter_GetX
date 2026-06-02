import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // lazyPut: HomeController hanya akan dibuat di memori saat HomeView di-render
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}