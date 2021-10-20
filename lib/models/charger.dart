
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChargerLocation  extends Equatable{
  List<Charger> chargers;
  String id;
  String locationID;
  String locationName;
  String locationAddress;
  String locationSubAddress;
  List<TimePeriod> openPeriod;
  List<dynamic> locationType;
  List<dynamic> contactPhone;
  List<dynamic> locationImage;
  GeoPoint geoPoint;
  ChargerLocation({
    this.id,
    this.chargers,
    this.locationID,
    this.locationName,
    this.locationAddress,
    this.locationSubAddress,
    this.openPeriod,
    this.locationType,
    this.contactPhone,
    this.locationImage,
    this.geoPoint,
  });
  String get openPeriodDisplay {
    var str = "";
    for (var data in openPeriod){
      str+=data.periodInfo + ",";
    }
    return str;
  }
  String get locationTypeDisplay {
    var str = "";
    for (var data in locationType){
      str+=data+",";
    }
    return str;
  }

  @override
  List<Object> get props => [locationID, locationName];


  factory ChargerLocation.fromFirebase(QueryDocumentSnapshot<Map<String, dynamic>> doc){

    return ChargerLocation(
      //chargers : ,
      locationID : doc.data()["locationID"] ,
      locationName : doc.data()["locationName"],
      locationAddress : doc.data()["locationAddress"],
      locationSubAddress : doc.data()["locationSubAddress"],
     // openPeriod: doc.data()[""],
      locationType: doc.data()["locationType"] ?? [],
      contactPhone: doc.data()["contactPhone"] ?? [],
      locationImage: doc.data()["locationImage"] ?? [],
      geoPoint: doc.data()['position']['geopoint'] ?? GeoPoint(0,0),
    );

  }

  factory ChargerLocation.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> doc){

    //doc.data()["charger"]
    List<TimePeriod> ops = [];
    for (var op in doc.data()["openPeriod"]){
      ops.add(
        TimePeriod.fromMap(op)
      );
    }
    return ChargerLocation(
     // chargers : chargersTmp,
      id : doc.id,
      locationID : doc.data()["locationID"] ?? "" ,
      locationName : doc.data()["locationName"] ?? "",
      locationAddress : doc.data()["locationAddress"] ?? "",
      locationSubAddress : doc.data()["locationSubAddress"] ?? "",
      openPeriod:  ops,
      locationType: doc.data()["locationType"] ?? [],
      contactPhone: doc.data()["contactPhone"] ?? [],
      locationImage: doc.data()["locationImage"] ?? [],
      geoPoint: doc.data()['position']['geopoint'] ?? GeoPoint(0,0),
    );

  }


}







class TimePeriod extends Equatable{
  double fromHour;
  double fromMinute;
  double toHour;
  double toMinute;
  bool alwaysOpen;
  TimePeriod({this.fromHour, this.fromMinute, this.toHour, this.toMinute, this.alwaysOpen});

  String get periodInfo {
    String ret = "";
    if (alwaysOpen){
      ret = "Open 24 Hrs";
    }else{
      ret ="${fromHour}:${fromMinute} - ${toHour}:${toMinute}";
    }
    return ret;
  }

  @override
  List<Object> get props => [periodInfo];
  factory TimePeriod.fromMap(Map<String, dynamic> data){
    if (data["alwaysOpen"] == true){
      return TimePeriod(
        fromHour: 0,
        fromMinute: 0,
        toHour: 0,
        toMinute: 0,
        alwaysOpen: data["alwaysOpen"],
      );
    }else {
      return TimePeriod(
        fromHour: data["fromHour"].toDouble(),
        fromMinute: data["fromMinute"].toDouble(),
        toHour: data["toHour"].toDouble(),
        toMinute: data["toMinute"].toDouble(),
        alwaysOpen: data["alwaysOpen"],
      );
    }

  }
}

class Charger extends Equatable{
  String chargerId;
  String chargerName;
  List<Connector> connectors;
  String status;
  Charger({this.chargerId, this.chargerName, this.status, this.connectors});

  @override
  List<Object> get props => [chargerId, chargerName];

