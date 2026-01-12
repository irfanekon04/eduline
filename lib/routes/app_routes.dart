import 'package:eduline/features/auth/bindings/auth_binding.dart';
import 'package:eduline/features/auth/views/sign_in_screen.dart';
import 'package:eduline/features/home/bindings/home_bindings.dart';
import 'package:eduline/features/home/views/home_screen.dart';
import 'package:eduline/features/language/bindings/language_binding.dart';
import 'package:eduline/features/language/views/language_screen.dart';
import 'package:eduline/features/location/bindings/location_binding.dart';
import 'package:eduline/features/location/views/location_screen.dart';
import 'package:eduline/features/onboarding/bindings/onboarding_binding.dart';
import 'package:eduline/features/onboarding/views/onboarding_screen.dart';
import 'package:eduline/features/splash_screen/bindings/splash_bindings.dart';
import 'package:eduline/features/splash_screen/views/splash_screen.dart';

import 'package:get/get.dart';

class AppRoutes {
  static String init = "/";
  static String auth = "/authScreen";
  static String onboarding = "/onboarding";
  static String location = "/location";
  static String language = "/language";
  static String home = "/home";

  static List<GetPage> routes = [
    GetPage(
      name: init,
      page: () => const SplashScreen(),
      binding: SplashBindings(),
    ),
    GetPage(name: auth, page: () => const SignInScreen(), binding: AuthBinding()),
    GetPage(
      name: onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: location,
      page: () => const LocationScreen(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: language,
      page: () => const LanguageScreen(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
    ),
  ];
}
