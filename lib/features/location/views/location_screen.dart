import 'package:eduline/core/common_widgets/primary_button.dart';
import 'package:eduline/core/utils/app_colors.dart';
import 'package:eduline/features/location/controller/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationScreen extends GetView<LocationController> {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Image.asset('assets/images/enable_location.png', height: 120),
                const SizedBox(height: 32),
                Text(
                  "Enable Location",
                  style: GoogleFonts.inter(fontSize: 20, fontWeight: .bold),
                ),
                const SizedBox(height: 16),
                Text(
                  "Kindly allow us to access your location to provide you with suggestions for nearby salons",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textBody,
                    fontWeight: .w400,
                  ),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: "Enable",
                  onPressed: controller.enableLocation,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: controller.skip,
                  child: Text(
                    "Skip, Not Now",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
