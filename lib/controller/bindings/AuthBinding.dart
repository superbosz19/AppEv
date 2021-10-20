import 'package:ez_mobile/controller/AuthController.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<AuthController>(() => AuthController());
  }

}