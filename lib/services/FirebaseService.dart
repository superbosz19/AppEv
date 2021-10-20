import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/models/ChargerUser.dart';
import 'package:ez_mobile/models/charger.dart';
//import 'package:ez_mobile/view/pages/favorite/FavoritePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
class FirebaseService{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseService instance = FirebaseService();
  static final String CHARGER_LOCATION = "charger-locations";
  static final String CHARGER = "chargers";
  static final String CHARGER_USER = "charger-users";
  static final String CHARGER_TRANSACTION = "charge-transactions";
  static final String CHARGER_HISTORY_USER = "user-charge-historians";
  static final String CHARGER_HISTORY_CHARGER = "charger-charge-historians";
  static final String CHARGER_CHARGERLOC_MAPPING = "charger-location-mapping";
  static final String CHARGE_HISTORY = "user-charge-historians";
  Geoflutterfire _geo;

  FirebaseService(){
    _geo =  Geoflutterfire();
  }

  Future<bool> registerUser(platform, User user, ChargerUser chargerUser) async{
    print("firebase registerUser -> enter  ");
    try {
      final d1 = await _firestore.collection(
          "user-code-mapping/${platform}/available").orderBy("create-at").limit(
          1).get();
      if (d1.docs.isEmpty) {
        Get.snackbar("Error",
          "User code is not enough",
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING,
        );
        return false;
      } else {
        var uCode = d1.docs.first.get("u-code");
        await _firestore.collection("user-code-mapping/${platform}/available")
            .doc(uCode)
            .delete();
        await _firestore.collection("user-code-mapping/${platform}/taken").doc(
            uCode).set(
            {
              "taken-at": DateTime
                  .now()
                  .millisecondsSinceEpoch,
              "u-code": uCode,
              "taken-by": user.uid,

            }
        );
        await _firestore.collection("charger-users").doc(user.uid).set(
            {
              "userID": user.uid,
              "firstName": chargerUser.displayName,
              "lastName": chargerUser.displayName,
              "email": user.email,
              "userKeys": { platform: uCode},
              "phone" : chargerUser.phone,
            }
        );
        return true;
      }
    }catch(e){
      Get.snackbar("Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
      );
      return false;
    }


    }

    Future<void> updateChargerUser(ChargerUser ch){
      _firestore
          .collection(FirebaseService.CHARGER_USER)
          .doc(ch.userID).set(ch.mapValue);
    }

    Future<ChargerUser> fetchUser(String uid) async{
      var docRef = _firestore
          .collection(FirebaseService.CHARGER_USER)
          .doc(uid);
      var document = await docRef.get();
      return ChargerUser.fromFirebase(document);

    }
  Stream<ChargerUser> fetchUserAsStream(String uid) {
    var docRef = _firestore
        .collection(FirebaseService.CHARGER_USER)
        .doc(uid);
    return docRef.snapshots().map((data){
      return ChargerUser.fromFirebase(data);
    });
    //return ChargerUser.fromFirebase(document);

  }
  Future<bool> isChargerExist(String chargerLocID, String chargerID) async {
    var docRef = await _firestore
        .collection("${FirebaseService.CHARGER_LOCATION}/${chargerLocID}/chargers" )
        .doc(chargerID).get();
    return docRef.exists;
  }

  Future<Map<String,dynamic>> isChargerExist2( String chargerID) async {
    print("enter isChargerExist2 ");
    var docs = await _firestore
        .collection("${FirebaseService.CHARGER_CHARGERLOC_MAPPING}").where("chargerID", isEqualTo: chargerID).get();
    print("doc-> ${docs}" );
    if (docs.docs.isEmpty){
     return {
       "exists" : false,
       "locationID" : null,
     };
    }else{
      return {"exists": true,
        "locationID": docs.docs.first["locationID"],
      };

    }
  }


  Future<ChargerLocation> getChargerLocation(String chargerLocID) async {
    var docRef = _firestore
        .collection(FirebaseService.CHARGER_LOCATION)
        .doc(chargerLocID);
    var document = await docRef.get();
    var chargerLoc = ChargerLocation.fromFirebase(document);
    return chargerLoc;
  }

