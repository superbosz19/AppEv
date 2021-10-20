import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/controller/PaymentConfigController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class PaymentConfigPage extends StatelessWidget{

  CustomTheme _theme;
  AuthController auth;
  PaymentConfigController payment;

  PaymentConfigPage(){
    Get.put(PaymentConfigController());
  }

  @override
  Widget build(BuildContext context) {

    _theme = CustomTheme.instance;
    auth = Get.find<AuthController>();
    // profileCtrl.email.value = auth.chargerUser.email;
    // profileCtrl.phone.value = auth.chargerUser.phone;

    double _screenW = MediaQuery.of(context).size.width;
    double _screenH =  MediaQuery.of(context).size.height;

    double _sectionH = (_screenH ) /16;
    double _paddLR = _screenW*.1;




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
                padding:
                EdgeInsets.only(
                    //top: kToolbarHeight,
                    left: _paddLR,
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
                        SizedBox(
                          height: 20,
                            //height:  kToolbarHeight
                        ),
                        Row(
                          children: [
                            Text(
                               "Payment",
                              style: TextStyle(
                                color: _theme.secondaryColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.payment_outlined,size: 30,)
                          ],
                        ),

                        SizedBox(
                          height: 20,
                           // height: _sectionH
                        ),

                        TextLabel(
                          label: Text("Your Credit Card", style: _theme.textLabelStyle),
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

class CreditCardList extends StatelessWidget{

  CustomTheme _theme = CustomTheme.instance;
  @override
  Widget build(BuildContext context) {


    double _screenW = MediaQuery.of(context).size.width;
    double _screenH =  MediaQuery.of(context).size.height;

    double _sectionH = (_screenH ) /16;
    double _paddLR = _screenW*.1;
    double fontSize =_sectionH/3.5;

    final font1 = _theme.fontLableStyle(fontSize: fontSize, color: _theme.secondaryColor);
    final font2 = _theme.fontLableStyle(fontSize: fontSize, color: _theme.primaryColor);//_sectionHeight / 6

    return GetX<AuthController>(
  init: Get.find<AuthController>(),
  initState: (_) {},
  builder: (ctrl) {
    List<Widget> cards = [];
    for (var card in ctrl.chargerUser.cards){
      cards.add(
        Padding(
          padding: EdgeInsets.only(top:10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Card ${card.maskedCardNo} " , style: font1 ),
              SizedBox(width: 5,),
              card.primary?Text("(primary)" , style: font2):SizedBox.shrink(),
              SizedBox(width: 5,),
              Material(
                child: InkWell(
                    child: Icon(Icons.delete_outlined, color: _theme.primaryColor),
                  onTap: (){},
                  splashColor: _theme.secondaryColor,
                ),
              ),
            ],
          )
        )

      );
    }

    cards.add(
      SizedBox(height: 10,)
    );
    cards.add(
      Material(
        child: InkWell(
          child: Text(
            "+ Add card",
            style: TextStyle(
                color: _theme.darkColor, fontSize: 16),
          ),
          onTap: (){
            Get.toNamed("/addpayment-page");
          },
          splashColor: _theme.primaryColor,
        ),

      ),
    );
    return Padding(
      padding:  EdgeInsets.only(left: _paddLR/2),
      child: Column(
        children: cards,
      )
    );
  },
);
    

    return Padding(
     padding:  EdgeInsets.only(left: _paddLR),
     child: Material(
       child: InkWell(
         child: Text(
           "+ Add card",
           style: TextStyle(
               color: _theme.darkColor, fontSize: 16),
         ),
           onTap: (){
              Get.toNamed("/addpayment-page");
           },
           splashColor: _theme.primaryColor,
       ),

     ),
   );





  }

  _showSnackBar(String msg){
    Get.snackbar("Msg", msg);
  }



}