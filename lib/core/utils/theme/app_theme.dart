import 'package:eduline/core/utils/app_colors.dart';
import 'package:eduline/core/utils/theme/app_elevated_button_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      // fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        error: AppColors.errorColor,
        surface: AppColors.backgroundColor,
      ),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      // textTheme: AppTextTheme.lightTextTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.elevatedButtonTheme,
      // appBarTheme: AppBarThemeData.lightAppBarTheme,
      // inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme
    );
  }
}
