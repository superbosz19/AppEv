import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/controller/SignupPageController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmSignupPage extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    double _screenW = MediaQuery.of(context).size.width;
    double _screenH = MediaQuery.of(context).size.height;

    double _btnTop = (_screenH - (kToolbarHeight * 2)) - 30;
    //SignupPageController ctrl = Get.put(SignupPageController(), tag:"signUpCtrl");

    return GetX<SignupPageController>(
      init: Get.find<SignupPageController>(tag:"signUpCtrl"),
      initState: (_) {},
      builder: (ctrl) {

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Material(
            color: _theme.lightColor,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: kToolbarHeight, left: 10, right: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: _screenW,
                  // height: double.infinity,
                  color: _theme.lightColor,
                  child: Stack(
                    children: [
                      ctrl.isShowLoading?Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top:200.0),
                          child: CircularProgressIndicator(
                            color: _theme.primaryColor,
                          ),
                        ),
                      ):SizedBox.shrink(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "User Information",
                              style: _theme.headerStyle,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextLabel(
                            label: Text("Name", style: _theme.textLabelStyle),
                            text: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                ctrl.name.value,
                                style: TextStyle(color: _theme.secondaryColor),
                              ),
                            ),
                            position: TextLabelDisplayFormat.TEXTBELOW,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextLabel(
                            label: Text("Phone Number",
                                style: _theme.textLabelStyle),
                            text: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                ctrl.phone.value,
                                style: TextStyle(color: _theme.secondaryColor),
                              ),
                            ),
                            position: TextLabelDisplayFormat.TEXTBELOW,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextLabel(
                            label: Text("Email", style: _theme.textLabelStyle),
                            text: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                ctrl.email.value,
                                style: TextStyle(color: _theme.secondaryColor),
                              ),
                            ),
                            position: TextLabelDisplayFormat.TEXTBELOW,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(top: _btnTop - 50),
                      //   child: Align(
                      //     alignment: Alignment.bottomCenter,
                      //     child: Padding(
                      //       padding:
                      //           const EdgeInsets.only(right: 20.0, left: 20.0),
                      //       child: SizedBox(
                      //         width: double.infinity,
                      //         child: ElevatedButton(
                      //           style: ElevatedButton.styleFrom(
                      //             primary: _theme.primaryColor,
                      //             textStyle: TextStyle(
                      //               color: _theme.lightColor,
                      //             ),
                      //           ),
                      //           child: Text(
                      //             "<< Back",
                      //             style: TextStyle(
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.w900,
                      //               color: _theme.lightColor,
                      //             ),
                      //           ),
                      //           onPressed: () {
                      //             Get.back();
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(top: _btnTop),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 20.0, left: 20.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: _theme.primaryColor,
                                  textStyle: TextStyle(
                                    color: _theme.lightColor,
                                  ),
                                ),
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: _theme.lightColor,
                                  ),
                                ),
                                onPressed: () async {
                                  print("start register");
                                  ctrl.showLoading = true;
                                  bool success = await ctrl.doRegister();
                                  print("register result => ${success}");
                                  if (success) {
                                    ctrl.showLoading = false;
                                    Get.snackbar("Register Success", "Congratulations", colorText: _theme.primaryColor, backgroundColor: _theme.lightColor);
                                    Future.delayed(Duration(seconds: 1));
                                    Get.offAndToNamed("/");
                                  }else{
                                    ctrl.showLoading = false;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
