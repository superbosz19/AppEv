import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/models/ChargerUser.dart';
import 'package:ez_mobile/services/FirebaseService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  RxString email = "".obs;
  RxString phone = "".obs;
  String errMSG = "";
  RxBool _uploading = false.obs;
  bool get isUploading => _uploading.value;
  set uploading(bool val) => _uploading.value = val;

  void emailChanged(String val){
    email.value = val;
  }
  void phoneChanged(String val){
    print("phoneChanged val=> ${val}");
    phone.value = val;
    print("phoneChanged phone.value=> ${phone.value}");
  }
  doSave() async{
    _uploading.value = true;
    try {
      ChargerUser ch = Get
          .find<AuthController>()
          .chargerUser;
      ch.email = email.value;
      ch.phone =phone.value;
      print("phone.value before updae = ${phone.value}");
      await FirebaseService.instance.updateChargerUser(ch,);

      Get.snackbar("Success", "Your profile updated", );
    }catch(error){
      print(error);
      Get.snackbar("Error", error.toString(),colorText: Colors.redAccent, snackPosition: SnackPosition.TOP,
         // dismissDirection: SnackDismissDirection.HORIZONTAL,
          duration: Duration(minutes: 1));

    }finally{
      _uploading.value = false;
    }

  }




}
