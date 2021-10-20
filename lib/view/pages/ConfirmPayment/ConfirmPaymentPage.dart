import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/controller/PaymentConfigController.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/models/ChargerUser.dart';
import 'package:ez_mobile/view/components/CloseButton.dart';
import 'package:ez_mobile/view/components/MenuButton.dart';
import 'package:ez_mobile/view/pages/history/ChargeHistoryPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class ConfirmPaymentPage extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  VoidCallback _customCloseAction() {}
  ConfirmPaymentPage(){
    print("ConfirmPaymentPage enter");

  }
  @override
  Widget build(BuildContext context) {
    /** screen size **/
    double _screenHeight;
    double _screenWidth;
    double _sectionHeight;
    double _boxTop;
    double _boxWidth;
    double _mainBoxHeight;
    double _spaceW;
    double _paddingLR;
    /** end screen size **/
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    _paddingLR = (_screenWidth / 3) / 2;
    _spaceW = _screenWidth / 3;
    _boxWidth = _screenWidth - _spaceW;
    _sectionHeight = _screenHeight / 8;
    _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;

    //GMapController ctrl = Get.find<GMapController>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Material(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenuButton(),
                    EzCloseButton(
                      onTap: _customCloseAction,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ChargerInfoSection(),
                ),
                LineSeperator(
                  dotLength: 4.0,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: PaymentDetailSection(),
                ),
                LineSeperator(
                  dotLength: 4.0,
                ),

                Padding(
                  padding: EdgeInsets.all(20),
                  child: CreditCardSection(),
                ),

                Padding(
                  padding: EdgeInsets.all(20),
                  child: LinePaySection(),
                ),
                ConfirmPaymentNextButton(),
              ],
            ),
          ),
          color: _theme.lightColor,
        ),
      ),
    );
  }
}

class ConfirmPaymentNextButton extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    /** screen size **/
    double _screenHeight;
    double _screenWidth;
    double _sectionHeight;
    double _boxTop;
    double _boxWidth;
    double _mainBoxHeight;
    double _spaceW;
    double _paddingLR;
    /** end screen size **/
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    _paddingLR = (_screenWidth / 3) / 2;
    _spaceW = _screenWidth / 3;
    _boxWidth = _screenWidth - _spaceW;
    _sectionHeight = _screenHeight / 8;
    _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          height: _sectionHeight / 3,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: _theme.primaryColor,
              textStyle: TextStyle(
                color: _theme.secondaryColor,
              ),
            ),
            child: Text(
              "Next",
              style: TextStyle(
                  color: _theme.lightColor, fontSize: _sectionHeight / 6),
            ),
            onPressed: () {
              Get.find<GMapController>().preparePayByTime();
            },
          ),
        ),
      ),
    );
  }
}

