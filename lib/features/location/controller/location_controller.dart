import 'package:eduline/routes/app_routes.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  void enableLocation() {
    _navigateToNext();
  }

  void skip() {
    _navigateToNext();
  }

  void _navigateToNext() {
    Get.toNamed(AppRoutes.language);
  }
}
