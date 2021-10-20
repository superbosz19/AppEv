import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/models/ChargerUser.dart';
import 'package:ez_mobile/services/FirebaseService.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  RxString email = "".obs;
  RxString pwd1 = "".obs;
  String errMSG = "";

  RxBool _showLoading = false.obs;

  bool get isShowLoading => _showLoading.value;
  set showLoading(bool val) => _showLoading.value = val;

  @override
  void onInit() {
    super.onInit();
    // debounce(email, validations, time: Duration(milliseconds: 500));
  }
  void emailChanged(String val){
    email.value = val;
  }

  void pwd1Changed(String val){
    pwd1.value = val;
  }


  bool isValidInput(){
    if (email.value != null && pwd1.value != null ) {
      return true;
    }else {
      errMSG = "Please fill in all field";
      return false;
    }

  }

  Future<void> doLogin() async {
    final auth = Get.find<AuthController>();
    bool success = await auth.login(email.value, pwd1.value);
    if (success ){
      Get.offAndToNamed("/");
    }else{

    }


  }

  resetVars() {
    email.value = null;
    pwd1.value = null;
  }
}