import 'package:eduline/core/common_widgets/primary_button.dart';
import 'package:eduline/core/utils/app_colors.dart';
import 'package:eduline/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eduline/features/auth/views/reset_pass_screen.dart';
import 'package:eduline/features/auth/views/verify_code_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class AuthController extends GetxController {
  final loginEmailController = TextEditingController();
  final loginPassController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final signupEmailController = TextEditingController();
  final signupNameController = TextEditingController();

  final signupPassController = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();

  final forgotPasswordEmailController = TextEditingController();
  final forgotPasswordFormKey = GlobalKey<FormState>();

  final resetNewPassController = TextEditingController();
  final resetConfirmPassController = TextEditingController();
  final resetPassFormKey = GlobalKey<FormState>();

  final otpController = TextEditingController();
  var otpText = "".obs;

  var resendTimer = 60.obs;
  Timer? _timer;

  var isPassVisible = false.obs;
  var isRememberMe = false.obs;
  var isLoading = false.obs;

  var isResetNewPassVisible = false.obs;
  var isResetConfirmPassVisible = false.obs;

  var passwordStrength = 0.0.obs;
  var passwordStrengthText = "Weak".obs;
  var isPasswordCompliant = false.obs;

  @override
  void onInit() {
    super.onInit();
    signupPassController.addListener(() {
      _checkPasswordStrength(signupPassController.text);
    });
    otpController.addListener(() {
      otpText.value = otpController.text;
    });
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPassController.dispose();
    signupEmailController.dispose();
    signupNameController.dispose();
    signupPassController.dispose();
    forgotPasswordEmailController.dispose();
    resetNewPassController.dispose();
    resetConfirmPassController.dispose();
    otpController.dispose();
    _timer?.cancel();
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
    if (password.isNotEmpty) strength += 0.25;
    if (password.length >= 8) strength += 0.25;
    if (RegExp(r'[A-Za-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password)) {
      strength += 0.25;
    }
    if (password.length >= 8 && RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      strength += 0.25;
    }

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
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.location);
    }
  }

  void signup() async {
    if (signupFormKey.currentState!.validate()) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      _showSuccessPopup();
    }
  }

  void sendResetLink() async {
    if (forgotPasswordFormKey.currentState!.validate()) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      Get.snackbar("Success", "Verification code sent to email");
      Get.to(() => const ResetPasswordScreen());
    }
  }

  void startResendTimer() {
    resendTimer.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void resendCode() {
    if (resendTimer.value == 0) {
      startResendTimer();
      Get.snackbar("Success", "Code resent successfully");
    }
  }

  void toggleResetNewPassVisibility() {
    isResetNewPassVisible.value = !isResetNewPassVisible.value;
  }

  void toggleResetConfirmPassVisibility() {
    isResetConfirmPassVisible.value = !isResetConfirmPassVisible.value;
  }

  void resetPassword() async {
    if (resetPassFormKey.currentState!.validate()) {
      if (resetNewPassController.text != resetConfirmPassController.text) {
        Get.snackbar("Error", "Passwords do not match");
        return;
      }
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      Get.to(() => const VerifyCodeScreen());
    }
  }

  void verifyOtp() async {
    String code = otpController.text;
    if (code.length == 4) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      _showPasswordSuccessPopup();
    } else {
      Get.snackbar("Error", "Please enter a valid 4-digit code");
    }
  }

  void _showPasswordSuccessPopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Image.asset(
                'assets/images/forgot_pass_success_popup.png',
                height: 120,
              ),
              const SizedBox(height: 20),
              Text(
                "Success",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Your password is succesfully created",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                text: "Continue",
                onPressed: () {
                  Get.back();
                  Get.offAllNamed(AppRoutes.auth);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _showSuccessPopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                'assets/images/sign_up_success_popup.png',
                height: 120,
              ),
              const SizedBox(height: 20),
              Text(
                "Successfully Registered",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Your account has been registered successfully, now let's enjoy our features!",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                text: "Continue",
                onPressed: () {
                  Get.back();
                  Get.offAllNamed(AppRoutes.home);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