  factory Charger.fromFirebase(DocumentSnapshot doc){
    print("Charger.fromFirebase=>call ${doc}=> ${doc["chargerName"]}");
    List<Connector> connectors = [];
    for (Map<String, dynamic> cnn in doc["connectors"]){
        connectors.add(Connector.fromMap(cnn));

    }
    return Charger(

      chargerId: doc.id,
      connectors: connectors,
      chargerName: doc["chargerName"] ?? "",
      status: doc["status"] ?? "",

    );

  }

}

class Connector extends Equatable{
  String connectorType;
  ConnectorType connectorTypeEnum;
  String connectorId;
  String connectorName;
  String status;
  List<ChargePrice> chargePrice;
  double maxSpeedCharge;
  Connector(
      {
        this.status: "UNKNOW",
        this.connectorName,
        this.connectorId,
        this.connectorType,
        this.connectorTypeEnum,
         this.chargePrice,
      this.maxSpeedCharge:150.0}
  );
  @override
  List<Object> get props => [connectorId, connectorName, connectorType];

  factory Connector.fromMap(Map<String, dynamic> data){

    List<ChargePrice>  cps = [];

    for (var cp in data["chargePrice"] ){
      cps.add(ChargePrice.fromMap(cp));
    }
    return Connector(
      connectorName: data["connectorName"] ?? "",
      connectorId  :  data["connectorId"] ?? "",
      connectorType: data["connectorType"] ?? "",
      status:  data["status"] ?? "",
      chargePrice:  cps,

    );
  }

}

class ChargePrice extends Equatable{
  String priceID;
  ChargePriceByActualUsage actualUsage;
  ChargePriceByTimeUsage timeUsage;
  String baseCurrency;

  ChargePrice({this.priceID, this.timeUsage, this.baseCurrency, this.actualUsage});

  String get actualRateDisplay {
    return "${actualUsage.chargeRateKW} ${baseCurrency}/kW and ${actualUsage.chargeRatePeriod} ${baseCurrency}/${actualUsage.actualPayRateTimeType}";
  }
  String get timeRateDisplay{
    return "${timeUsage.chargeRate}  ${baseCurrency}/${timeUsage.periodType}";
  }

  @override
  List<Object> get props => [actualRateDisplay, timeRateDisplay];

  factory ChargePrice.fromMap(Map<String, dynamic> data) {
    return ChargePrice(
      priceID: data["priceID"] ?? "",
      baseCurrency:  data["baseCurrency"] ?? "",
      actualUsage: ChargePriceByActualUsage.fromMap(data["actualUsage"]),
      timeUsage:   ChargePriceByTimeUsage.fromMap(data["timeUsage"]),
    );

  }



}

class ChargePriceByActualUsage extends Equatable{
  double chargeRateKW;
  double chargeRatePeriod;
  String actualPayRateTimeType; //MINUTE,HOUR
  String baseCurrency;
  ChargePriceByActualUsage({this.actualPayRateTimeType, this.chargeRateKW, this.chargeRatePeriod, this.baseCurrency:'THB'});

  @override
  List<Object> get props => [chargeRateKW, chargeRatePeriod, actualPayRateTimeType, baseCurrency];

  factory ChargePriceByActualUsage.fromMap(Map<String, dynamic> data) {
    print("ChargePriceByActualUsage.fromMap");
    return ChargePriceByActualUsage(
     chargeRatePeriod: data["chargeRatePeriod"].toDouble(),
      chargeRateKW: data["chargeRateKW"].toDouble(),
      baseCurrency: data["baseCurrency"],
      actualPayRateTimeType : data["actualPayRateTimeType"],
    );

  }

  double get chargePerMinute {
    if (actualPayRateTimeType == "hrs"){
      return (chargeRatePeriod /60);
    }else{
      return chargeRatePeriod;
    }
  }
}

class ChargePriceByTimeUsage extends Equatable{
  double chargeRate ;
  String periodType ; //MINUTE, HOUR
  List<ChargePriceByTime> timeRateList;
  String baseCurrency;
  ChargePriceByTimeUsage({this.chargeRate, this.periodType, this.timeRateList, this.baseCurrency:'THB'});

