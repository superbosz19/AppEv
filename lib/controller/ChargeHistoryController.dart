import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/models/charger.dart';
import 'package:ez_mobile/services/FirebaseService.dart';
import 'package:get/get.dart';

class ChargeHistoryController extends GetxController{

  Rx<ChargeHistories> _histories = ChargeHistories().obs;

  RxString _selYear = "".obs;
  RxString _selMonth = "".obs;

  @override
  void onInit() async {
    loadHistory();
    super.onInit();
  }

  void loadHistory() async{
    print("loadHistory");
    _histories.value = await FirebaseService.instance.fetchHistories2(Get.find<AuthController>().chargerUser.userID);
    if (_histories.value.yearsList !=null && _histories.value.yearsList.length > 0 ) {
      print("loadHistory=> yearlist !+ null ");
      selYear = _histories.value.yearsList.first;
    }
  }

  List<String> get yearList {
    if (_histories.value== null || _histories.value.yearsList == null){
      return [];
    }
    if (selYear != null && selYear !="" && selYear.isNotEmpty){
      selYear = _histories.value.yearsList.first;
    }
    return _histories.value.yearsList;
  }

  List<String> get monthList{
    print("monthList selYear=>${selYear}");
    if (selYear != null && selYear !="" && selYear.isNotEmpty) {
      List<String> mList = _histories.value.monthsList(selYear);
      print("monthList selYear=>${selYear} mList=${mList}");
      print("monthList selYear=>${selYear} mList.length=${mList.length}");
      if (mList != null && mList.length >0 &&  (selMonth == null || selMonth =="") ){
        selMonth = mList.first;
      }
      print("monthList selYear=>${selYear} selMonth=${selMonth}");
      return mList;//_histories.value.monthsList(selYear);
    }else{
      return [];
    }
  }

  String get selYear => _selYear.value;
  set selYear(String val) {
  _selYear.value = val;
  }

  String get selMonth => _selMonth.value;
  set selMonth(String val){
    _selMonth.value = val;
  }

  Map<String, Map<String, ChargeHistory>> get datasList {
    print("datasList=> selYear=>${selYear} selMonth=>${selMonth}");
    return _histories.value.datasList(selYear, selMonth);
  }
  List<String> get dayKey {
    return _histories.value.dayKey(selYear, selMonth);
  }

  bool get loadDone {
    if (_histories.value != null && _histories.value.loadDone != null) {
     return _histories.value.loadDone;
    }else{
      return false;
    }

  }

}