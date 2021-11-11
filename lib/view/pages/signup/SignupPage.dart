import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/SignupPageController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/route_manager.dart';

// ignore: must_be_immutable
class SignupPage extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  SignupPageController ctrl;

  SignupPage() {
    ctrl = Get.put(SignupPageController(), tag: "signUpCtrl");
    ctrl.resetVars();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double _screenW = MediaQuery.of(context).size.width;
    //double _screenH =  MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(backgroundColor: k1rrorColor,),
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/BG1.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Form(
          // child: Material(
          //
          //color: _theme.lightColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,

              // child: Container(
              //
              //   width: _screenW,
              // height: double.infinity,
              //color: _theme.lightColor,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CloseButton(),

                  Center(
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      //color: Colors.greenAccent,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Text(
                              "Sign up",
                              //style: _theme.headerStyle,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Text(
                              "Create a new account.",
                              style: TextStyle(fontSize: 18,color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // ),
                  Container(
                    height: 380,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    //color: Colors.green,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                // top: kToolbarHeight,
                                left: 25,
                                right: 25),
                            child: Column(
                              children: [
                                EZTextFormField(
                                  label: "Name",
                                  labelStyle: _theme.textLabelStyle,
                                  hint: "Full name",
                                  onChange: ctrl.nameChanged,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                EZTextFormField(
                                  label: "Phone Number",
                                  labelStyle: _theme.textLabelStyle,
                                  hint: "Phone Number",
                                  onChange: ctrl.phoneChanged,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                EZTextFormField(
                                  label: "Email",
                                  labelStyle: _theme.textLabelStyle,
                                  hint: "E-mail Address",
                                  onChange: ctrl.emailChanged,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                EZPasswordFormField(
                                  label: "Password",
                                  labelStyle: _theme.textLabelStyle,
                                  hint: "Create password",
                                  onChange: ctrl.pwd1Changed,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                EZPasswordFormField(
                                  label: "Re-enter Password",
                                  labelStyle: _theme.textLabelStyle,
                                  hint: "Re-enter Password",
                                  onChange: ctrl.pwd2Changed,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    // child:
                    // Padding(
                    //   padding: const EdgeInsets.all(20.0),
                    // child: SizedBox(
                    //   width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                        width: 350,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
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
                            "Sign up",
                            style: TextStyle(
                              fontSize: 16,
                              //fontWeight: FontWeight.w900,
                              color: _theme.lightColor,
                            ),
                          ),
                          onPressed: () {
                            if (ctrl.isValidInput()) {
                              Get.toNamed("/confirm-signup");
                            } else {
                              Get.snackbar("Error", ctrl.errMSG,
                                  snackPosition: SnackPosition.TOP,
                                  snackStyle: SnackStyle.FLOATING,
                                  colorText: Colors.red);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  // ),
                  // ),
                ],
              ),
            ),
            // ),
            //  ),
          ),
        ),
      )),
    );
  }
}

class EZPasswordFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextStyle labelStyle;
  final double spaceH;
  final Function onChange;

  const EZPasswordFormField(
      {Key key,
      this.label,
      this.hint,
      this.labelStyle,
      this.spaceH: 10,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: labelStyle,
        // ),
        SizedBox(
          height: spaceH,
          width: 20,
        ),
        Stack(
          children: [
            TextFormField(
              onChanged: onChange,
              obscureText: true,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.greenAccent.shade200),
                  gapPadding: 10,
                ),

                //labelText: 'Enter your username',
                hintText: hint,
              ),
            ),
            // Positioned(
            //   top: 2,
            //   right: 10,
            //   child: IconButton(
            //     icon: Icon(
            //       Icons.vpn_key,
            //       //_obscureText ? Icons.visibility : Icons.visibility_off,
            //     ), onPressed: () {  },
            //
            //     // onPressed: () {
            //     //   setState(() {
            //     //     _obscureText = !_obscureText;
            //     //   });
            //     // }),
            //   ),
            // ),
          ],
        )
      ],
    );
  }
}

class EZTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextStyle labelStyle;
  final double spaceH;
  final onChange;
  final bool readOnly;
  final String initialValue;
  final List<TextInputFormatter> formatters;

  const EZTextFormField(
      {Key key,
      this.label,
      this.hint,
      this.labelStyle,
      this.spaceH: 5,
      this.onChange,
      this.readOnly: false,
      this.initialValue: "",
      this.formatters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: labelStyle,
        // ),
        SizedBox(
          height: spaceH,
        ),
        !readOnly
            ? TextFormField(
                initialValue: this.initialValue,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                    // child: Icon(Icons.email),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.greenAccent),
                    gapPadding: 10,
                  ),
                  //contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  //labelText: 'Enter your username',
                  hintText: hint,
                ),
                inputFormatters: formatters ?? [],
                onChanged: onChange,
              )
            : Text(
                label,
                style: labelStyle,
              ),
      ],
    );
  }
}

class EZSearchFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextStyle labelStyle;
  final double spaceH;
  final Function onChange;

  final IconData icon;

  const EZSearchFormField(
      {Key key,
      this.label,
      this.hint,
      this.labelStyle,
      this.spaceH: 5,
      this.onChange,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomTheme _theme = CustomTheme.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null && label.isNotEmpty
            ? Text(
                label,
                style: labelStyle,
              )
            : SizedBox.shrink(),
        SizedBox(
          height: spaceH,
        ),
        Stack(
          children: [
            TextFormField(
              style:
                  TextStyle(fontSize: 12.0, height: 1.0, color: Colors.black),
              onChanged: onChange,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: _theme.secondaryColor,
                  ),
                ),

                //labelText: 'Enter your username',
                hintText: hint,
                filled: true,
                fillColor: _theme.lightColor,
              ),
            ),
            Positioned(
              top: 2,
              right: 10,
              child: IconButton(
                icon: Icon(
                  icon,
                  color: _theme.secondaryColor,
                  //_obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  Get.toNamed("/search");
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
