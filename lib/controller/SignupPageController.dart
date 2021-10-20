import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/models/ChargerUser.dart';
import 'package:ez_mobile/services/FirebaseService.dart';
import 'package:get/get.dart';

class SignupPageController extends GetxController{
  RxString email = "".obs;
  RxString name = "".obs;
  RxString phone = "".obs;
  RxString pwd1 = "".obs;
  RxString pwd2 = "".obs;
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
  void nameChanged(String val){
    name.value = val;
  }
  void phoneChanged(String val){
    phone.value = val;
  }
  void pwd1Changed(String val){
    pwd1.value = val;
  }
  void pwd2Changed(String val){
    pwd2.value = val;
  }

  bool isValidInput(){
    if (email.value != null && name.value !=null && pwd1.value != null && pwd2.value !=null) {
      print("pwd1.value = ${pwd1.value}  pwd2.value =${pwd2.value}");
      if ((pwd1.value != pwd2.value)){
        errMSG = "Password & Re-enter password must be the same";
        return false;
      }
      return true;
    }else {
      errMSG = "Please fill in all field";
      return false;
    }




  }

  Future<bool> doRegister() async {
    print("doRegister -> enter");
    AuthController auth = Get.find<AuthController>();
    bool registerResult = await auth.createUserWithEmailAndPassword(email.value, pwd1.value,  ChargerUser(displayName: name.value, phone: phone.value, ));
    print("doRegister -> after createuser firebase");
    if (auth.user != null && registerResult){
      print("doRegister -> prepare for call registerUser");
      //bool registerResult =  await FirebaseService.instance.registerUser("ALFENs", auth.user, ChargerUser(displayName: name.value, phone: phone.value, ));
      print("doRegister => result ${registerResult}");
      return registerResult;
    }else{
      return false;
    }
  }

  resetVars(){
    email.value =null;
    pwd1.value =null;
    pwd2.value =null;
    name.value =null;
    phone.value =null;
  }
}