  @override
  List<Object> get props => [chargeRate, periodType, baseCurrency];
  factory ChargePriceByTimeUsage.fromMap(Map<String, dynamic> data){
    List<ChargePriceByTime> pList = [];
    print("ChargePriceByTimeUsage=> data=>${data}");
    for (var p in data["timeRateList"]){
      pList.add( ChargePriceByTime.fromMap(p));
    }
    return ChargePriceByTimeUsage(
      chargeRate: data["chargeRate"].toDouble(),
      periodType: data["periodType"],
      baseCurrency: data["baseCurrency"],
      timeRateList: pList,
    );
  }

}

class ChargePriceByTime extends Equatable{
  double chargeRate;
  double timePeriod;  //(charge time)
  String periodType; //MINUTE HOUR
  String baseCurrency;
  ChargePriceByTime({this.periodType, this.chargeRate, this.timePeriod, this.baseCurrency:'THB'});
  String get priceDisplay => "${timePeriod} ${periodType} ${chargeRate} ${baseCurrency}";
  double get timeInMinutes {
    if (periodType == "mins"){
      return timePeriod;
    }else{
      return timePeriod * 60;
    }
  }

  @override
  List<Object> get props => [priceDisplay];
  factory ChargePriceByTime.fromMap(Map<String, dynamic> data){
    return ChargePriceByTime(
      chargeRate: data["chargeRate"].toDouble(),
      timePeriod: data["timePeriod"].toDouble(),
      periodType: data["periodType"],
      baseCurrency: data["baseCurrency"],

    );
  }


}
enum ConnectorType {
  TYPE1,
  TYPE2,
  CHAdeMO,
}


class ChargerTransaction{
  String transID;
  int startAt;
  int stopAt;
  String status;// (Init, Waiting, Charging, Wait for Unplug, Finish)
  String chargerUserID;
  String chargerLocID;
  String chargerID;
  String connectorID;
  String identityKey; // url
  String startCmd; //url
  String chargeType;// (actual, timerate)
  int lockedAt;
  int unlockedAt;
  String vehicle;
  String chargedBy;
  int backendStartAt;
  int startCallBackendAt;
  int backendTransID;

  double chargeRateKW;
  double chargeRatePerMin;

  double totalChargeTime;
  double totalChargeKW;

  double startMeter;
  double stopMeter;

  String payeeRef;
  String payRef;
  String paidStatus;
  String paymentSource;
  String lineTransRef;

  double prepaidCost;
  String prepaidKey;
  String chargeCurrency;

  ChargerTransaction( {
    this.chargeCurrency, this.prepaidCost, this.prepaidKey,
    this.lineTransRef,
    this.paidStatus, this.paymentSource,
    this.payeeRef, this.payRef,
    this.startMeter, this.stopMeter,
    this.totalChargeKW, this.totalChargeTime,
    this.chargeRateKW, this.chargeRatePerMin,
    this.backendTransID, this.startCallBackendAt,
    this.backendStartAt, this.chargedBy, this.transID, this.startAt,
    this.stopAt, this.status, this.chargerUserID, this.chargerLocID,
    this.chargerID, this.connectorID, this.identityKey, this.startCmd,
    this.chargeType, this.lockedAt, this.unlockedAt, this.vehicle});


