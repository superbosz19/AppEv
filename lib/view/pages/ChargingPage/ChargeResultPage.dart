import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/view/components/MenuButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChargeResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    CustomTheme _theme = CustomTheme.instance;
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _paddingLR = (_screenWidth / 3) / 4;
    double _spaceW = _screenWidth / 3;
    double _boxWidth = _screenWidth - _spaceW;
    double _sectionHeight = _screenHeight / 3;
    double _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Material(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: GetX<GMapController>(
              init: Get.find<GMapController>(),
              initState: (_) {},
              builder: (ctrl) {
                if (ctrl.chargeStatus == null || ctrl.charger == null || ctrl.chargerLoc ==null || ctrl.transaction == null){
                  //Future.microtask(() => Get.toNamed("/"));
                  WidgetsBinding.instance.addPostFrameCallback((_) => Get.toNamed("/"));
                  return SizedBox.shrink();
                }
                return Stack(
                  children: [
                    MenuButton(),
                    SizedBox(
                      height: _sectionHeight / 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: kToolbarHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: kToolbarHeight ,
                          ),

                          Center(
                            child:Text("Charging Information",
                                style: TextStyle(
                                  color: _theme.lightColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: _sectionHeight / 12,
                                )),
                          ),
                          SizedBox(
                            height: _sectionHeight/6,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: _paddingLR, right: _paddingLR),
                            child: Text(ctrl.charger.chargerName, style: TextStyle(
                              color: _theme.primaryColor,
                              fontWeight: FontWeight.normal,
                              fontSize: _sectionHeight / 12,
                            ),),
                          ),
                          SizedBox(height: 10,),
                          ChargInfoSection(),

                          SizedBox(
                            height: _sectionHeight / 3,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:  EdgeInsets.all(_paddingLR),
                              child: SizedBox(
                                width: double.infinity,
                                height: _sectionHeight / 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: _theme.primaryColor,
                                    textStyle: TextStyle(
                                      color: _theme.secondaryColor,
                                    ),
                                  ),
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                        color: _theme.lightColor,
                                        fontSize: _sectionHeight / 12),
                                  ),
                                  onPressed: () {
                                    ctrl.finshTransactionProcess();
                                  }
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        color: _theme.secondaryColor,
      ),
    );
  }
}

class ChargInfoSection extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    CustomTheme _theme = CustomTheme.instance;
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _paddingLR = (_screenWidth / 3) / 4;
    double _spaceW = _screenWidth / 3;
    double _boxWidth = _screenWidth - _spaceW;
    double _sectionHeight = _screenHeight / 3;
    double _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;

    var dtFormat = DateFormat("d MMM y HH:mm");
    TextStyle txtBold = TextStyle(
      fontWeight: FontWeight.w900,
      color: _theme.lightColor,
      fontSize: _sectionHeight / 10,
    );
    TextStyle txtNormal = TextStyle(
      fontWeight: FontWeight.normal,
      color: _theme.lightColor,
      fontSize: _sectionHeight / 12,
    );

    return GetX<GMapController>(
        init: Get.find<GMapController>(),
    initState: (_) {},
    builder: (ctrl) {
          if (ctrl.transaction == null || ctrl.transaction.status == null){
            return SizedBox.shrink();
          }else
          return Padding(
            padding: EdgeInsets.only(top: 10, left: _paddingLR, right: _paddingLR),
            child: Column(
              children: [
                TextLabel(
                  text: Text(
                    "Start:",
                    style: txtBold,
                  ),
                  label: Text(
                  "   ${dtFormat.format(DateTime.fromMillisecondsSinceEpoch(ctrl.transaction.startAt))}",
                    style: txtNormal,
                  ),
                  position: TextLabelDisplayFormat.TEXTLEFT,
                ),
                SizedBox(
                  height: _sectionHeight / 15,
                ),
                TextLabel(
                  text: Text(
                    "Stop:",
                    style: txtBold,
                  ),
                  label: Text(
                    "   ${dtFormat.format(DateTime.fromMillisecondsSinceEpoch(ctrl.transaction.stopAt))}",
                    style: txtNormal,
                  ),
                  position: TextLabelDisplayFormat.TEXTLEFT,
                ),
                SizedBox(
                  height: _sectionHeight / 15,
                ),
                TextLabel(
                  text: Text(
                    "Total Time:",
                    style: txtBold,
                  ),
                  label: Text(
                    "   ${ctrl.transaction.totalChargeTimeDisplay}",
                    style: txtNormal,
                  ),
                  position: TextLabelDisplayFormat.TEXTLEFT,
                ),
                SizedBox(
                  height: _sectionHeight / 15,
                ),
                TextLabel(
                  text: Text(
                    "Total Volume:",
                    style: txtBold,
                  ),
                  label: Text(
                    "   ${ctrl.transaction.totalChargeKW} kW",
                    style: txtNormal,
                  ),
                  position: TextLabelDisplayFormat.TEXTLEFT,
                ),
                SizedBox(
                  height: _sectionHeight / 15,
                ),
                TextLabel(
                  text: Text(
                    "Total Cost:",
                    style: txtBold,
                  ),
                  label: Text(
                    "   ${ctrl.transaction.totalCostDisplay} THB",
                    style: txtNormal,
                  ),
                  position: TextLabelDisplayFormat.TEXTLEFT,
                ),
              ],
            ),
          );

    }
    );
  }


}