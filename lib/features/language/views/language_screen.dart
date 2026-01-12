import 'package:eduline/core/common_widgets/primary_button.dart';
import 'package:eduline/core/utils/app_colors.dart';
import 'package:eduline/features/language/controllers/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageScreen extends GetView<LanguageController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: AppColors.textPrimary,
            
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                "What is Your Mother Language",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: .w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Discover what is a podcast description and podcast summary.",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textBody,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.languages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final lang = controller.languages[index];
                    return Obx(() {
                      bool isSelected =
                          controller.selectedLanguage.value == lang['name'];
                      return Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: isSelected
                              ? Border.all(color: Colors.grey.shade200)
                              : Border.all(color: Colors.transparent),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 32,
                              height: 32,

                              child: Image.asset(
                                lang['flag']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                lang['name']!,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            if (isSelected)
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.check_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "Selected",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: .w500,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 0,
                                ),
                              )
                            else
                              TextButton(
                                onPressed: () =>
                                    controller.selectLanguage(lang['name']!),
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFFF6F6F6),
                                  foregroundColor: Color(0xFFAEAEB2),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFFEBEBEB)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Select",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: .w500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                onPressed: controller.navigateToNext,
                text: 'Continue',
                isOutlined: false,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