  Stream<ChargerLocation> getChargerLocationSnapshot(String chargerLocID)   {
    var docRef = _firestore
        .collection(FirebaseService.CHARGER_LOCATION)
        .doc(chargerLocID);
    return docRef.snapshots().map((data) => ChargerLocation.fromFirebaseSnapshot(data));
    // var docRef = _firestore
    //     .collection(FirebaseService.CHARGER_LOCATION)
    //     .doc(chargerLocID);
    //
    // return docRef.snapshots().map((doc) => ChargerLocation.fromFirebaseSnapshot(doc));
    //
    // // return docRef.snapshots().map(
    // //         (doc1) async {
    // //           List<Charger> chargers1 =  await _firestore
    // //               .collection("${FirebaseService.CHARGER_LOCATION}/${doc1.id}/${FirebaseService.CHARGER}")
    // //               .snapshots().toList();
    // //
    // //           return null;
    // //
    // //
    // //
    // //         }
    // // );



  }

  Future<ChargerLocation> getChargerLocationSnapshot1(String chargerLocID)  async {
    var docRef = _firestore
        .collection(FirebaseService.CHARGER_LOCATION)
        .doc(chargerLocID);
    var doc = await docRef.get();
    return ChargerLocation.fromFirebaseSnapshot(doc);
    // var docRef = _firestore
    //     .collection(FirebaseService.CHARGER_LOCATION)
    //     .doc(chargerLocID);
    //
    // return docRef.snapshots().map((doc) => ChargerLocation.fromFirebaseSnapshot(doc));
    //
    // // return docRef.snapshots().map(
    // //         (doc1) async {
    // //           List<Charger> chargers1 =  await _firestore
    // //               .collection("${FirebaseService.CHARGER_LOCATION}/${doc1.id}/${FirebaseService.CHARGER}")
    // //               .snapshots().toList();
    // //
    // //           return null;
    // //
    // //
    // //
    // //         }
    // // );



  }

  Stream<List<Charger>> fetchChargersByLocationID(String locationID){
    print("fetchChargersByLocationID=>${FirebaseService.CHARGER_LOCATION}/${locationID}/${FirebaseService.CHARGER}");
    return _firestore
        .collection("${FirebaseService.CHARGER_LOCATION}/${locationID}/${FirebaseService.CHARGER}")
        .snapshots().map(
            (docs) {
              return docs.docs.map((doc){
                print("Charger.fromFirebase(=>refetch for ${doc["chargerName"]}");
                return Charger.fromFirebase(doc);
              }).toList();
            });
  }

  Future<List<Charger>> fetchChargersByLocationID1(String locationID) async{
    print("fetchChargersByLocationID1=>${FirebaseService.CHARGER_LOCATION}/${locationID}/${FirebaseService.CHARGER}");

    var docs = await _firestore
        .collection("${FirebaseService.CHARGER_LOCATION}/${locationID}/${FirebaseService.CHARGER}").get();

    List<Charger> ret = [];
    for (var doc in docs.docs){
      print("fetchChargersByLocationID1->Charger.fromFirebase(=>refetch for ${doc["chargerName"]}");
      ret.add(Charger.fromFirebase(doc));
    }
    return ret;
  }



  Stream<List<ChargerLocation>>  fetchChargerLocationsByGeo(LatLng pos, String collectionName, double rad)  {
    GeoFirePoint center = _geo.point(latitude: pos.latitude, longitude: pos.longitude);
    var ref = _firestore.collection(collectionName);

    print("FirebaseService.fetchChargersLocByGeo=> ${center.latitude} , ${center.longitude} => ref=> ${ref}");
    return _geo.collection(collectionRef: ref).within(
        center: center,
        radius: rad,
        field: 'position',
        strictMode: true
    ).map(( List<DocumentSnapshot<Map<String, dynamic>>> chlDocs) {
      return chlDocs.map((DocumentSnapshot<Map<String, dynamic>> chlDoc){
        return ChargerLocation.fromFirebase(chlDoc);
      }).toList();
    });
  }
  double getDistanceFrom2Point(LatLng orig, LatLng dest){
    double distance = _geo
        .point(latitude: orig.latitude, longitude: orig.longitude)
        .distance(lat: dest.latitude, lng: dest.longitude);
    print("distance => ${distance}");

    return distance;
  }

