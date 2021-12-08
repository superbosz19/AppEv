import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/models/ChargerUser.dart';
import 'package:ez_mobile/services/FirebaseService.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class IDCardController extends GetxController{
  RxBool _uploading = false.obs;
  bool get isUploading => _uploading.value;
  set uploading(bool val) => _uploading.value = val;

  RxString _idCardNo  =''.obs;

  get idCardNo => _idCardNo.value;
  set idCardNo(val) =>_idCardNo.value = val;

  RxString _idCardFront = "".obs;
  RxString _idCardBack = "".obs;

  String get idCardFront => _idCardFront.value;
  set idCardFront(String value) {
    _idCardFront.value = value;
  }

  String get idCardBack => _idCardBack.value;
  set idCardBack(String value) {
    _idCardBack.value = value;
  }

  bool _displayLocalFront = false;
  bool _displayLocalBack = false;

  RxBool _useLocalImage = false.obs;
  bool get useLocalImage {
    return _useLocalImage.value;
  }

  RxBool _idCardUpdate = false.obs;
  bool get idCardUpdate => _idCardUpdate.value;
  set idCardUpdate(bool val) => _idCardUpdate.value =val;

  String _origIDCardNo = "";


  @override
  void onInit() {
    _uploading.value = false;
    _idCardFront.value =Get.find<AuthController>().chargerUser.idCardImageFront;
    _idCardBack.value = Get.find<AuthController>().chargerUser.idCardImageBack;
    _origIDCardNo = Get.find<AuthController>().chargerUser.idCard;

    super.onInit();
  }
  void idCardChanged(val){
    _idCardNo.value =val;
    if (val == _origIDCardNo){
      idCardUpdate = false;
    }else{
      idCardUpdate =true;
    }
  }

  void doSave() async{
    print("doSave=> enter");
    uploading = true;
    var uploadPath ="";
    var auth = Get.find<AuthController>();
    var urlPath ="";
    ChargerUser chargerUser = auth.chargerUser;
    if (_displayLocalBack){
      uploadPath = "${auth.user.uid}/idcard/${path.basename(idCardBack)}";
      String urlPath = await uploadImage(uploadPath, File(idCardBack), "ID-Card (Back)" );
      if (urlPath == "UPLOAD_ERROR"){
        return;
      }else{
        idCardBack = urlPath;
        chargerUser.idCardImageBack = idCardBack;
        _displayLocalBack =false;
      }

    }

    if (_displayLocalFront){
      uploadPath = "${auth.user.uid}/idcard/${path.basename(idCardFront)}";
      String urlPath = await uploadImage(uploadPath, File(idCardFront), "ID-Card (Back)" );
      if (urlPath == "UPLOAD_ERROR"){
        return;
      }else{
        idCardFront = urlPath;
        chargerUser.idCardImageFront = idCardFront;
        _displayLocalFront =false;
      }

    }
    if (idCardUpdate){
      chargerUser.idCard = idCardNo;
    }

    //upload data to firebase
    try {
      await FirebaseService.instance.updateChargerUser(chargerUser);
      _origIDCardNo = Get.find<AuthController>().chargerUser.idCard;
      _displayLocalBack = false;
      _displayLocalFront =false;
      _origIDCardNo = chargerUser.idCard;


      Get.snackbar("Success", "Data uploaded.",duration: Duration(seconds: 5));

    }catch(error){
      print(error);
      Get.snackbar("Error", error.toString(),colorText: Colors.redAccent, snackPosition: SnackPosition.TOP,
         // dismissDirection: SnackDismissDirection.HORIZONTAL,
          duration: Duration(minutes: 1));

    }finally{
      uploading = false;
    }

  }
  Future<String> uploadImage(String uploadPath, File imageFile, String description) async{
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      // Uploading the selected image with some custom meta data
      Reference firebaseStorageRef =
      storage.ref().child(uploadPath);
      await firebaseStorageRef.putFile(
          imageFile,
          SettableMetadata(customMetadata: {
            'uploaded_by': 'EzEv',
            'description':  description,
            'uploadAt': DateTime.now().millisecondsSinceEpoch.toString(),
          }),
      );

      return await firebaseStorageRef.getDownloadURL();
    } on FirebaseException catch (error) {
      print(error);
      Get.snackbar("Error", error.toString(),colorText: Colors.redAccent, snackPosition: SnackPosition.TOP,
         // dismissDirection: SnackDismissDirection.HORIZONTAL,
          duration: Duration(minutes: 1));
      return "UPLOAD_ERROR";
    }
  }

  Future<String> updateImage() async {
    //just update not yet put to server
    PickedFile pickedImage;
    final picker = ImagePicker();
    pickedImage = await picker.getImage(source: ImageSource.camera, maxWidth: 1920);
    final String fileName = path.basename(pickedImage.path);

    return pickedImage.path;



  }
  void updateIDCardImageFront() async{
    _idCardFront.value = await updateImage();
    _displayLocalFront = true;
    _useLocalImage.value = (_displayLocalFront || _displayLocalBack);
  }

  void updateIDCardImageBack() async{
    _idCardBack.value = await updateImage();
    _displayLocalBack = true;
    _useLocalImage.value = (_displayLocalFront || _displayLocalBack);
  }
  ImageProvider<Object> getImage(bool front){
    if (front){
      if (_displayLocalFront){
       return FileImage(
           File(idCardFront),
       );
      }else{
        return NetworkImage(idCardFront);
      }
    }else{
      if (_displayLocalBack){
        return FileImage(
          File(idCardBack),
        );
      }else{
        return NetworkImage(idCardBack);
      }

    }

  }


}