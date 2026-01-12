import 'package:eduline/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppElevatedButtonTheme {
  static ElevatedButtonThemeData get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    );
  }
}
