import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/controller/ProfileController.dart';
import 'package:ez_mobile/view/components/CloseButton.dart';
import 'package:ez_mobile/view/pages/signup/SignupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  CustomTheme _theme;

  AuthController auth;
  ProfileController profileCtrl;
  ProfilePage() {
    _theme = CustomTheme.instance;
    auth = Get.find<AuthController>();
    profileCtrl = Get.put(ProfileController());
    profileCtrl.email.value = auth.chargerUser.email;
    profileCtrl.phone.value = auth.chargerUser.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 3.0),
          child: Image.asset(
            "images/Easy-Charge.png",
            width: 160,
            height: 160,
          ),
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
                padding:
                    EdgeInsets.only(top: kToolbarHeight, left: 10, right: 10),
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
                    profileCtrl.isUploading
                        ? Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  //top: 100.0
                              ),
                              child: CircularProgressIndicator(
                                color: _theme.primaryColor,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       // SizedBox(height: kToolbarHeight / 2),
                        Container(
                          // color: Colors.redAccent,
                          child: Column(
                            children: [
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 18, //_theme.fontSizeBody1,
                                      color: _theme.primaryColor,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "   Profile \n\n",
                                        style: TextStyle(
                                          color: _theme.secondaryColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 30,
                                        ),
                                      ),
                                      new TextSpan(
                                        text:
                                            "ID: ${Get.find<AuthController>().chargerUser.primaryID}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: _theme.greyColorFont),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ProfileImage(),
                        SizedBox(height: 5.0,),
                        Center(
                          child: TextLabel(
                            label: Center(
                              child: Text("Welcome !",
                                style: TextStyle(fontSize: 20,  fontWeight: FontWeight.bold, color: k1rrorColor),
                                //style: _theme.textLabelStyle,
                                ),
                            ),
                            text: Padding(
                              padding: const EdgeInsets.only(left: 0,top: 0, right: 0),
                              child: Center(
                                child: Text(
                                 "${Get.find<AuthController>().chargerUser.displayName}",
                                  style: TextStyle(
                                      color: _theme.secondaryColor, fontSize: 18),
                                ),
                              ),
                            ),
                            position: TextLabelDisplayFormat.TEXTBELOW,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        EZTextFormField(
                          label: "Phone Number",
                          initialValue: profileCtrl.phone.value,
                          labelStyle: _theme.textLabelStyle,
                          hint: "Phone: ${auth.chargerUser.phone}",
                          onChange: profileCtrl.phoneChanged,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        EZTextFormField(
                          label: "Email",
                          initialValue: profileCtrl.email.value,
                          labelStyle: _theme.textLabelStyle,
                          hint: "Email: ${auth.chargerUser.email}",
                          onChange: profileCtrl.emailChanged,
                        ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        IdCardSection(),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Container(
                         // color: Colors.greenAccent,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: _theme.scanButtonStyle,
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: _theme.lightColor,
                                        fontSize: 16 ,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    profileCtrl.doSave();
                                  },
                                ),
                              ),
                            ),
                          ),
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

class ProfileImage extends StatelessWidget {
  CustomTheme _theme;
  ProfileImage() {
    _theme = CustomTheme.instance;
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imgW = (screenW / 3.5);
    return GetX<AuthController>(
      init: Get.find<AuthController>(),
      initState: (_) {},
      builder: (ctrl) {
        return Center(
          child: InkWell(
            child: Container(
              //margin: EdgeInsets.all(20),
              width: imgW,
              height: imgW,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _theme.secondaryColor),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(ctrl.chargerUser.avatar),
                  )),
            ),
            onTap: () {
              Get.toNamed("/change-avatar");
            },
          ),
        );
      },
    );
  }
}

class IdCardSection extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,

      // alignment: Alignment.centerLeft,
      //color: Colors.redAccent,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: TextLabel(
            label: Text("ID Card ", style: _theme.textLabelStyle),
            text: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Icon(Icons.add_a_photo_outlined,
                      // color: _theme.primaryColor,
                      size: 28),
                  Column(
                    children: [
                      SizedBox(width: 10),
                    ],
                  ),
                  Get.find<AuthController>().chargerUser.verified
                      ? Text("Verifed )", style: _theme.boxSecondaryText)
                      : Text(
                          "( Not Verifed )",
                          style: TextStyle(
                            color: _theme.warningColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                ],
              ),
            ),
            position: TextLabelDisplayFormat.TEXTRIGHT,
          ),
        ),
        splashColor: _theme.primaryColor,
        onTap: () {
          Get.toNamed("/idcard-page");
        },
      ),
    );
  }
}
