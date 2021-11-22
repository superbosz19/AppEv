import 'dart:async';

import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/models/ChargerUser.dart';
import 'package:ez_mobile/models/charger.dart';
import 'package:ez_mobile/models/searchCriteria.dart';
import 'package:ez_mobile/services/FirebaseService.dart';
import 'package:ez_mobile/view/pages/ConfirmPayment/ConfirmPaymentPage.dart';
import 'package:ez_mobile/view/pages/CreditcardPay/CreditCardPayPage.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:maps_launcher/maps_launcher.dart';

class GMapController extends GetxController {
  Rx<Position> _position = Position(latitude: 0, longitude: 0, speed: 0, accuracy: 0, ).obs;
  final RxBool _locationLoaded = false.obs;

  Rx<CameraPosition> _camPos = CameraPosition(
      target: LatLng(
    0,
    0,
  )).obs;

  bool get isLocationLoaded => _locationLoaded.value;
  Position get position => _position.value;
  CameraPosition get cameraPosition => _camPos.value;

  //List<ChargerLocation> _chargerLocs = [];
  RxSet<Marker> _markers = Set<Marker>().obs;
  Set<Marker> get markers => _markers.value;

  RxBool _isLocationSelected = false.obs;

  final double zoom;

  Position _prevPosition;

  LatLng _baseLocation;
  GoogleMapController _googleMapController;


  // ignore: unnecessary_getters_setters
  GoogleMapController get googleMapController => _googleMapController;

  // ignore: unnecessary_getters_setters
  set googleMapController(GoogleMapController value) {
    _googleMapController = value;
  }

  GMapController({this.zoom: 15});

  bool get isLocationSelect => _isLocationSelected.value;

  double _screenW  = 0.0;
  double _screenH = 0.0;

  // ignore: unnecessary_getters_setters
  double get screenW => _screenW;
  // ignore: unnecessary_getters_setters
  double get screenH => _screenH;

  // ignore: unnecessary_getters_setters
  set screenW(double data){
    _screenW = data;
  }

  // ignore: unnecessary_getters_setters
  set screenH(double data){
    _screenH = data;
  }

  LatLng get baseLocation => _baseLocation;

  BitmapDescriptor _markerIcon;

  RxBool _alreadyScan = false.obs;

  bool get alreadyScan => _alreadyScan.value;
  set alreadyScan(bool val){
    _alreadyScan.value = val;
  }

  @override
  void onInit() {
    _prevPosition = null;
    _charger.value = null;
    //load marker
    // BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(devicePixelRatio: 0.01),
    //     'images/marker.png').then((onValue) {
    //   _markerIcon = onValue;
    // });

    getBytesFromAsset('images/marker2.png', 128).then((onValue) {
      print("before load marker");
      _markerIcon = BitmapDescriptor.fromBytes(onValue);
      print("after load marker => ${_markerIcon}");

    });
    //finish load marker


    getUserLocation();
    super.onInit();
  }

