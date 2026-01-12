import 'package:eduline/routes/app_routes.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  final languages = [
    {'name': 'English (US)', 'flag': 'assets/images/flags/us.png'},
    {'name': 'Indonesia', 'flag': 'assets/images/flags/id.png'},
    {'name': 'Afghanistan', 'flag': 'assets/images/flags/afg.png'},
    {'name': 'Algeria', 'flag': 'assets/images/flags/alg.png'},
    {'name': 'Malaysia', 'flag': 'assets/images/flags/mal.png'},
    {'name': 'Arabic', 'flag': 'assets/images/flags/uae.png'},
  ];

  var selectedLanguage = 'English (US)'.obs;

  void selectLanguage(String name) {
    selectedLanguage.value = name;
  }

  void navigateToNext () {
    Get.offAllNamed(AppRoutes.home);
  }
}
