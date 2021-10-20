import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/controller/PaymentConfigController.dart';
import 'package:ez_mobile/controller/ProfileController.dart';
import 'package:ez_mobile/models/ChargerUser.dart';
import 'package:ez_mobile/services/FirebaseService.dart';
import 'package:ez_mobile/view/pages/signup/SignupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class AddPaymentPage extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  // PaymentConfigController paymentCtrl = Get.find<PaymentConfigController>();

  @override
  Widget build(BuildContext context) {
    _theme = CustomTheme.instance;
    // profileCtrl.email.value = auth.chargerUser.email;
    // profileCtrl.phone.value = auth.chargerUser.phone;

    double _screenW = MediaQuery.of(context).size.width;
    double _screenH = MediaQuery.of(context).size.height;

    double _sectionH = (_screenH) / 25;
    double _paddLR = _screenW * .1;
    double _fontTitleSize = _sectionH * .7;
    double _fontLabelSize = _sectionH * .5;
    TextStyle _lableStyle = _theme.fontLableStyle(
      fontSize: _fontLabelSize,
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(backgroundColor: k2rrorColor,),
      body: Material(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: double.infinity,
              //height: double.infinity,
              // margin:  EdgeInsets.only(top: kToolbarHeight),
              child: Padding(
                padding: EdgeInsets.only(
                   // top: kToolbarHeight,
                    left: _paddLR,
                    right: _paddLR),
                child: GetX<PaymentConfigController>(
                  init: Get.find<PaymentConfigController>(),
                  initState: (_) {},
                  builder: (paymentCtrl) {
                    return Stack(
                      children: [
                        // Align(
                        //   alignment: Alignment.topLeft,
                        // //   child: InkWell(
                        // //     child: Text(
                        // //       "< back",
                        // //       style: _theme.boxPrimaryTextBold,
                        // //     ),
                        // //     onTap: () {
                        // //       Get.back();
                        // //     },
                        // //   ),
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                                //height: kToolbarHeight
                            ),
                            Text(
                              "Add Card",
                              style: TextStyle(
                                color: _theme.secondaryColor,
                                fontWeight: FontWeight.w900,
                                fontSize: _fontTitleSize,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                               // height: _sectionH
                            ),
                            EZTextFormField(
                              label: "Card No",
                              initialValue: "",
                              labelStyle: _lableStyle,
                              hint: "xxxx-xxxx-xxxx-xxxx",
                              onChange: paymentCtrl.cardNoChanged,
                              formatters: [
                                CreditCardNumberInputFormatter(),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                                //height: _sectionH
                            ),
                            EZTextFormField(
                              label: "Expiration",
                              initialValue: "",
                              labelStyle: _lableStyle,
                              hint: "09/99",
                              onChange: paymentCtrl.cardExpChanged,
                              formatters: [CreditCardExpirationDateFormatter()],
                            ),
                            SizedBox(
                              height: 5,
                                //height: _sectionH
                            ),
                            EZTextFormField(
                              label: "CVV",
                              initialValue: "",
                              labelStyle: _lableStyle,
                              hint: "999",
                              onChange: paymentCtrl.cardCVVChanged,
                              formatters: [CreditCardCvcInputFormatter()],
                            ),
                            SizedBox(
                              height: 5,
                                //height: _sectionH
                            ),
                            EZTextFormField(
                              label: "Card Holder Name",
                              initialValue: "",
                              labelStyle: _lableStyle,
                              hint: "Name LastName",
                              onChange: paymentCtrl.cardHolderChanged,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextLabel(
                              label: Text(
                                "Primary Card",
                                style: _theme.boxSecondaryText,
                              ),
                              position: TextLabelDisplayFormat.TEXTLEFT,
                              text: Checkbox(
                                value: paymentCtrl.primary.value,
                                onChanged: paymentCtrl.primaryChanged,
                              ),
                            ),
                            SizedBox(height: _sectionH),
                            Container(
                              width: _screenW,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: _theme.primaryColor,
                                  textStyle: TextStyle(
                                    color: _theme.lightColor,
                                  ),
                                ),
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                    fontSize: _fontLabelSize,
                                    fontWeight: FontWeight.w900,
                                    color: _theme.lightColor,
                                  ),
                                ),
                                onPressed:paymentCtrl.isValidInput()?() async {
                                  CardInfo cardInfo = CardInfo(
                                    cardHolder: paymentCtrl.cardHolder.value,
                                    cardNo: paymentCtrl.cardNo.value,
                                    cvv: paymentCtrl.cardCVV.value,
                                    expiryDate: paymentCtrl.cardExp.value,
                                    primary:  paymentCtrl.primary.value,
                                  );

                                  if (cardInfo.cardNo.split(" ").length < 4){
                                    Get.snackbar("Error", "Invalid card ",
                                        colorText: _theme.lightColor, snackPosition: SnackPosition.TOP,
                                        backgroundColor:_theme.secondaryColor
                                    );
                                    return;
                                  }
                                  bool cardExists = await FirebaseService.instance.isCreditCardExist(cardInfo, Get.find<AuthController>().chargerUser.userID);
                                  print("cardExists=> ${cardExists}");
                                  if (cardExists){
                                    Get.snackbar("Error", "Card Already exists",
                                      colorText: _theme.lightColor, snackPosition: SnackPosition.TOP,
                                      backgroundColor:_theme.secondaryColor
                                    );

                                  }else{
                                    FirebaseService.instance
                                        .addCreditCard(cardInfo, Get.find<AuthController>().chargerUser.userID);
                                    print("after addded");
                                    paymentCtrl.primary.value =false;
                                    Get.back();
                                  }
                                  //Get.back();

                                }:null,
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            )),
      ),
    );
  }
}
