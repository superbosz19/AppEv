import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/view/components/MenuButton.dart';
import 'package:ez_mobile/view/pages/favorite/FavoritePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPage extends StatelessWidget {
  //CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Material(
          child: Stack(
            children: [
              MenuList(),
              // MenuButton(
              //   alignment: Alignment.topLeft,
              //   menuClick: () => Get.back(),//Get.toNamed("/"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuListButton extends StatefulWidget {
  final IconData icon;
  final double iconSize;
  final double spaceW;
  final double fontSize;
  final String menuText;
  final String Color;
  final String fontFamily;
  CustomTheme _theme;

  VoidCallback onTap;

  MenuListButton({
    Key key,
    this.icon,
    this.iconSize,
    this.spaceW: 0,
    this.fontSize: 18 /*25*/,
    this.onTap,
    this.menuText,
    this.Color,
    this.fontFamily,
  }) {
    _theme = CustomTheme.instance;
  }

  @override
  _MenuListButtonState createState() => _MenuListButtonState();
}

class _MenuListButtonState extends State<MenuListButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        //color: Colors.redAccent,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              widget.icon,
              //size: widget.iconSize,
            ),
            SizedBox(
              width: widget.spaceW,
            ),
            Text(
              widget.menuText,
              style: TextStyle(
                fontSize: 17,
                //widget.fontSize,
                fontWeight: FontWeight.w400,
                //fontFamily: 'PhithanGreen1',
                //color: widget._theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
      onTap: widget.onTap,
    );
  }
}

class MenuList extends StatefulWidget {
  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  CustomTheme _theme = CustomTheme.instance;

  final double _spaceH = 24;

