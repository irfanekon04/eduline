import 'package:eduline/features/auth/bindings/auth_binding.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
  }
}
