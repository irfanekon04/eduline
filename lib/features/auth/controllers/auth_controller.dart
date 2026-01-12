import 'package:eduline/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final loginEmailController = TextEditingController();
  final loginPassController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final signupEmailController = TextEditingController();
  final signupNameController = TextEditingController();
  final signupPassController = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();

  var isPassVisible = false.obs;
  var isRememberMe = false.obs;
  var isLoading = false.obs;

  // Password Strength
  var passwordStrength = 0.0.obs; // 0 to 1
  var passwordStrengthText = "Weak".obs;
  var isPasswordCompliant = false.obs;

  @override
  void onInit() {
    super.onInit();
    signupPassController.addListener(() {
      _checkPasswordStrength(signupPassController.text);
    });
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPassController.dispose();
    signupEmailController.dispose();
    signupNameController.dispose();
    signupPassController.dispose();
    super.onClose();
  }

  void _checkPasswordStrength(String password) {
    if (password.isEmpty) {
      passwordStrength.value = 0.0;
      passwordStrengthText.value = "";
      isPasswordCompliant.value = false;
      return;
    }

    double strength = 0;
    if (password.length > 0) strength += 0.25;
    if (password.length >= 8) strength += 0.25;
    if (RegExp(r'[A-Za-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password))
      strength += 0.25;
    if (password.length >= 8 && RegExp(r'[!@#\$&*~]').hasMatch(password))
      strength += 0.25;

    passwordStrength.value = strength;

    if (strength <= 0.25) {
      passwordStrengthText.value = "Weak";
    } else if (strength <= 0.5) {
      passwordStrengthText.value = "Fair";
    } else if (strength <= 0.75) {
      passwordStrengthText.value = "Good";
    } else {
      passwordStrengthText.value = "Strong";
    }

    // Specific compliance check: "At least 8 characters with a combination of letters and numbers"
    isPasswordCompliant.value =
        password.length >= 8 &&
        RegExp(r'[A-Za-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password);
  }

  void togglePasswordVisibility() {
    isPassVisible.value = !isPassVisible.value;
  }

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); // Mock API delay
      isLoading.value = false;
      // Navigate to Home or Location Selection
      // For now, let's go to Home (API Dashboard)
      Get.offAllNamed(AppRoutes.location);
    }
  }

  void signup() async {
    if (signupFormKey.currentState!.validate()) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); // Mock API delay
      isLoading.value = false;
      // Show Success Popup or Navigate
      _showSuccessPopup();
    }
  }

  void _showSuccessPopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/sign_up_success_popup.png',
                height: 120,
                // width: 120,
              ),
              const SizedBox(height: 20),
              const Text(
                "Successfully Registered",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your account has been registered successfully, now let's enjoy our features!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                    Get.offAllNamed(AppRoutes.home); // Go to Home
                  },
                  child: const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