class PaymentDetailSection extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    /** screen size **/
    double _screenHeight;
    double _screenWidth;
    double _sectionHeight;
    double _boxTop;
    double _boxWidth;
    double _mainBoxHeight;
    double _spaceW;
    double _paddingLR;
    /** end screen size **/
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    _paddingLR = (_screenWidth / 3) / 2;
    _spaceW = _screenWidth / 3;
    _boxWidth = _screenWidth - _spaceW;
    _sectionHeight = _screenHeight / 8;
    _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;

    var dtFormat = DateFormat("d MMM y H:mm");
    TextStyle textBold = TextStyle(
      fontWeight: FontWeight.bold,
      color: _theme.primaryColor,
      fontSize: _sectionHeight / 6,
    );

    TextStyle textNormal = TextStyle(
      fontWeight: FontWeight.normal,
      color: _theme.primaryColor,
      fontSize: _sectionHeight / 6,
    );
    TextStyle textHeader = TextStyle(
      fontWeight: FontWeight.normal,
      color: _theme.primaryColor,
      fontSize: _sectionHeight / 6,
    );

    double spaceH = _sectionHeight / 10;

    return GetX<GMapController>(
      init: Get.find<GMapController>(),
      builder: (ctrl) {
        print("chargingTimDisplay=>${ctrl.chargeTimeRate}");
        if (ctrl.chargeTimeRate == null) {
          return SizedBox.shrink();
        }
        DateTime _dt = DateTime.now();
        DateTime _stopDt = _dt
            .add(Duration(minutes: ctrl.chargeTimeRate.timeInMinutes.toInt()));
        return Padding(
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextLabel(
                text: Text(
                  "Start:",
                  style: textBold,
                ),
                label: Text(
                  dtFormat.format(_dt),
                  style: textNormal,
                ),
                position: TextLabelDisplayFormat.TEXTLEFT,
              ),
              SizedBox(
                height: spaceH,
              ),
              TextLabel(
                text: Text(
                  "Stop:",
                  style: textBold,
                ),
                label: Text(
                  dtFormat.format(_stopDt),
                  style: textNormal,
                ),
                position: TextLabelDisplayFormat.TEXTLEFT,
              ),
              SizedBox(
                height: spaceH,
              ),
              TextLabel(
                text: Text(
                  "Total Cost:",
                  style: textBold,
                ),
                label: Text(
                  "${ctrl.chargeTimeRate.chargeRate} ${ctrl.chargeTimeRate.baseCurrency}",
                  style: textNormal,
                ),
                position: TextLabelDisplayFormat.TEXTLEFT,
              ),
            ],
          ),
        );
      },
    );
  }


}

class ChargerInfoSection extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    return GetX<GMapController>(
      init: Get.find<GMapController>(),
      builder: (ctrl) {
        return ctrl.connector != null
            ? Column(
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
                              text: "${ctrl.charger.chargerName}\n\n",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          new TextSpan(
                              text: "${ctrl.connector.connectorName}\n"),
                          new TextSpan(
                              text:
                                  "หัวชาร์จ ${ctrl.connector.connectorType}\n"),
                          new TextSpan(
                              text:
                                  "ความเร็วสูงสุดในการชาร์จ ${ctrl.connector.maxSpeedCharge} kW"),
                        ],
                      )),
                      Icon(
                        _theme.icons[ctrl.connector.connectorType],
                        size: 70,
                        color: _theme.secondaryColor,
                      ),
                    ],
                  )
                ],
              )
            : SizedBox.shrink();
      },
    );
  }
}

class LinePaySection extends StatelessWidget{
  CustomTheme _theme = CustomTheme.instance;
  @override
  Widget build(BuildContext context) {

    /** screen size **/
    double _screenHeight;
    double _screenWidth;
    double _sectionHeight;
    double _boxTop;
    double _boxWidth;
    double _mainBoxHeight;
    double _spaceW;
    double _paddingLR;
    /** end screen size **/
    _screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    _screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    _paddingLR = (_screenWidth / 3) / 2;
    _spaceW = _screenWidth / 3;
    _boxWidth = _screenWidth - _spaceW;
    _sectionHeight = _screenHeight / 8;
    _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;
    TextStyle textBold = TextStyle(
      fontWeight: FontWeight.bold,
      color: _theme.primaryColor,
      fontSize: _sectionHeight / 6,
    );

    TextStyle textNormal = TextStyle(
      fontWeight: FontWeight.normal,
      color: _theme.primaryColor,
      fontSize: _sectionHeight / 6,
    );
    TextStyle textHeader = TextStyle(
      fontWeight: FontWeight.normal,
      color: _theme.primaryColor,
      fontSize: _sectionHeight / 6,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top:10),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: _theme.primaryColor)),
              child: Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left:8.0, right:8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("LinePay " , style: textNormal ),
                    SizedBox(width: 5,),
                    SizedBox(width: 5,),
                    Material(
                      child: InkWell(
                        child:
                        Obx(() {
                          if ( Get.find<GMapController>().useLinePay){
                            return Icon(Icons.check_circle,
                                color: _theme.primaryColor);
                          }else {
                            return Icon(Icons.circle_outlined,
                                color: _theme.primaryColor);
                          }
                        }),
                        onTap: (){
                          Get.find<GMapController>().setPaymentMethod(payType: PaymentType.LinePay);
                        },
                        splashColor: Colors.transparent,//_theme.secondaryColor,
                      ),
                    ),


                  ],
                ),
              ),
            )
        )
      ],
    );
  }
}






