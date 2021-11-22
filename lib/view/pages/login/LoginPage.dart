import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/LoginController.dart';
import 'package:ez_mobile/view/pages/signup/SignupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  LoginController ctrl = LoginController();

  @override
  Widget build(BuildContext context) {
    double _screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Material(
            child: Container(
              color: Colors.white,
              //height: double.infinity,
              child: Column(
                //color: _theme.lightColor,
                children: [
                  Image.asset(
                    "images/BannerLogin.png",
                    // width: 160,
                    // height: 160,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        // top: kToolbarHeight,
                        left: 25,
                        right: 25),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        width: _screenW,
                        // height: double.infinity,
                        color: _theme.lightColor,
                        child: Stack(
                          children: [
                            ctrl.isShowLoading
                                ? LoadingDialog(top: kToolbarHeight * 4)
                                : SizedBox.shrink(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // CloseButton(),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Welcome to EasyCharge",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Center(
                                //   child: Padding(
                                //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                //     child: Text(
                                //       "Sign in with your email and password  \nor continue with social media.",
                                //       textAlign: TextAlign.center,style: TextStyle(fontSize: 16),
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(height: 20,),
                                // Container(child: Row(children: [
                                //   Column(children: [
                                //     SizedBox(width: 5,),
                                //     EZTextFormField(
                                //       label: "Email",
                                //       labelStyle: _theme.textLabelStyle,
                                //       hint: "Enter your Email address",
                                //       onChange: ctrl.emailChanged,
                                //     ),
                                //     SizedBox(width: 5,),
                                //   ],)
                                // ],),),

                                EZTextFormField(
                                  label: "Email",
                                  labelStyle: _theme.textLabelStyle,
                                  hint: "Enter your Email address",
                                  onChange: ctrl.emailChanged,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                EZPasswordFormField(
                                  label: "Password",
                                  labelStyle: _theme.textLabelStyle,
                                  hint: "Enter your password",
                                  onChange: ctrl.pwd1Changed,
                                ),

                                // SizedBox(
                                //   height: 10,
                                // ),

                                Row(
                                  children: [
                                    // Checkbox(
                                    //   value: false,
                                    //   onChanged: (value) {},
                                    // ),
                                    // Text("Remember me"),
                                    //Spacer(),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // TextButton(
                                    //   onPressed: () {},
                                    //   child: Text(
                                    //     "Forget Password ?",
                                    //     style: TextStyle(color: Colors.grey
                                    //         //decoration: TextDecoration.underline
                                    //         ),
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //     width: 10
                                    // ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5,top: 20),
                                    child: SizedBox(
                                      width: 350,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40))),
                                        color: k1rrorColor,
                                        padding: EdgeInsets.all(10),
                                        // ElevatedButton(
                                        //
                                        //   style: ElevatedButton.styleFrom(
                                        //     primary: _theme.primaryColor,
                                        //     textStyle: TextStyle(
                                        //       color: _theme.lightColor,
                                        //     ),
                                        //   ),
                                        child: Text(
                                          "Log in",
                                          style: TextStyle(
                                            fontSize: 16,
                                            //fontWeight: FontWeight.w900,
                                            color: _theme.lightColor,
                                          ),
                                        ),
                                        onPressed: () {
                                          if (ctrl.isValidInput()) {
                                            ctrl.showLoading = true;
                                            ctrl.doLogin();
                                            ctrl.showLoading = false;
                                          } else {
                                            ctrl.showLoading = false;
                                            Get.snackbar(
                                              "Error",
                                              ctrl.errMSG,
                                              snackPosition: SnackPosition.TOP,
                                              snackStyle: SnackStyle.FLOATING,
                                              colorText: Colors.red,
                                              isDismissible: true,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                //SizedBox(height: 20),
                                Container(
                                  color: Colors.white,
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                75, 5, 20, 0
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text("Don't have an account?"),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                Text(
                                                  "Sign up",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: _theme.secondaryColor,
                                                      fontWeight: FontWeight.bold
                                                    // decoration: TextDecoration.underline
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () => Get.toNamed("/signup"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class LoadingDialog extends StatelessWidget {
  CustomTheme _theme;

  final double top;
  final double width;
  final double height;

  LoadingDialog({this.top, this.width: 60, this.height: 60}) {
    _theme = CustomTheme.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(top: top),
        child: CircularProgressIndicator(
          backgroundColor: _theme.greyColor,
          valueColor: AlwaysStoppedAnimation(_theme.primaryColor),
        ),
      ),
    );
  }
}
