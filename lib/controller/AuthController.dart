import 'dart:async';

import 'package:ez_mobile/models/ChargerUser.dart';
import 'package:ez_mobile/services/FirebaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class AuthController extends GetxController{
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _fbUser;

  Rx<ChargerUser> _chargerUser = ChargerUser().obs;

  User get user => _fbUser.value;
  ChargerUser get chargerUser => _chargerUser.value;



  @override
  void onInit() {
    _fbUser = _auth.currentUser.obs;
    _fbUser.bindStream(_auth.authStateChanges());
    loadUser();


    super.onInit();
  }



  void loadUser() {
    try  {
      if (user != null) {
       // _chargerUser.value = await FirebaseService.instance.fetchUser(user.uid);

        //_chargerUser.bindStream(FirebaseService.instance.fetchUserAsStream(user.uid));
        _chargerUser.bindStream(FirebaseService.instance.fetchUserAsStream2(user.uid));

      }
    }catch(e){
      print(e.toString());
    }
  }

  Future<bool> createUserWithEmailAndPassword(String email, String pwd, ChargerUser chargerUser) async{
    try{

      await _auth.createUserWithEmailAndPassword(
          email: email,
          password: pwd,
      );
      bool success = await FirebaseService.instance.registerUser("ALFENs", user, chargerUser);
      if (success){
        ChargerUser tmp = await FirebaseService.instance.fetchUser( user.uid);
        _chargerUser.value = tmp;
       }
      return success;
    }catch(e){
      Get.snackbar("Error: create user", e.toString(), snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 5));
      print("error => ${e.toString()}");
      return false;

    }
  }

  Future<bool> login(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      loadUser();
      return true;
    }catch(e){
      Get.snackbar("Error: login error ",
          e.toString(),
          duration: Duration(minutes: 2),
          snackPosition: SnackPosition.TOP, isDismissible: true);
      return false;
    }
  }

  void logout() async{
    try{
      await _auth.signOut();
      _chargerUser.value = null;
      _fbUser.value = null;
    }catch(e){
      Get.snackbar("Error: logout error ", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}