  factory ChargerTransaction.fromFireStore(DocumentSnapshot<Map<String,dynamic>> doc){
      final  startMeter =  doc.data()['startMeter'] ?? 0.0;
      final stopMeter = doc.data()['stopMeter'] ?? 0.0;

      return ChargerTransaction(
          transID : doc.data()['transID'] ?? "",
          startAt : doc.data()['startAt']  ?? 0,
          stopAt : doc.data()['stopAt']  ?? 0,
          status : doc.data()['status']  ?? "UNKNOW",
          chargerUserID : doc.data()['chargerUserID']  ?? "",
          chargerLocID : doc.data()['chargerLocID'] ?? "",
          chargerID : doc.data()['chargerID'] ?? "",
          connectorID : doc.data()['connectorID'] ?? "",
          identityKey : doc.data()['identityKey'] ?? "",
          startCmd : doc.data()['startCmd'] ?? "",
          chargeType : doc.data()['chargeType'] ?? "",
          lockedAt : doc.data()['lockedAt'] ?? 0,
          unlockedAt : doc.data()['unlockedAt'] ?? 0,
          vehicle : doc.data()['vehicle'] ?? "",
          chargedBy:  doc.data()['chargedBy'] ?? "",
          backendStartAt : doc.data()['backendStartAt'] ?? 0,
          startCallBackendAt : doc.data()['startCallBackendAt'] ?? 0,
          backendTransID:  doc.data()['backendTransID'] ?? 0,
          chargeRateKW : doc.data()['chargeRateKW'] ?? 0,
          chargeRatePerMin : doc.data()['chargeRatePerMin'] ?? 0,
          totalChargeKW : doc.data()['totalChargeKW'] ?? 0,
          totalChargeTime : doc.data()['totalChargeTime'] ?? 0,
          startMeter: startMeter.toDouble(),
          stopMeter: stopMeter.toDouble(),
          payeeRef : doc.data()['payeeRef'] ?? "",
          payRef : doc.data()['payRef'] ?? "",
          paidStatus : doc.data()['paidStatus'] ?? "",
          paymentSource : doc.data()['paymentSource'] ?? "",
        lineTransRef: doc.data()['lineTransRef'] ?? "",
        prepaidCost:  doc.data()['prepaidCost'] ?? 0.0,
        prepaidKey: doc.data()['prepaidKey'] ?? "",
        chargeCurrency : doc.data()['chargeCurrency'] ?? "",

      );

      String payeeRef;
      String payRef;
      String paidStatus;
      String paymentSource;
  }

  String get prepaidCostFormatted {
    return prepaidCost.toStringAsFixed(2);
  }
  String get startAtDisplay{

  try {
    return DateFormat('HH:mm').format(
        DateTime.fromMillisecondsSinceEpoch(startAt));
  }catch(ex){
    return "";
  }
  }

  String get stopAtDisplay{

    try {
      return DateFormat('HH:mm').format(
          DateTime.fromMillisecondsSinceEpoch(stopAt));
    }catch(ex){
      return "";
    }
  }


  String get totalChargeTimeDisplay{
      final diff = stopAt -  startAt;
      int minute = (diff/1000/60).round();
      print("minute=${minute}");
      String hour = (minute/60).floor().toString().padLeft(2, "0");
      String minute2 = (minute%60).toString().padLeft(2, "0");
      return "${hour} : ${minute2} hrs";

  }

  double get totalChargeTimeMinutes{

    final diff = stopAt -  startAt;
    return (diff/1000/60);
  }
  String get totalCostDisplay{
    final totalCostTime = totalChargeTimeMinutes  * chargeRatePerMin;
    final totalCostVolume = ((totalChargeKW==null)?0.0: totalChargeKW ) * chargeRateKW;
    if (totalCostVolume < totalCostTime){
      return totalCostVolume.toStringAsFixed(2);
    }else{
      return totalCostTime.toStringAsFixed(2);
    }

  }


  Map<String, dynamic>toMap(){
    return {
      "transID" : transID,
      "startAt" : startAt,
      "stopAt" : stopAt,
      "status" : status,
      "chargerUserID" : chargerUserID,
      "chargerLocID" : chargerLocID,
      "chargerID" : chargerID,
      "connectorID" : connectorID,
      "identityKey" : identityKey,
      "startCmd" : startCmd,
      "chargeType" : chargeType,
      "lockedAt" : lockedAt,
      "unlockedAt" : unlockedAt,
      "vehicle" : vehicle,
      "chargedBy" : chargedBy,
      "updateAt" :DateTime.now().millisecondsSinceEpoch,
      "backendStartAt" : backendStartAt,
      "startCallBackendAt" : startCallBackendAt,
      "backendTransID":  backendTransID,
      "chargeRateKW" : chargeRateKW,
      "chargeRatePerMin" : chargeRatePerMin,
      "totalChargeKW" : totalChargeKW,
      "totalChargeTime" : totalChargeTime,
      "startMeter" : startMeter,
      "stopMeter" : stopMeter,
      "payeeRef" : payeeRef,
      "payRef" : payRef,
      "paidStatus" : paidStatus,
      "paymentSource" : paymentSource,
      "lineTranRef" : lineTransRef,
      "prepaidCost" : prepaidCost,
      "prepaidKey" : prepaidKey,
      "chargeCurrency" : chargeCurrency,

    };

  }

}



