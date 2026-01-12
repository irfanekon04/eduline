import 'package:eduline/core/common_widgets/primary_button.dart';
import 'package:eduline/core/utils/app_colors.dart';
import 'package:eduline/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyCodeScreen extends GetView<AuthController> {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.startResendTimer();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.secondaryColor),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        "Verify Code",
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.textBody,
                          ),
                          children: [
                            const TextSpan(
                              text: "Please enter the code we just sent to\n",
                            ),
                            const TextSpan(text: "email "),
                            TextSpan(
                              text:
                                  controller
                                      .forgotPasswordEmailController
                                      .text
                                      .isEmpty
                                  ? "pristia@gmail.com"
                                  : controller
                                        .forgotPasswordEmailController
                                        .text,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildOtpBox(0),
                            _buildOtpBox(1),
                            _buildOtpBox(2),
                            _buildOtpBox(3),
                          ],
                        ),
                        Opacity(
                          opacity: 0,
                          child: TextField(
                            controller: controller.otpController,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            autofocus: true,
                            decoration: const InputDecoration(
                              counterText: "",
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              if (value.length == 4) {
                                controller.verifyOtp();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Obx(() {
                        final seconds = controller.resendTimer.value;
                        final minutesStr = (seconds ~/ 60).toString().padLeft(
                          2,
                          '0',
                        );
                        final secondsStr = (seconds % 60).toString().padLeft(
                          2,
                          '0',
                        );
                        return Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Resend code in ",
                                    style: GoogleFonts.inter(
                                      color: AppColors.textBody,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "$minutesStr:$secondsStr",
                                    style: GoogleFonts.inter(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (seconds == 0)
                              TextButton(
                                onPressed: controller.resendCode,
                                child: Text(
                                  "Resend Now",
                                  style: GoogleFonts.inter(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20,
              ),
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : PrimaryButton(
                        text: "Verify",
                        onPressed: controller.verifyOtp,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.secondaryColor.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Obx(() {
          final text = controller.otpText.value;
          final char = text.length > index ? text[index] : "•";
          return Text(
            char,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: text.length > index
                  ? AppColors.primaryColor
                  : AppColors.textPrimary.withValues(alpha: 0.5),
            ),
          );
        }),
      ),
    );
  }
}
