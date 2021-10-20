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
      resizeToAvoidBottomInset: true,
      body: Material(
        child: Stack(
          children: [
            MenuList(),
            MenuButton(
              alignment: Alignment.topLeft,
              menuClick: () => Get.back(),//Get.toNamed("/"),
            ),
          ],
        ),
      ),
    );
  }

}

class MenuListButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final double spaceW;
  final double fontSize;
  final String menuText;
  final String Color;
  CustomTheme _theme;

  VoidCallback onTap;

  MenuListButton(
      {Key key,
        this.icon,
        this.iconSize,
        this.spaceW: 20,
        this.fontSize: 20 /*25*/,
        this.onTap,
        this.menuText,
        this.Color,
      }) {
    _theme = CustomTheme.instance;
  }

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
            Icon(icon, size: iconSize,),
            SizedBox(
              width: spaceW,
            ),
            Text(
              menuText,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: _theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}


class MenuList extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  final double _spaceH = 24;//30;

  @override
  Widget build(BuildContext context) {
    //AuthController _authCtrl = Get.put( AuthController()); // Get.find<AuthController>();


    return GetX<AuthController>(
      init: Get.find<AuthController>(),
      initState: (_) {},
      builder: (ctrl) {
        if (ctrl.user == null || ctrl.user.email == null){
          return Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight * 2, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuListButton(
                  menuText: "Log In",
                  icon: Icons.login,
                  iconSize: 30,
                  onTap: () { Get.toNamed("/login");},
                ),
                SizedBox(height: 5,),
                // MenuListButton(
                //   menuText: "Sing Up",
                //   icon: Icons.app_registration,
                //   iconSize: 30,
                //   onTap: () { Get.toNamed("/signup");},
                // ),
                SizedBox(height: 5,),
                MenuListButton(
                  menuText: "Help",
                  icon: Icons.help_outline,
                  iconSize: 30,
                  onTap: () { Get.toNamed("/help-page");},
                ),
              ],
            ),
          );
        }else{
          return Padding( //this.icon, this.iconSize, this.spaceW: 20, this.fontSize: 25, this.onTap
            padding: const EdgeInsets.only(top: kToolbarHeight * 2, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.bolt_outlined, size: 40,color: Colors.orange,),
                        Text(
                          "Hi ! ${ctrl.chargerUser.firstName}",
                          style: TextStyle(
                            color: _theme.darkColor,
                            decoration: TextDecoration.none,
                            fontSize:  _spaceH,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: _spaceH),
                MenuListButton(
                  menuText: "Profile",
                  icon: Icons.person_rounded,
                  iconSize: 30,
                  onTap: (){  Get.toNamed("/profile-page"); },
                ),
                MenuListButton(
                  menuText: "Payment",
                    icon: Icons.payment_sharp,
                    iconSize: 30,
                    onTap: (){
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
                MenuListButton(
                  menuText: "Favorites",
                  icon: Icons.star_border_outlined,
                  iconSize: 30,
                  onTap: () { Get.to(() => FavoritePage());},
                ),
                MenuListButton(
                  menuText: "Charge History",
                  icon: Icons.access_time_rounded,
                  iconSize: 30,
                  onTap: () { Get.toNamed("/charge-history");},
                ),
                MenuListButton(
                  menuText: "Help",
                  icon: Icons.help_outline,
                  iconSize: 30,
                  onTap: () { Get.toNamed("/help-page");},
                ),
                MenuListButton(
                  menuText: "Sign Out",
                  icon: Icons.logout,
                  iconSize: 30,
                  onTap: () {
                    //Get.toNamed("/help-page");
                    Get.defaultDialog(
                      title: "Do you want to Sign Out ? ",
                      middleText: "",
                      radius: 1,
                      titleStyle: _theme.boxPrimaryTextBold,
                      backgroundColor: _theme.lightColor,
                      onConfirm: (){
                        print("confirm");
                        Get.find<AuthController>().logout();
                        Get.back();
                      },
                      onCancel: (){},
                    );
                    },
                ),
                SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("(ver. 0.8)"),
                  ],
                ),
              ],
            ),
          );
        }

      },
    );



  }


}