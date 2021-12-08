import 'dart:io';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/services/FirebaseService.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';

class ChangeAvatarController extends GetxController {
  RxString _imgPath = "".obs;

  RxBool _uploading = false.obs;

  get imgPath {
    if (_imgPath.value != null) {
      return _imgPath.value;
    } else {
      return 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png';
    }
  }

  set imgPath(String data) {
    _imgPath.value = data;
  }

  bool get isUploading => _uploading.value;
  set uploading(bool val) => _uploading.value = val;

  void changeAvatar() async {
    _uploading.value = true;
    AuthController auth = Get.find<AuthController>();
    final picker = ImagePicker();
    PickedFile pickedImage;
    pickedImage =
        await picker.getImage(source: ImageSource.camera, maxWidth: 1920);

    final String fileName = path.basename(pickedImage.path);
    File imageFile = File(pickedImage.path);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      // Uploading the selected image with some custom meta data
      Reference firebaseStorageRef =
          storage.ref().child("${auth.user.uid}/avatar/${fileName}");
      UploadTask uploadTask = firebaseStorageRef.putFile(
          imageFile,
          SettableMetadata(customMetadata: {
            'uploaded_by': 'EzEv',
            'description': 'Avatar',
            'uploadAt': DateTime.now().millisecondsSinceEpoch.toString(),
          }));
      uploadTask.whenComplete(() async {
        _imgPath.value = await firebaseStorageRef.getDownloadURL();
        auth.chargerUser.avatar = _imgPath.value;
        await FirebaseService.instance.updateChargerUser(auth.chargerUser, );

        Get.snackbar("Upload Done", "Your avarta has been updated", );


      });
    } on FirebaseException catch (error) {
      print(error);
      Get.snackbar("Error", error.toString(),colorText: Colors.redAccent, snackPosition: SnackPosition.TOP,
         // dismissDirection: SnackDismissDirection.HORIZONTAL,
          duration: Duration(minutes: 1));

    }finally{
      _uploading.value = false;
    }

  }
}