class ChargeHistory{
  static final List<String> months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];
  int hYear;
  int hMonth;
  int hDay;
  ChargerTransaction transaction;
  String get key => "${hYear}_${hMonth}_${hDay}_${transaction.transID}";
  String get year => hYear.toString();
  String get month => hMonth.toString();
  String get day => hDay.toString();

  String get monthName => ChargeHistory.months[hMonth-1];

  String get histDateDisplay{
      return "${day} ${monthName} ${year}";
  }

  ChargeHistory({this.hDay, this.hMonth, this.hYear, this.transaction});


  factory ChargeHistory.fromFirebase(DocumentSnapshot doc){
    print("ChargeHistory.fromFirebase=>enter");
    print("ChargeHistory.fromFirebase=>${doc["transID"]}");
    print("ChargeHistory.fromFirebase=>chargedBy=>${doc["chargedBy"]}");
   // print("ChargeHistory.fromFirebase=>${doc["transID"].replace( doc["chargedBy"] +"_", "")}");
    final transId = (doc["transID"] as String).replaceAll( doc["chargedBy"] +"_", "");
    final transDate = DateTime.fromMillisecondsSinceEpoch(int.parse(transId));
    print("ChargeHistory.fromFirebase=>before return");
    print("ChargeHistory.fromFirebase=>transdDate.year=${transDate.year}");
    print("ChargeHistory.fromFirebase=>transdDate.month=${transDate.month}");
    print("ChargeHistory.fromFirebase=>transdDate.day=${transDate.day}");
    return ChargeHistory(
      hYear: transDate.year,
      hMonth: transDate.month,
      hDay: transDate.day,
      transaction: ChargerTransaction.fromFireStore(doc),
    );

  }
  String get historyInfo{
    String ret = "";
    ret = "${transaction.chargerID}\nStart ${transaction.startAtDisplay} Stop ${transaction.stopAtDisplay}\n";
    ret+="Volume ${transaction.totalChargeKW} kW\n";
    ret+="Charge ${transaction.totalCostDisplay} THB";
    return ret;

  }
}

class ChargeHistories{
  Map<String, Map<String, Map<String, Map<String, ChargeHistory> > >> histories ={};
  bool loadDone = false;
  ChargeHistories({this.histories, this.loadDone});

  List<String> get yearsList {
    if (histories != null && histories.isNotEmpty) {
      List<String> ret = histories.keys.toList()..sort();
      return ret.reversed.toList();

      //return histories.keys.toList()..sort();
    }else{
      return [];
    }

  }

  List<String>  monthsList(String year) {

    if (histories.isNotEmpty && histories[year] != null && histories[year].isNotEmpty) {
      List<String> ret = histories[year].keys.toList()..sort();
      return ret.reversed.toList();
    }else{
      return [];
    }

  }

  Map<String, Map<String, ChargeHistory>> datasList(String year, String month){
    if (histories != null && histories.isNotEmpty){
      if (histories[year][month] != null && histories[year][month].isNotEmpty){
        return histories[year][month];

      }else{
        return {};
      }
    }
    return {};
  }

  List<String> dayKey(String year, String month){
    if (histories != null && histories.isNotEmpty){
      if (histories[year][month] != null && histories[year][month].isNotEmpty){
        print("ChargeHistories=>dayKey= before get list} ${year} ${month}");
        List<String> ret = histories[year][month].keys.toList()..sort();
        print("ret=> ${ret}");
        return ret.reversed.toList();

      }else{
        return [];
      }
    }
    return [];
  }


}