  void setMarker(LatLng centerPoint) async {
    print("setMarker=>for ${FirebaseService.CHARGER_LOCATION}");
    if (_prevPosition != null) {
      double newDistance = FirebaseService.instance.getDistanceFrom2Point(
        LatLng(_prevPosition.latitude, _prevPosition.longitude),
        LatLng(position.latitude, position.longitude),
      );
      print("new distance => ${newDistance}");
      // if (newDistance < 1) {
      //   return;
      // }
    }
    Stream<List<ChargerLocation>> stream =
        await FirebaseService.instance.fetchChargerLocationsByGeo(
      centerPoint,
      FirebaseService.CHARGER_LOCATION,
      5,
    );
    Set<Marker> tmpM = Set<Marker>();
    stream.listen((List<ChargerLocation> docs) {
      for (var doc in docs) {
        double distance = FirebaseService.instance.getDistanceFrom2Point(
           _baseLocation,
            LatLng(
              doc.geoPoint.latitude,
              doc.geoPoint.longitude,
            ));
        tmpM.add(Marker(
         // consumeTapEvents: true,
          markerId: MarkerId(DateTime.now().millisecondsSinceEpoch.toString()),
          position: LatLng(doc.geoPoint.latitude, doc.geoPoint.longitude),
          //icon: _markerIcon,
          icon: _markerIcon==null?BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen): _markerIcon,
          onTap: () {
            print("marker click");
            clearChargerLocSubScription();
            print("clear subscription");
            _chargerLocSubScription =  FirebaseService.instance.getChargerLocationSnapshot(doc.locationID).listen((ChargerLocation doc1) {
              print("doc1.locationID=> ${doc1.locationID}");
              FirebaseService.instance.fetchChargersByLocationID(doc1.locationID).listen((List<Charger> chargers) {
                print("setmarker dic1.chargers=> ${doc1.chargers}");
                doc1.chargers = chargers;
                _chargerLoc.value = doc1;
                _isLocationSelected.value = true;
                _showSearch.value = false;
              });

            });
          },

          infoWindow: InfoWindow(
              title: ' ${doc.locationName} Distance: ${distance} kilometers'),
        ));
      }
      _markers.value = tmpM;
      //_markers.assignAll(tmpM);
    });
  }

  void getUserLocation() async {
    print("getUserLocation");
    _position.value = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //set value to prevposition

    LatLng latLng = LatLng(
      position.latitude,
      position.longitude,
    );
    _baseLocation = LatLng(
      position.latitude,
      position.longitude,
    );
    _camPos.value = CameraPosition(
      target: latLng,
      zoom: this.zoom,
    );
    await setMarker(latLng);
    _prevPosition = Position(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    _locationLoaded.value = true;
  }

  void updatePosition(double lat, double lng) {
    _position.value = Position(
      latitude: lat,
      longitude: lng,
    );
  }

  void toCurrentLocation() async{
    _position.value = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng latLng = LatLng(
      position.latitude,
      position.longitude,
    );
    _baseLocation = LatLng(
      position.latitude,
      position.longitude,
    );
    _camPos.value = CameraPosition(
      target: latLng,
      zoom: this.zoom,
    );

    // await setMarker(latLng);
    // _prevPosition = Position(
    //   latitude: position.latitude,
    //   longitude: position.longitude,
    // );
    print("do animate camera");
    _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _baseLocation,
            zoom: 14,
          ),
        ),
    );
  }

  void moveCameraEnd() async {
    LatLng centerPos = LatLng(
      position.latitude,
      position.longitude,
    );
    // Charger ch = await FirebaseService.instance.getCharger("MIMEIT");
    // print("ch=> ${ch} => ch.id=> ${ch.chargerId}");
    //_locationLoaded.value =false;
    await setMarker(centerPos);

    _prevPosition = Position(
      latitude: position.latitude,
      longitude: position.longitude,
    );

    //_locationLoaded.value =true;
  }

  _handleMarkerTap(locationID) async {
    print("marker click==> ${locationID}");
    clearChargerLocSubScription();
    _chargerLocSubScription = FirebaseService.instance.getChargerLocationSnapshot(locationID).listen((ChargerLocation doc) {

      FirebaseService.instance.fetchChargersByLocationID(doc.locationID).listen((List<Charger> chargers) {
        doc.chargers = chargers;
        _chargerLoc.value = doc;
        _isLocationSelected.value = true;
      });

    });


  }

  void clearChargerLocSubScriptionOld(){
    if (_chargerLocSubScription != null){
      _chargerLocSubScription.cancel();
      alreadyScan = false;
      chargerLoc = null;
      charger = null;
      connector = null;
    }


  }


  void clearChargerLocSubScription(){
      alreadyScan = false;
      chargerLoc = null;
      charger = null;
      connector = null;
  }

  void unloadSelectLocation(){
    clearChargerLocSubScription();
    _isLocationSelected.value = false;
    _charger.value = null;


  }


  @override
  void dispose(){
    clearChargerLocSubScription();
    super.dispose();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    print("before getBytesFromAsset enter ${path}");
    ByteData data = await rootBundle.load(path);
    print("before getBytesFromAsset after loadbundle");
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }



  prepareChargerOld(String chLocID, String chID, String cnnID) async{
    clearChargerLocSubScription();
    _chargerLocSubScription = await FirebaseService.instance.getChargerLocationSnapshot(chLocID).listen((ChargerLocation doc1) async {
      this.chargerLoc = doc1;
      await FirebaseService.instance.fetchChargersByLocationID(doc1.locationID).listen((List<Charger> chargers) {
        print("preparecharger=>dic1.chargers=> ${doc1.chargers}");
        doc1.chargers = chargers;
        //_chargerLoc.value = doc1;
        _isLocationSelected.value = true;
        bool found = false;
        for (var ch in chargers){
          if (ch.chargerId == chID){
            _charger.value = ch;
            alreadyScan =true;
            found = true;
            break;
          }
        }
        if (found){
          if (_charger.value.connectors.length == 1 && _charger.value.connectors.first.status  == "AVAILABLE"){
            //why i use this
            print("prepareCharger=>toSelectPayment");
            //for fix open payment page
            print("prepareCharger=>toSelectPayment=>before cancel subscription");
            _chargerLocSubScription.cancel();
            print("prepareCharger=>toSelectPayment=>after cancel subscription");
            toSelectPayment(_charger.value.connectors.first);
          }else {
            Get.offAllNamed("/");
          }
        }



      });

    });

  }

