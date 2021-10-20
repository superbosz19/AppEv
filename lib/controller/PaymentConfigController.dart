import 'package:get/get.dart';

class PaymentConfigController extends GetxController{

  RxString cardNo = "".obs;
  RxString cardExp = "".obs;
  RxString cardCVV = "".obs;
  RxString cardHolder = "".obs;

  RxString errMSG = "".obs;

  RxBool primary = false.obs;

  void primaryChanged(bool val){
    primary.value = val;
  }

  void cardNoChanged(String val){
    cardNo.value = val;
  }
  void cardExpChanged(String val){
    cardExp.value = val;
  }
  void cardCVVChanged(String val){
    cardCVV.value = val;
  }
  void cardHolderChanged(String val){
    cardHolder.value = val;
  }
  bool isValidInput(){

    if (cardNo.value.isNotEmpty &&
        cardCVV.value.isNotEmpty &&
        cardHolder.isNotEmpty &&
        cardExp.value.isNotEmpty) {
     return true;
    }else {
      errMSG.value = "Please fill in all field";
      return false;
    }




  }

  @override
  void onInit() {
    super.onInit();
  }

}