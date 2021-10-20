import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/controller/IDCardController.dart';
import 'package:ez_mobile/view/pages/signup/SignupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class IDCardPage extends StatelessWidget{

  CustomTheme _theme;
  IDCardController ctrl;
  AuthController auth ;
  @override
  Widget build(BuildContext context) {
    _theme = CustomTheme.instance;
    auth = Get.find<AuthController>();
    ctrl = Get.put(IDCardController());
    ctrl.idCardNo = auth.chargerUser.idCard;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(backgroundColor: k2rrorColor,),
      body: Material(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: double.infinity,
              child: Padding(
                padding:
                EdgeInsets.only(
                    //top: kToolbarHeight,
                    left: 10,
                    right: 10),
                child: Stack(
                  children: [
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: InkWell(
                    //     child: Text(
                    //       "< back",
                    //       style: _theme.boxPrimaryTextBold,
                    //     ),
                    //     onTap: () {
                    //       Get.back();
                    //     },
                    //   ),
                    // ),
                    LoadingDisplay(),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: kToolbarHeight / 2),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 18, //_theme.fontSizeBody1,
                              color: _theme.primaryColor,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "    ID Card \n",
                                style: TextStyle(
                                  color: _theme.secondaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30,
                                ),
                              ),
                              TextSpan(
                                text:
                                "(${auth.chargerUser.primaryID})",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: _theme.greyColorFont),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: EZTextFormField(
                            label: "ID Card No.",
                            initialValue: ctrl.idCardNo,
                            labelStyle: _theme.textLabelStyle,
                            hint: "${auth.chargerUser.idCard}",
                            onChange: ctrl.idCardChanged,
                          ),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        //SizedBox(height: 10,),
                        IdCardImageSection(
                          text: "ID Card (Front)",
                          onTap:  () { Get.find<IDCardController>().updateIDCardImageFront();},
                        ),
                        //SizedBox(height: 10,),
                        IdCardImageSection(
                          text: "ID Card (Back)",
                          onTap:  () { Get.find<IDCardController>().updateIDCardImageBack();},
                          isFront: false,
                        ),
                        //SizedBox(height: 10,),
                        IdCardSaveButton(),

                      ],
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}

class IdCardSaveButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    CustomTheme _theme = CustomTheme.instance;
    IDCardController ctrl2 = Get.find<IDCardController>();
    return GetX<IDCardController>(
  init: ctrl2,
  initState: (_) {},
  builder: (logic) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: _theme.scanButtonStyle,
            child: Text(
              "Save",
              style: TextStyle(color: _theme.lightColor),
            ),
            onPressed:(logic.useLocalImage || logic.idCardUpdate)?() {
              logic.doSave();
            }:null,
          ),
        ),
      ),
    );
  },
);

  }

}

class IdCardImageSection extends StatelessWidget{
  VoidCallback onTap;
  String text;
  bool isFront;

  IdCardImageSection({this.onTap:null, this.text, this.isFront:true}){


  }
  @override
  Widget build(BuildContext context) {
    CustomTheme _theme = CustomTheme.instance;
    double screenW = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imgW = (screenW / 2.5);
    return GetX<IDCardController>(
      init: Get.find<IDCardController>(),
      initState: (_) {},
      builder: (ctrl) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextLabel(
            position:  TextLabelDisplayFormat.TEXTBELOW,
            label: Text(text, style: _theme.textLabelStyle),
            text: Center(
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.all(20),
                   width: screenW,
                   height: imgW,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: _theme.secondaryColor),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: ctrl.getImage(isFront),
                      ),
                  ),
                ),
                onTap: onTap,
              ),
            ),
          ),
        );
      },
    );
  }


}

class LoadingDisplay extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    CustomTheme _theme  =CustomTheme.instance;
    return GetX<IDCardController>(
  init: Get.find<IDCardController>(),
  initState: (_) {},
  builder: (ctrl) {
    if (ctrl.isUploading) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: CircularProgressIndicator(
            color: _theme.primaryColor,
          ),
        ),
      );
    }else{
      return SizedBox.shrink();
    }
  },
);
  }
  
}


