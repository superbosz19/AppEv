import 'dart:ffi';

import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/models/charger.dart';
import 'package:ez_mobile/view/components/CloseButton.dart';
import 'package:ez_mobile/view/components/MenuButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPaymentPage extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Material(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(children: [
              MenuButton(),
              EzCloseButton(
                onTap: (){
                  Get.find<GMapController>().unloadAllSelection();
                  //print("custom ontap");
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kToolbarHeight*2,),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: SelectPaymentChargerInfo(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: PaymentPagePaymentList(),
                  ),
                ],
              ),
            ]),
          ),
          color: _theme.lightColor,
        ),
      ),
    );
  }
}

class SelectPaymentChargerInfo extends StatelessWidget{
  CustomTheme _theme = CustomTheme.instance;
  @override
  Widget build(BuildContext context) {
    Charger _charger = Get.find<GMapController>().charger;
    Connector _connector = Get.find<GMapController>().connector;

    return _charger!=null?Column(
      children: [
        Row(
          children: [
            RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 18, //_theme.fontSizeBody1,
                    color: _theme.primaryColor,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: "${_charger.chargerName}\n\n",
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    new TextSpan(text: "${_connector.connectorName}\n"),
                    new TextSpan(text: "หัวชาร์จ ${_connector.connectorType}\n"),
                    new TextSpan(
                        text:
                        "ความเร็วสูงสุดในการชาร์จ ${_connector.maxSpeedCharge} kW"),
                  ],
                )),
            Icon(
              _theme.icons[_connector.connectorType],
              size: 70,
              color: _theme.secondaryColor,
            ),
          ],
        )
      ],
    ):SizedBox.shrink();
  }

}

class PaymentPagePaymentList extends StatelessWidget{
  CustomTheme _theme = CustomTheme.instance;
  Charger _charger = Get.find<GMapController>().charger;
  Connector _connector = Get.find<GMapController>().connector;
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(Text(
      "ชาร์จแบบจ่ายตามจริง",
      style: _theme.boxSecondaryTextBold,
    ));
    children.add(SizedBox(
      height: 10,
    ));
    if (_connector == null){
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      );
    }
    children.add(
        PaymentButton(
          text: _connector.chargePrice[0].actualRateDisplay,
          onTap : (){
           print('actualratedisplay');

           Get.find<GMapController>().selectPayActual();
          },
        )
    );


    children.add(Text(
      "ชาร์จแบบเหมาจ่ายรายชัว่โมง",
      style: _theme.boxSecondaryTextBold,
    ));
    for (var trl in _connector.chargePrice[0].timeUsage.timeRateList) {
      children.add(SizedBox(
        height: 10,
      ));
      children.add(
          PaymentButton(
            text: "${trl.priceDisplay}" ,
            onTap : (){
              Get.find<GMapController>().toConfirmPayment(trl);
            },
          )
      );
    }



    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class PaymentButton extends StatelessWidget{
  final String text;
  final VoidCallback onTap;
  CustomTheme _theme = CustomTheme.instance;

  PaymentButton({this.text, this.onTap});


  @override
  Widget build(BuildContext context) {
    //never set container color to enable inkwell
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        //color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: double.infinity,
            height: 50,
            // color: _theme.greyColor,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: _theme.fontSizeHeader1,
                  color: _theme.secondaryColor,
                ),
              ),
            ),
          ),
          onTap: onTap,
          splashColor: _theme.secondaryColor,

        ),
        color: _theme.greyColor,
      ),
    );
  }

}