  @override
  Widget build(BuildContext context) {
    //AuthController _authCtrl = Get.put( AuthController()); // Get.find<AuthController>();

    return GetX<AuthController>(
      init: Get.find<AuthController>(),
      initState: (_) {},
      builder: (ctrl) {
        if (ctrl.user == null || ctrl.user.email == null) {
          return Container(
            height: 280,
            //color: Colors.greenAccent,
            decoration: BoxDecoration(
                //color: Color(0xFFE5E6E7),
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            )),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30,
                  //top: kToolbarHeight * 2,
                  left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 350,
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
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 8, bottom: 8),
                            child: Icon(
                              Icons.commute_outlined,
                              color: Colors.green,
                              size: 40,
                            ),
                          ),
                          MenuListButton(
                            menuText: "Log In",
                            //icon: Icons.login,
                            //iconSize: 30,
                            onTap: () {
                              Get.toNamed("/login");
                            },
                          ),

                          //Icon(Icons.eco,color: Colors.green,)
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // MenuListButton(
                  //   menuText: "Sing Up",
                  //   icon: Icons.app_registration,
                  //   iconSize: 30,
                  //   onTap: () { Get.toNamed("/signup");},
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 350,
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
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 8, bottom: 8),
                            child: Icon(
                              Icons.help_outline,
                              color: Colors.green,
                              size: 40,
                            ),
                          ),
                          MenuListButton(
                            menuText: "Help",
                            //icon: Icons.help_outline,
                            // iconSize: 30,
                            onTap: () {
                              Get.toNamed("/help-page");
                            },
                          ),
                          // Icon(Icons.eco,color: Colors.green,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 70,
                        ),
                        child: Text("Don't have an account?  "),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed("/signup");
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 16,
                              color: _theme.secondaryColor,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
                //color: Color(0xFFE5E6E7),
                //color: Colors.lightGreen,
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(46),
              bottomRight: Radius.circular(46),
            )),
            child: Padding(
              //this.icon, this.iconSize, this.spaceW: 20, this.fontSize: 25, this.onTap
              padding: const EdgeInsets.only(
                  //top: kToolbarHeight * 2,
                  left: 10),
              child: Container(
                //color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Container(
                        // color: Colors.green,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Icon(Icons.bolt_outlined, size: 40,color: Colors.orange,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "Hi !  ${ctrl.chargerUser.firstName} ",
                                    style: TextStyle(
                                      color: _theme.darkColor,
                                      decoration: TextDecoration.none,
                                      fontSize: _spaceH,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'PhithanGreen2',
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.grey,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                        "Find your nearest charging station, find Easycharge"),
                                  ),
                                ),
                              ],
                            ),

                            // SizedBox(
                            //   width: 5,
                            // ),
                            //Icon(Icons.eco,color: Colors.green,)
                          ],
                        ),
                      ),
                    ),
                    //SizedBox(height: _spaceH),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        //color: Colors.white,
                        width: 350,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 8, bottom: 8),
                              child: Image.asset(
                                "images/icon1.png",
                                height: 40,
                                width: 25,
                              ),
                            ),
                            MenuListButton(
                              menuText: "Profile",
                              //icon: Icons.person_rounded,
                              //iconSize: 30,
                              onTap: () {
                                Get.toNamed("/profile-page");
                              },
                            ),
                            //Icon(Icons.eco_outlined,color: Colors.green,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        width: 350,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 8, bottom: 8),
                          child: Row(
                            children: [
                              Image.asset(
                                "images/icon2.png",
                                height: 40,
                                width: 25,
                              ),
                              MenuListButton(
                                menuText: "Payment",
                                // icon: Icons.payment_sharp,
                                //iconSize: 30,
                                onTap: () {
                                  // Get.snackbar(
                                  //   "Hey i'm a Get SnackBar!", // title
                                  //   "It's unbelievable! I'm using SnackBar without context, without boilerplate, without Scaffold, it is something truly amazing!", // message
                                  //   icon: Icon(Icons.alarm),
                                  //   shouldIconPulse: true,
                                  //   barBlur: 20,
                                  //   isDismissible: true,
                                  //   duration: Duration(seconds: 300),
                                  // );
                                  Get.toNamed("/payment-config");
                                },
                              ),
                              // Icon(Icons.eco_outlined,color: Colors.green,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Container(
                        width: 350,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 8.0, bottom: 8),
                              child: Image.asset(
                                "images/icon3.png",
                                height: 40,
                                width: 25,
                              ),
                            ),
                            MenuListButton(
                              menuText: "Favorites",
                              // icon: Icons.star_border_outlined,
                              // iconSize: 30,
                              onTap: () {
                                Get.to(() => FavoritePage());
                              },
                            ),
                            //Icon(Icons.eco_outlined,color: Colors.green,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Container(
                        width: 350,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 8, bottom: 8),
                              child: Image.asset(
                                "images/icon5.png",
                                height: 40,
                                width: 25,
                              ),
                            ),
                            MenuListButton(
                              menuText: "Charge History",
                              // icon: Icons.access_time_rounded,
                              // iconSize: 30,
                              onTap: () {
                                Get.toNamed("/charge-history");
                              },
                            ),
                            //Icon(Icons.eco_outlined,color: Colors.green,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Container(
                        width: 350,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 8, bottom: 8),
                              child: Image.asset(
                                "images/icon8.png",
                                height: 40,
                                width: 25,
                              ),
                            ),
                            MenuListButton(
                              menuText: "Help & Support",
                              // icon: Icons.help_outline,
                              // iconSize: 30,
                              onTap: () {
                                Get.toNamed("/help-page");
                              },
                            ),
                            //Icon(Icons.eco_outlined,color: Colors.green,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 150, right: 125, top: 16),
                          child: TextButton(
                            child: Text(
                              "Log out",
                              style: TextStyle(
                                  color: Colors.green[800],
                                  fontSize: 20,
                                  //rfontFamily: 'PhithanGreen1'
                              ),
                            ),
                            // icon: Icons.logout,
                            // iconSize: 30,
                            onPressed: () {
                              //Get.toNamed("/help-page");
                              Get.defaultDialog(
                                title: "Do you want to Sign Out ? ",
                                middleText: "",
                                radius: 30,
                                //titleStyle: _theme.boxPrimaryTextBold,
                                backgroundColor: _theme.lightColor,
                                onConfirm: () {
                                  print("confirm");
                                  Get.find<AuthController>().logout();
                                  Get.back();
                                },
                                onCancel: () {},
                              );
                            },
                          ),
                        ),
                        // Icon(Icons.eco_outlined,color: Colors.redAccent,)
                      ],
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Container(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 95,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "POWERED BY",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Image.asset(
                                  "images/Phithan_Green_logo.png",
                                  height: 100,
                                  //width: 100,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 130, right: 150, bottom: 30),
                            child: Text(
                              "( Ver. 0.8 )",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
