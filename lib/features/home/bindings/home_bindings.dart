import 'package:eduline/core/services/api_service.dart';
import 'package:eduline/features/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.put<HomeController>(HomeController());
  }
}
