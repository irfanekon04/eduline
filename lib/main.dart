import 'package:eduline/core/utils/theme/app_theme.dart';
import 'package:eduline/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Eduline",
      initialRoute: AppRoutes.init,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: .light,
    ),
  );
}
