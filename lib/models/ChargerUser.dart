import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:ez_mobile/models/charger.dart';
import 'package:ez_mobile/view/components/EncryptUtil.dart';

class CardInfo {
  bool primary;
  String cardNo;
  String expiryDate;
  String cvv;
  String bankName;
  String cardHolder;

  CardInfo(
      {this.primary, this.cardHolder, this.cardNo, this.bankName, this.cvv, this.expiryDate});

  String get maskedCardNo {
    final ret = cardNo.split(" ");

    if (ret.length == 4) {
      return ret[0] + "-xxxx-xxxx-" + ret[3];
    }else{
      return cardNo.substring(0, 4) +"-xxxx-xxxx-" + cardNo.substring(13);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "primary": primary,
      "cardNo": EncryptUtil.encrypt(cardNo),
      "expiryDate": EncryptUtil.encrypt(expiryDate),
      "cvv": EncryptUtil.encrypt(cvv),
      "bankName": bankName,
      "cardHolder": cardHolder,
    };
  }

  String get cardNoEncrypt => EncryptUtil.encrypt(cardNo);

  factory CardInfo.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc){
    var cardNoDecrypt = "";
    var cvvDecrypt = "";
    var expiryDecrypt = "";

    if (doc["cardNo"] != null) {
      cardNoDecrypt = EncryptUtil.decrypt(doc["cardNo"]);
    }
    if (doc["cvv"] != null) {
      cvvDecrypt = EncryptUtil.decrypt(doc["cvv"]);
    }

    if (doc["expiryDate"] != null) {
      expiryDecrypt = EncryptUtil.decrypt(doc["expiryDate"]);
    }
    return CardInfo(
      primary: doc["primary"] ?? false,
      cardNo: cardNoDecrypt,
      expiryDate: expiryDecrypt,
      cvv: cvvDecrypt,
      bankName: doc["bankName"] ?? "",
      cardHolder: doc["cardHolder"] ?? "",
    );
  }

}
class ChargerUser{
  String displayName;
  String firstName;
  String lastName;
  String email;
  Map<String, dynamic> userKeys;
  String userID;
  String phone;
  String avatar;
  String idCard;
  bool verified;

  String idCardImageFront;
  String idCardImageBack;

  List<CardInfo> cards;

  Map<String, dynamic> favs;

  List<PendingPayment> pendingPayments;
  ChargerUser({this.email, this.displayName, this.firstName, this.lastName, this.userID, this.userKeys, this.phone, this.avatar,this.verified,
    this.idCardImageFront, this.idCardImageBack,
  this.idCard, this.favs, this.pendingPayments});

  String get primaryID {
    if (userKeys != null && userKeys.isNotEmpty && userKeys.containsKey("ALFENs")){
      return userKeys["ALFENs"];
    }else{
      return "";
    }
  }

  bool isFav(String chargerLocId){
    print("isFav-> ${favs}");
    if (favs!= null && favs.containsKey(chargerLocId)){
      print("${chargerLocId} =>isFav = true");
      return true;
    }else{
      print("${chargerLocId} =>isFav = false");
      return false;
    }
  }
  factory ChargerUser.fromFirebase(DocumentSnapshot<Map<String, dynamic>> doc){

    return ChargerUser(
      displayName:  doc.data()["firstName"] ?? "",
      firstName:  doc.data()["firstName"] ?? "",
      lastName:  doc.data()["lastName"] ?? "",
      userID:  doc.data()["userID"] ?? "",
      userKeys:  doc.data()["userKeys"] ?? "",
      email : doc.data()["email"] ?? "",
      phone : doc.data()["phone"] ?? "",
      avatar: doc.data()["avatar"] ?? "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg",
      idCard: doc.data()["idCard"] ?? "",
      verified: doc.data()["verified"] ?? false,
      idCardImageBack :  doc.data()["idCardImageBack"] ?? "https://upload.wikimedia.org/wikipedia/common"
          "s/a/ac/No_image_available.svg",
      idCardImageFront : doc.data()["idCardImageFront"] ?? "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg",
      favs:  doc.data()["favs"] ?? {},
      pendingPayments : doc.data()["pendingPayments"] ?? [],
    );
  }



  Map<String, dynamic> get mapValue {
    Map<String,dynamic> values = {};

    values = {
      "displayName":  displayName,
      "firstName":  firstName,
      "lastName":  lastName,
      "userID":  userID,
      "userKeys":  userKeys,
      "email" : email,
      "phone" : phone,
      "avatar": avatar,
      "idCard": idCard,
      "verified": verified,
      "idCardImageBack": idCardImageBack,
      "idCardImageFront" : idCardImageFront,
      "pendingPayments" : pendingPayments,


    };
    return values;


  }
}

class PendingPayment{
  String TransID;
  String TransBase;
  Double amount;
  String ChargerID;
  String ChargerLocation;

}