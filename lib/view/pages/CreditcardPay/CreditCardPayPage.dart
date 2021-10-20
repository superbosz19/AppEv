import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/view/pages/history/ChargeHistoryPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreditCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<GMapController>(
        init: Get.find<GMapController>(),
        //initState: (_) {},
        builder: (ctrl) {
          print("CreditCardPage=> ctrl.transaction => ${ctrl.transaction}");
          print("CreditCardPage=> ctrl.transaction.status => ${ctrl.transaction.status}");
          if (ctrl.transaction== null || ctrl.transaction.status ==null || ctrl.transaction.status == "PREPARE") {
            print("CreditCardPage=> prepare");
            print("https://ezev.app/bank-payment?amt=${ctrl.transaction.prepaidCostFormatted}&ref1=${ctrl.transaction.transID}");
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text('EZ EV Payment'),
                actions: [
                  //EZBackButton(),
                  //Text("xxx")
                ],
              ),
              body: Material(
                child: WebView(
                  initialUrl: "https://ezev.app/bank-payment?amt=${ctrl.transaction.prepaidCostFormatted}&ref1=${ctrl.transaction.transID}",
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
            );
          }else{
            print("CreditCardPage=> Ready for charge");
            Future.microtask(() =>  Get.toNamed("/charging-page"));
            //WidgetsBinding.instance.addPostFrameCallback((_) => Get.toNamed("/charging-page"));
            return SizedBox.shrink();
          }

        }
    );
  }


}