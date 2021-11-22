import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/SignupPageController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfirmSignupPage extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  var defaulfText = TextStyle(color: Colors.black,fontSize: 14,
      //fontFamily: 'PhithanGreen1'
  );
  var linkText = TextStyle(color: Colors.green,fontSize: 14,
      //fontFamily: 'PhithanGreen1'
  );

  @override
  Widget build(BuildContext context) {
    double _screenW = MediaQuery.of(context).size.width;
    double _screenH = MediaQuery.of(context).size.height;

    double _btnTop = (_screenH - (kToolbarHeight * 2)) - 30;
    //SignupPageController ctrl = Get.put(SignupPageController(), tag:"signUpCtrl");

    return GetX<SignupPageController>(
      init: Get.find<SignupPageController>(tag: "signUpCtrl"),
      initState: (_) {},
      builder: (ctrl) {
        return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/BG1.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                //color: _theme.lightColor,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kToolbarHeight, left: 10, right: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        width: _screenW,
                        // height: double.infinity,
                        //color: _theme.lightColor,
                        child: Stack(
                          children: [
                            ctrl.isShowLoading
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(top: 200.0),
                                      child: CircularProgressIndicator(
                                        color: _theme.primaryColor,
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "Verify your account",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        //fontFamily: "PhithanGreen1",
                                        color: Colors.white),
                                    //style: _theme.headerStyle,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  height: 380,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  //color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              // top: kToolbarHeight,
                                              // left: 10,
                                              // right: 10
                                              ),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "       Full name",
                                                      style: TextStyle(
                                                        color: k2rrorColor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        //fontFamily: "PhithanGreen1"
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 35,
                                                        ),
                                                        Text(
                                                          ctrl.name.value,
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 20,
                                                            //fontFamily: "PhithanGreen1"
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "       Email Address",
                                                      style: TextStyle(
                                                        color: k2rrorColor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        //fontFamily: "PhithanGreen1"
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 35,
                                                        ),
                                                        Text(
                                                          ctrl.email.value,
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 20,
                                                            //fontFamily: "PhithanGreen1"
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1),
                                                        ),
                                                      ),
                                                      width: double.infinity,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "       Phone number",
                                                            style: TextStyle(
                                                              color:
                                                                  k2rrorColor,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              //fontFamily: "PhithanGreen1"
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 35,
                                                              ),
                                                              Text(
                                                                ctrl.phone
                                                                    .value,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 20,
                                                                  //fontFamily: "PhithanGreen1"
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            height: 60,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                top: BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1),
                                                              ),
                                                            ),
                                                            width:
                                                                double.infinity,
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                          style:
                                                                              defaulfText,
                                                                          text:
                                                                              "By signing up, I agree to the "),
                                                                      TextSpan(
                                                                        style:
                                                                            linkText,
                                                                        text:
                                                                            "Privacy Policy",
                                                                        recognizer:
                                                                            TapGestureRecognizer()
                                                                              ..onTap = () async {
                                                                                var url = "https://www.youtube.com/watch?v=s6FWuS56iWo";
                                                                                if (await canLaunch(url)) {
                                                                                  await launch(url);
                                                                                } else {
                                                                                  throw "Cannot load Url";
                                                                                }
                                                                              },
                                                                      ),
                                                                      TextSpan(
                                                                          style:
                                                                          defaulfText,
                                                                          text:
                                                                          " and "),
                                                                      TextSpan(
                                                                        style:
                                                                        linkText,
                                                                        text:
                                                                        "\nTerms of Service.",
                                                                        recognizer:
                                                                        TapGestureRecognizer()
                                                                          ..onTap = () async {
                                                                            var url = "https://www.youtube.com/watch?v=s6FWuS56iWo";
                                                                            if (await canLaunch(url)) {
                                                                              await launch(url);
                                                                            } else {
                                                                              throw "Cannot load Url";
                                                                            }
                                                                          },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10.0),
                                  child: SizedBox(
                                    width: double.infinity,
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
                                          "Confirm",
                                          style: TextStyle(
                                            fontSize: 16,
                                            //fontWeight: FontWeight.w900,
                                            color: _theme.lightColor,
                                          ),
                                        ),
                                        onPressed: () async {
                                          print("start register");
                                          ctrl.showLoading = true;
                                          bool success =
                                              await ctrl.doRegister();
                                          print(
                                              "register result => ${success}");
                                          if (success) {
                                            ctrl.showLoading = false;
                                            Get.snackbar("Register Success",
                                                "Congratulations",
                                                colorText: _theme.primaryColor,
                                                backgroundColor:
                                                    _theme.lightColor);
                                            Future.delayed(
                                                Duration(seconds: 1));
                                            Get.offAndToNamed("/");
                                          } else {
                                            ctrl.showLoading = false;
                                          }
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            //
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
// class test extends StatefulWidget {
//   const test({Key? key}) : super(key: key);
//
//   @override
//   _testState createState() => _testState();
// }
//
// class _testState extends State<test> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TextLabel(
//         label: Text("Email",
//             style:
//             _theme.textLabelStyle),
//         text: Padding(
//           padding:
//           const EdgeInsets.only(
//               left: 0.0),
//           child: Text(
//             ctrl.email.value,
//             style: TextStyle(
//                 color: _theme
//                     .secondaryColor),
//           ),
//         ),
//         //position: TextLabelDisplayFormat.TEXTBELOW,
//       ),
//         SizedBox(
//           height: 10,
//         ),
//         TextLabel(
//           label: Text("Phone Number",
//               style:
//               _theme.textLabelStyle),
//           text: Padding(
//             padding:
//             const EdgeInsets.only(
//                 left: 10.0),
//             child: Text(
//               ctrl.phone.value,
//               style: TextStyle(
//                   color: _theme
//                       .secondaryColor),
//             ),
//           ),
//           // position: TextLabelDisplayFormat.TEXTBELOW,
//         ),
//     );
//   }
// }