//change code from listen to await
  prepareCharger(String chLocID, String chID, String cnnID) async{
    clearChargerLocSubScription();

    chargerLoc  = await FirebaseService.instance.getChargerLocationSnapshot1(chLocID);
    List<Charger> chargers = await FirebaseService.instance.fetchChargersByLocationID1(chargerLoc.locationID);
    chargerLoc.chargers = chargers;
    _isLocationSelected.value = true;
    bool found = false;
    for (var ch in chargers){
      if (ch.chargerId == chID){
        _charger.value = ch;
        alreadyScan =true;
        found = true;
        break;
      }
    }
    if (found){
      if (_charger.value.connectors.length == 1 && _charger.value.connectors.first.status  == "AVAILABLE"){
        //why i use this
        print("prepareCharger=>toSelectPayment");
        //for fix open payment page
        print("prepareCharger=>toSelectPayment=>before cancel subscription");
        //_chargerLocSubScription.cancel();
        print("prepareCharger=>toSelectPayment=>after cancel subscription");
        toSelectPayment(_charger.value.connectors.first);
      }else {
        Get.offAllNamed("/");
      }
    }



  }

  void toSelectPayment(Connector cnn){
    if (alreadyScan) {
      connector = cnn;
      print("toSelectPayment=> before call select payment");
      //Get.offAllNamed("/select-payment");
      Get.toNamed("/select-payment");
    }else{
      Get.toNamed("/scan-qr");
      //Get.offAllNamed("/scan-qr");
    }
  }

  void unloadAllSelection(){

    unloadSelectLocation();
    connector = null;
    charger = null;
    chargerLoc = null;
    print("unloadAllSelection=> before call select payment");
    Get.toNamed("/select-payment");
  }

  Rx<ChargerLocation> _chargerLoc = ChargerLocation().obs;
  ChargerLocation get chargerLoc => _chargerLoc.value;
  set chargerLoc(ChargerLocation  chl) => _chargerLoc.value = chl;
  StreamSubscription<ChargerLocation> _chargerLocSubScription;

  Rx<Charger> _charger = Charger().obs;
  Charger get charger => _charger.value;
  set charger(Charger c) => _charger.value = c;

  Rx<Connector> _connector = Connector().obs;
  Connector get connector => _connector.value;
  set connector(Connector c) => _connector.value = c;


  //payment section




  void selectPayActual() async{
    if (Get.find<AuthController>().chargerUser.verified){
      //prepare charger transaction
      int ts = DateTime.now().millisecondsSinceEpoch;
      final chargerUser = Get.find<AuthController>().chargerUser;
      final transID = "${chargerUser.primaryID}_${ts}";
      final chargerTran = ChargerTransaction(
          transID: transID,
          startAt : ts,
          stopAt : 0,
          status : "INIT",
          chargerUserID : chargerUser.userID,
          chargerLocID : chargerLoc.locationID,
          chargerID : charger.chargerId,
          connectorID : connector.connectorId,
          identityKey : "",
          startCmd : "",
          chargeType : "ACTUAL",
          lockedAt : 0,
          unlockedAt : 0,
          vehicle : "",
          chargedBy:  chargerUser.primaryID,
          chargeRateKW : connector.chargePrice[0].actualUsage.chargeRateKW,
          chargeRatePerMin : connector.chargePrice[0].actualUsage.chargePerMinute,
      );



      //prepare charging actual in firebase
      await FirebaseService.instance.startCharging(chargerTran);
      print("bindstream for transaction=> ${transID}");


      _transaction.bindStream(FirebaseService.instance.fetchActiveChargingTransaction(transID));
      //Get.offAndToNamed("/charging-page");

      Get.offAllNamed("/charging-page");
      //Get.toNamed("/charging-page");

    }else{
      //proceed to verified page and
    }

  }

  String get chargeStatus {
    if (transaction == null || transaction?.status ==null){
      return "Prepare for backend...";
    }

    switch (transaction.status){
      case "INIT" :
        {
          return "Preapared";
        }
        break;
      case "WAIT_BACKEND" :{
        return "Waiting";
      }
      break;
      case "WAIT_PLUG":{
        return "Please Plug";

      }
      break;
      case "CHARGING":{
        return "Charging";

      }
      break;
      case "WAIT_STOP":{
        if (transaction.stopMeter != null && transaction.stopMeter == -1){
          return "Waiting for report";
        }else {
          return "Stopping";
        }

      }
      break;
      case "WAIT_UNPLUG":{
        if (transaction.stopMeter != null && transaction.stopMeter == -1){
          return "Waiting for report";
        }else {
          return "Please Un-plug";
        }
      }
      break;
      default: {
        return transaction.status;
      }
    }
  }
  stopCharger() async{
    if (timer != null){
      timer.cancel();
    }
    print("stopCharger=> chargerStatus=>${chargeStatus}");
    if (chargeStatus == "FAILED"){
      await FirebaseService.instance.stopCharging(transaction,chargeStatus:"FINISH");
    }else{
      await FirebaseService.instance.stopCharging(transaction);
    }

  }
  finishCharge(){
    if (timer != null){
      timer.cancel();
    }

    Future.microtask(() => Get.offAndToNamed("/charge-result"));
    //Future.microtask(() => Get.toNamed("/charge-result"));

  }
  startTimer(){
    if (timer !=null){
      timer.cancel();
    }
    _chargingTimeDisplay.value = "00:00 h";
    if (1==1) {
      timer = Timer.periodic(Duration(minutes: 1), (timer) {
        // (DateTime.now().millisecondsSinceEpoch -  transaction.startAt)..ad
        //_chargingTimeDisplay.value = DateTime.fromMicrosecondsSinceEpoch( transaction.startAt).difference(DateTime.now()).inMinutes.toString();
        print(" transaction.startAt=>${ transaction.startAt}   == ${DateTime
            .now()
            .millisecondsSinceEpoch}");
        var diff = DateTime
            .now()
            .millisecondsSinceEpoch - transaction.startAt;
        int minute = (diff / 1000 / 60).round();
        print("minute=${minute}");
        String hour = (minute / 60).floor().toString().padLeft(2, "0");
        String minute2 = (minute % 60).toString().padLeft(2, "0");
        _chargingTimeDisplay.value = "${hour} : ${minute2} h";
      });
    }
  }

  finshTransactionProcess() async{
    await FirebaseService.instance.finshTransaction(transaction);

    unloadSelectLocation();
    connector = null;
    charger = null;
    chargerLoc = null;
    _transaction.close();
    _transaction = null;
    _transaction = ChargerTransaction().obs;
    //Future.microtask(() => Get.offAndToNamed("/"));

    Get.offAllNamed("/");
    //Get.offAndToNamed("/");


  }
  RxString _chargingTimeDisplay = "".obs;
  String get chargingTimeDisplay {
    return _chargingTimeDisplay.value ;
  }

  Timer timer;
  Rx<ChargerTransaction> _transaction = ChargerTransaction().obs;
  ChargerTransaction get transaction => _transaction.value;
  StreamSubscription _transactionSubScription;
  set transaction(ChargerTransaction ch) => _transaction.value = transaction;


  Rx<ChargePriceByTime> _chargeTimeRate = ChargePriceByTime().obs;
  ChargePriceByTime get chargeTimeRate  => _chargeTimeRate.value;
  set chargeTimeRate(ChargePriceByTime val) => _chargeTimeRate.value = val;

  Rx<String> _selCard = "".obs;
  String get selCard =>_selCard.value;
  set selCard(String val)=> _selCard.value = val;

  Rx<bool> _useLinePay = false.obs;
  bool get useLinePay => _useLinePay.value;
  set useLinePay(bool val) => _useLinePay.value = val;

  void setPaymentMethod({payType : PaymentType, String cardNo:""}){
    if (payType  == PaymentType.LinePay){
      useLinePay = true;
      selCard = "";
    }else{
      useLinePay = false;
      selCard = cardNo;
    }

  }

  void toConfirmPayment(ChargePriceByTime trl){
    chargeTimeRate = trl;
    useLinePay = false;
    selCard = "";
   // Get.toNamed("/confirm-payment", );
    Get.to(ConfirmPaymentPage());


  }




  void preparePayByTime({PaymentType paidType}) async {
    var _paidType = "";
    if (paidType == null ){
      if (useLinePay ){
        paidType = PaymentType.LinePay;
      }else{
        paidType = PaymentType.CreditCard;
      }
    }
    print("preparePayByTime paidType= ${paidType}");
    if (paidType == PaymentType.CreditCard) {
      _paidType = "CREDITCARD";
    } else if (paidType == PaymentType.LinePay) {
      _paidType = "LINEPAY";
    }
    //prepare charger transaction
    int ts = DateTime
        .now()
        .millisecondsSinceEpoch;
    final chargerUser = Get
        .find<AuthController>()
        .chargerUser;
    final transID = "${chargerUser.primaryID}_${ts}";
    final chargerTran = ChargerTransaction(
      transID: transID,
      startAt: ts,
      stopAt: 0,
      status: "PREPARE",
      chargerUserID: chargerUser.userID,
      chargerLocID: chargerLoc.locationID,
      chargerID: charger.chargerId,
      connectorID: connector.connectorId,
      identityKey: "",
      startCmd: "",
      chargeType: "TIME",
      lockedAt: 0,
      unlockedAt: 0,
      vehicle: "",
      chargedBy: chargerUser.primaryID,
      chargeRateKW: connector.chargePrice[0].actualUsage.chargeRateKW,
      chargeRatePerMin: connector.chargePrice[0].actualUsage.chargePerMinute,
      paymentSource: _paidType,
      payRef: "${_paidType}${transID}",
      prepaidCost:  chargeTimeRate.chargeRate,

    );


    //prepare charging actual in firebase
    await FirebaseService.instance.startCharging(chargerTran);
    print("bindstream for transaction=> ${transID}");


    _transaction.bindStream(
        FirebaseService.instance.fetchActiveChargingTransaction(transID));
    print("_paidType= ${_paidType}");
    if ( _paidType == "LINEPAY") {
      Get.toNamed("/linepay");
    }else{
      Get.to(CreditCardPage());
    }
  }

  void restartCharging() async{
    print("restart => ${transaction.transID}");
    String transID = transaction.transID;
    ChargerTransaction ct = transaction;
    ct.status = "INIT";

    _transaction.close();
    _transaction = null;
    _transaction = ChargerTransaction().obs;

    await FirebaseService.instance.startCharging(ct);
    _transaction.close();
    _transaction.bindStream(
      FirebaseService.instance.fetchActiveChargingTransaction(transID)
    );

  }

  List<CardInfo> get userCards => Get.find<AuthController>().chargerUser.cards;

  resetConfirmPaymentMethod(){
    _selCard = "".obs;
    _useLinePay = false.obs;
  }

  RxBool _showSearch = false.obs;
  bool get showSearch => _showSearch.value;
  set showSearch(bool val) => _showSearch.value =val;



  navigateToPlace(Map<String, String> place){
    Position pos = Position(
      latitude: double.parse(place["lat"]),
      longitude:  double.parse(place["lng"]),
    );
    _position.value = pos;
    LatLng latLng = LatLng(
      position.latitude,
      position.longitude,
    );
    // _baseLocation = LatLng(
    //   position.latitude,
    //   position.longitude,
    // );
    _camPos.value = CameraPosition(
      target: latLng,
      zoom: this.zoom,
    );

    // await setMarker(latLng);
    // _prevPosition = Position(
    //   latitude: position.latitude,
    //   longitude: position.longitude,
    // );
    print("do animate camera");
    _googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 14,
        ),
      ),
    );

    showSearch = false;

  }



  Rx<SearchCriteria> _criteria = SearchCriteria(connectors: {
    "ALL" : true,
    "TYPE1" : false,
    "TYPE2"  : false,
    "CHAdeMO"  : false
  }, locType: {
    "ALL" : true,
    "Office" : false,
    "Department" : false,
  }).obs;

  SearchCriteria get criteria => _criteria.value;
  set criteria(SearchCriteria val) {
    //_criteria.value = val;
   update();
  }

  void openMap(double lat, double lng){
    MapsLauncher.launchCoordinates(lat, lng);
  }

  void makeACall(String phoneNo) async{
    bool res = await FlutterPhoneDirectCaller.callNumber(phoneNo);
  }

  Future<void> handleFav(ChargerLocation chargerLoc) async {
    return await FirebaseService.instance.triggerFav( Get.find<AuthController>().chargerUser.userID, chargerLoc.id);

  }


  void toSelectLocation(String locationID){
    print("toSelectLocation");
    clearChargerLocSubScription();
    print("clear subscription");
    _chargerLocSubScription =  FirebaseService.instance.getChargerLocationSnapshot(locationID).listen((ChargerLocation doc1) {
      print("doc1.locationID=> ${doc1.locationID}");
      FirebaseService.instance.fetchChargersByLocationID(doc1.locationID).listen((List<Charger> chargers) {
        print("dic1.chargers=> ${doc1.chargers}");
        doc1.chargers = chargers;
        _chargerLoc.value = doc1;
        _isLocationSelected.value = true;
        _showSearch.value = false;
      });

    });
    Get.offAllNamed("/");
  }
}

enum PaymentType{
  LinePay,
  CreditCard,
}