class CreditCardSection extends StatelessWidget{

  CustomTheme _theme = CustomTheme.instance;
  @override
  Widget build(BuildContext context) {

    /** screen size **/
    double _screenHeight;
    double _screenWidth;
    double _sectionHeight;
    double _boxTop;
    double _boxWidth;
    double _mainBoxHeight;
    double _spaceW;
    double _paddingLR;
    /** end screen size **/
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    _paddingLR = (_screenWidth / 3) / 2;
    _spaceW = _screenWidth / 3;
    _boxWidth = _screenWidth - _spaceW;
    _sectionHeight = _screenHeight / 8;
    _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;

    var dtFormat = DateFormat("d MMM y H:Hm");
    TextStyle textBold = TextStyle(
      fontWeight: FontWeight.bold,
      color: _theme.primaryColor,
      fontSize: _sectionHeight / 6,
    );

    TextStyle textNormal = TextStyle(
      fontWeight: FontWeight.normal,
      color: _theme.primaryColor,
      fontSize: _sectionHeight / 6,
    );
    TextStyle textHeader = TextStyle(
      fontWeight: FontWeight.normal,
      color: _theme.primaryColor,
      fontSize: _sectionHeight / 6,
    );

    double spaceH = _sectionHeight / 10;
    GMapController gMap = Get.find<GMapController>();
    gMap.resetConfirmPaymentMethod();
    return GetX<AuthController>(
      init: Get.find<AuthController>(),
      initState: (_) {},
      builder: (ctrl) {
        List<Widget> cards = [];
        cards.add(
          Text("Credit / Debit Card", style: textBold,),
        );

        List<CardInfo> cards1 =  ctrl.chargerUser.cards;
        for (var card in cards1){
          if (
          ! gMap.useLinePay &&
              (card.primary && (gMap.selCard == null || gMap.selCard.isEmpty ))
          ){
            gMap.selCard = card.cardNo;
          }
          cards.add(
              Padding(
                  padding: EdgeInsets.only(top:10),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: _theme.primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left:8.0, right:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("${card.maskedCardNo} " , style: textNormal ),
                          SizedBox(width: 5,),
                          //card.primary?Text("(primary)" , style: textNormal):SizedBox.shrink(),
                          SizedBox(width: 5,),
                          Material(
                            child: InkWell(
                              child:
                              Obx(() {
                                if ( Get.find<GMapController>().selCard == card.cardNo){
                                  return Icon(Icons.check_circle,
                                      color: _theme.primaryColor);
                                }else {
                                  return Icon(Icons.circle_outlined,
                                      color: _theme.primaryColor);
                                }
                              }),
                              onTap: (){
                                gMap.setPaymentMethod(payType: PaymentType.CreditCard, cardNo: card.cardNo);
                              },
                              splashColor: Colors.transparent,//_theme.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              )

          );
        }

        cards.add(
            SizedBox(height: 10,)
        );
        cards.add(
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Material(
              child: InkWell(
                child: Text(
                  "+ Add card",
                  style: TextStyle(
                      color: _theme.darkColor, fontSize: 16),
                ),
                onTap: (){
                  Get.put(PaymentConfigController());
                  Get.toNamed("/addpayment-page");
                },
                splashColor: _theme.primaryColor,
              ),

            ),
          ),
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: cards,
        );
      },
    );




  }




}