  Future<void> startCharging(ChargerTransaction chargerTran ) async{
    print("startCharging => ${chargerTran.toMap()} ");
    await _firestore
        .collection(FirebaseService.CHARGER_TRANSACTION)
        .doc(chargerTran.transID).set(chargerTran.toMap());


  }

  Future<void> stopCharging(ChargerTransaction chargerTran, {String chargeStatus:"WAIT_STOP"} ) async{
    print("stopCharging: ${chargeStatus}");
    var updMsg = {
      "status" : chargeStatus, //"WAIT_STOP"
      "stopAt" : DateTime
          .now()
          .millisecondsSinceEpoch

    };

    if (chargeStatus == "FAILED"){
      chargeStatus = "FINISH";
    }


    await _firestore
        .collection(FirebaseService.CHARGER_TRANSACTION)
        .doc(chargerTran.transID).update(updMsg);

  }

  Future<void> finshTransaction(ChargerTransaction chargerTran) async {
    await _firestore
        .collection("${FirebaseService.CHARGER_HISTORY_USER}/${chargerTran.chargerUserID}/all-trans")
        .doc(chargerTran.transID).set(chargerTran.toMap());

    final startDT= DateTime.fromMillisecondsSinceEpoch(chargerTran.startAt);

    await _firestore
        .collection("${FirebaseService.CHARGER_HISTORY_USER}/${chargerTran.chargerUserID}/${startDT.year}/${startDT.month}/${startDT.day}")
        .doc(chargerTran.transID).set(chargerTran.toMap());

    //charger
    await _firestore
        .collection("${FirebaseService.CHARGER_HISTORY_CHARGER}/${chargerTran.chargerID}/all-trans")
        .doc(chargerTran.transID).set(chargerTran.toMap());

    await _firestore
        .collection("${FirebaseService.CHARGER_HISTORY_CHARGER}/${chargerTran.chargerID}/connectors/${chargerTran.connectorID}/trans")
        .doc(chargerTran.transID).set(chargerTran.toMap());



    await _firestore
        .collection(FirebaseService.CHARGER_TRANSACTION)
        .doc(chargerTran.transID).delete();
  }

  Stream<ChargerTransaction> fetchActiveChargingTransaction(String transID ) {
    return _firestore
        .collection(FirebaseService.CHARGER_TRANSACTION)//.where("status", isEqualTo: "INIT").where("transID", isEqualTo: transID)
        .doc(transID).snapshots().map(
            (doc){
              return ChargerTransaction.fromFireStore(doc);
            }
    );


  }

  Future<bool> isCreditCardExist(CardInfo cardInfo, String userID ) async{
    print("card => ${cardInfo.cardNo}");
    var doc = await  _firestore.collection("${FirebaseService.CHARGER_USER}/${userID}/cards")
        .doc(
        cardInfo.cardNo
    ).get();
    return doc.exists;

  }

  Future<void> addCreditCard(CardInfo cardInfo, String userID ) async{
     await _firestore
        .collection("${FirebaseService.CHARGER_USER}/${userID}/cards")
        .doc(cardInfo.cardNo).set( cardInfo.toMap());

  }

  Future<void> triggerFav(String userId, String chargerLocId) async{
    var doc = await  _firestore
        .collection("${FirebaseService.CHARGER_USER}/${userId}/favs").doc(chargerLocId).get();
    if (doc.exists){
      return await _firestore
          .collection("${FirebaseService.CHARGER_USER}/${userId}/favs").doc(chargerLocId).delete();

    }else{
      return _firestore
          .collection("${FirebaseService.CHARGER_USER}/${userId}/favs").doc(chargerLocId).set(
        {
          "chargerLocID" : chargerLocId,
        }
      );
    }

  }

