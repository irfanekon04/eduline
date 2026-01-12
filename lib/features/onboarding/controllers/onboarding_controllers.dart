import 'package:eduline/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var pageIndex = 0.obs;
  final PageController pageController = PageController();

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Best online courses in the world",
      "subtitle":
          "Now you can learn anywhere, anytime, even if there is no internet access!",
      "image": "assets/images/onboarding-1.png",
    },
    {
      "title": "Explore your new skill today",
      "subtitle":
          "Our platform is designed to help you explore new skills. Let's learn & grow with Eduline!",
      "image": "assets/images/onboarding-2.png",
    },
  ];

  void onPageChanged(int index) {
    pageIndex.value = index;
  }

  void nextPage() {
    if (pageIndex.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Get.offNamed(AppRoutes.auth);
    }
  }
}
