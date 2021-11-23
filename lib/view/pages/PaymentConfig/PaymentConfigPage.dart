import 'dart:ffi';

import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/controller/PaymentConfigController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class PaymentConfigPage extends StatelessWidget {
  CustomTheme _theme;
  AuthController auth;
  PaymentConfigController payment;

  PaymentConfigPage() {
    Get.put(PaymentConfigController());
  }

  @override
  Widget build(BuildContext context) {
    _theme = CustomTheme.instance;
    auth = Get.find<AuthController>();
    // profileCtrl.email.value = auth.chargerUser.email;
    // profileCtrl.phone.value = auth.chargerUser.phone;

    double _screenW = MediaQuery.of(context).size.width;
    double _screenH = MediaQuery.of(context).size.height;

    double _sectionH = (_screenH) / 16;
    double _paddLR = _screenW * .1;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
         leading:  Padding(
           padding: const EdgeInsets.only(left: 12.0, top: 3.0),
           child: Image.asset(
             "images/Easy-Charge.png",
             width: 160,
             height: 140,
           ),
         ),
        // IconButton(
        //   color: Colors.black,
        //   onPressed: () => Get.back(),
        //   icon: Icon(Icons.menu_rounded),iconSize: 34,
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 2.5),
            child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.menu_rounded,
                  color: Colors.black,
                  size: 36,
                )),
          )
          // MenuButton(
          //   alignment: Alignment.topLeft,
          //   menuClick: () => Get.back(),
          // )
        ],
        title: Text(
          "Bank Accounts / Cards",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Material(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: double.infinity,
              //height: double.infinity,
              // margin:  EdgeInsets.only(top: kToolbarHeight),
              child: Padding(
                padding: EdgeInsets.only(
                    //top: kToolbarHeight,
                    // left: _paddLR,
                    right: _paddLR),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      //   child: InkWell(
                      //     child: Text(
                      //       "< back",
                      //       style: _theme.boxPrimaryTextBold,
                      //     ),
                      //     onTap: () {
                      //       Get.back();
                      //     },
                      //   ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 20,
                        //   //height:  kToolbarHeight
                        //   //child: Text("My Credit Card",style: TextStyle(color: Colors.black45),),
                        // ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   "Payment",
                            //   style: TextStyle(
                            //     color: _theme.secondaryColor,
                            //     fontWeight: FontWeight.w900,
                            //     fontSize: 30,
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            // Icon(
                            //   Icons.payment_outlined,
                            //   size: 30,
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                          // height: _sectionH
                        ),
                        TextLabel(
                          label: Text(
                            "     My Credit Card",
                            style: TextStyle(color: Colors.black45),
                          ),
                          // Text("Your Credit Card",
                          //     style: _theme.textLabelStyle),
                          text: CreditCardList(),
                          position: TextLabelDisplayFormat.TEXTBELOW,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class CreditCardList extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    double _screenW = MediaQuery.of(context).size.width;
    double _screenH = MediaQuery.of(context).size.height;

    double _sectionH = (_screenH) / 16;
    double _paddLR = _screenW * .1;
    double fontSize = _sectionH / 3.5;

    final font1 =
        _theme.fontLableStyle(fontSize: fontSize, color: _theme.secondaryColor);
    final font2 = _theme.fontLableStyle(
        fontSize: fontSize, color: _theme.primaryColor); //_sectionHeight / 6

    return GetX<AuthController>(
      init: Get.find<AuthController>(),
      initState: (_) {},
      builder: (ctrl) {
        List<Widget> cards = [];
        for (var card in ctrl.chargerUser.cards) {
          cards.add(Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/icon_payment.png",
                    height: 70,
                    width: 70,
                  ),
                  Text(
                    "Card ${card.maskedCardNo} ",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                    //font1
                  ),
                  Spacer(),
                  // SizedBox(
                  //   width: 30,
                  // ),
                  card.primary
                      ? Text("(primary)", style: font2)
                      : SizedBox.shrink(),
                  SizedBox(
                    width: 5,
                  ),
                  Material(
                    child: InkWell(
                      child: Icon(Icons.delete_outlined,
                          color: _theme.primaryColor),
                      onTap: () {},
                      splashColor: _theme.secondaryColor,
                    ),
                  ),
                ],
              )));
        }

        cards.add(SizedBox(
          height: 10,
        ));
        cards.add(
          Material(
            child: Container(
              //ตัวก่อน InkWell
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  Get.toNamed("/addpayment-page");
                },
                child: Text(
                  "+ Add card",
                  style: TextStyle(color: _theme.darkColor, fontSize: 16),
                ),
              ),
              // onTap: () {
              //   Get.toNamed("/addpayment-page");
              // },
              // splashColor: _theme.primaryColor,
            ),
          ),
        );
        return Padding(
            padding: EdgeInsets.only(left: _paddLR / 2),
            child: Column(
              children: cards,
            ));
      },
    );

    return Padding(
      padding: EdgeInsets.only(left: _paddLR),
      child: Material(
        child: InkWell(
          child: Text(
            "+ Add card",
            style: TextStyle(color: _theme.darkColor, fontSize: 16),
          ),
          onTap: () {
            Get.toNamed("/addpayment-page");
          },
          splashColor: _theme.primaryColor,
        ),
      ),
    );
  }

  _showSnackBar(String msg) {
    Get.snackbar("Msg", msg);
  }
}

void ShowAlertDialog(BuildContext context) {
  Widget okBtn = FlatButton(
    onPressed: () {},
    child: Text("Pay"),
  );
  Widget cancel = FlatButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text("Cancel"),
  );
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    title: Text("Warning"),
    content: Text("This is an alert Dialog demo which is create"),
    actions: [okBtn, cancel],
  );
  showDialog(
      context: context,
      builder: (BuildContext buildercontext) {
        return alert;
      });
  //     title: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           "TEST",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),
  //         )
  //       ],
  //     ),
  // showDialog(
  //   builder: (context)=> AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //     title: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           "TEST",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),
  //         )
  //       ],
  //     ),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Container(
  //           child: Text("100"),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Container(
  //               width: 110,
  //               child: RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //                 onPressed: (){},
  //                 child: Text("Cancel"),
  //               ),
  //             ),
  //             Container(
  //               width: 110,
  //               child: RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //                 onPressed: (){},
  //                 child: Text("Pay"),
  //               ),
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  // ),);
}