  Stream<ChargerUser> fetchUserAsStream2(String uid)  {
    var docRef = _firestore
        .collection(FirebaseService.CHARGER_USER)
        .doc(uid);
    var docRef2 = _firestore
        .collection("${FirebaseService.CHARGER_USER}/${uid}/cards");

    var docRef3 = _firestore
        .collection("${FirebaseService.CHARGER_USER}/${uid}/favs");
    print("uid=>${uid}");
    print("before combine");
    return CombineLatestStream.list([
      docRef.snapshots(),
      docRef2.snapshots(),
      docRef3.snapshots(),
    ]
    ).asyncMap(
            (value) {
              print("loaduser=> value=> ${value}");
          var ch = ChargerUser.fromFirebase(value.first);
          print("ch=> ${ch.displayName}");
          var cards = value[1] as QuerySnapshot;
          List<CardInfo> cardInfos = [];
          for (var doc in cards.docs) {
            cardInfos.add(
                CardInfo.fromFireStore(doc as DocumentSnapshot)
            );
          }
          ch.cards = cardInfos;
          print("ch= ${ch} => ${ch.cards.length}");

          var favs = value.last as QuerySnapshot;
          Map<String, dynamic> favsInfo = Map<String, dynamic>();
          for(var doc in favs.docs){
            favsInfo[doc["chargerLocID"]] = doc["chargerLocID"];
          }
          ch.favs = favsInfo;


          return ch;
        }
    );

  }

  Stream<ChargerUser> fetchUserAsStream2OLD(String uid)  {
    var docRef = _firestore
        .collection(FirebaseService.CHARGER_USER)
        .doc(uid);
    var docRef2 = _firestore
        .collection("${FirebaseService.CHARGER_USER}/${uid}/cards");

    print("uid=>${uid}");
    print("before combine");
    return CombineLatestStream.list([
      docRef.snapshots(),
      docRef2.snapshots(),
    ]
    ).asyncMap(
            (value) {
          var ch = ChargerUser.fromFirebase(value.first);
          print("ch=> ${ch.displayName}");
          var cards = value.last as QuerySnapshot;
          List<CardInfo> cardInfos = [];
          for (var doc in cards.docs) {
            cardInfos.add(
                CardInfo.fromFireStore(doc as DocumentSnapshot)
            );
          }
          ch.cards = cardInfos;
          print("ch= ${ch} => ${ch.cards.length}");
          return ch;
        }
    );




  }
  Stream<List<ChargeHistory>> fetchHistories(String uid){
    final trans = _firestore.collection("${FirebaseService.CHARGE_HISTORY}/${uid}/all-trans");
    return trans.snapshots().map(
            (docs){
              return docs.docs.map((doc){
                 ChargeHistory cHist = ChargeHistory.fromFirebase(doc);
                 return cHist;
              }).toList();

            });
  }

  //Future<Map<String, Map<String, Map<String, Map<String, ChargeHistory> > >>>
  Future<ChargeHistories> fetchHistories2(String uid) async{
    final trans = _firestore.collection("${FirebaseService.CHARGE_HISTORY}/${uid}/all-trans");
    QuerySnapshot docs = await trans.get();
    Map<String, Map<String, Map<String, Map<String, ChargeHistory> > >> mainHist = Map<String, Map<String, Map<String, Map<String, ChargeHistory> > >>();
    print("fetchHistories2=> docs.docs=>${docs.docs.length}");
    for (var doc in docs.docs){
      print("fetchHistories2=> docs=>${doc}");
      ChargeHistory cHist = ChargeHistory.fromFirebase(doc);
      print("fetchHistories2=> cHist=> ${cHist}");
      //mainHist[cHist.year][cHist.month][cHist.day][cHist.key] = cHist;
      if (mainHist.containsKey(cHist.year)){
        if (mainHist[cHist.year].containsKey(cHist.month)){
          if (mainHist[cHist.year][cHist.month].containsKey(cHist.day) ){
            mainHist[cHist.year][cHist.month][cHist.day][cHist.key] = cHist;
          }else{
            //mainHist[cHist.year][cHist.month][cHist.day][cHist.key] = cHist;
            mainHist[cHist.year][cHist.month][cHist.day] = {
              cHist.key : cHist
            };
          }
        }else{
          //mainHist[cHist.year][cHist.month][cHist.day][cHist.key] = cHist;
          mainHist[cHist.year][cHist.month] ={
            cHist.day.toString() : {
              cHist.key : cHist
            }

          };
        }
      }else{
        mainHist[cHist.year] = {
          cHist.month : {
            cHist.day : {
              cHist.key : cHist,
            }
          }
        } ;
      }
    }
    print("fetchHistories2=>mainHist = ${mainHist}");
    return ChargeHistories(histories: mainHist, loadDone:true);
  }

}