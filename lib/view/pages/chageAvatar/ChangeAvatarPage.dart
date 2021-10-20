import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/constants/colors.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/controller/ChangeAvatarController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeAvatarPage extends StatelessWidget {

  CustomTheme _theme;

  ChangeAvatarPage() {
    _theme = CustomTheme.instance;
    ChangeAvatarController ctrl = Get.put( ChangeAvatarController());
  }

  @override
  Widget build(BuildContext context) {
    double _screenW = MediaQuery
        .of(context)
        .size
        .width;
    double _screenH = MediaQuery
        .of(context)
        .size
        .height;
    return GetX<ChangeAvatarController>(
  init: Get.find<ChangeAvatarController>(),
  initState: (_) {},
  builder: (ctrl) {
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
                    //top: kToolbarHeight,
                    left: 10,
                    right: 10),
                child: Stack(

                  children: [
                   // Align(
                   //    alignment: Alignment.topLeft,
                   //    child: InkWell(
                   //      child: Text(
                   //        "< back",
                   //        style: _theme.boxPrimaryTextBold,
                   //      ),
                   //      onTap: () {
                   //        Get.back();
                   //      },
                   //    ),
                   //  ),
                    ctrl.isUploading?Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top:100.0),
                        child: CircularProgressIndicator(
                          color: _theme.primaryColor,
                        ),
                      ),
                    ):SizedBox.shrink(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: kToolbarHeight / 2),
                        Padding(
                          padding: const EdgeInsets.only(left: 50,right: 50),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 18, //_theme.fontSizeBody1,
                                color: _theme.primaryColor,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Please take a photo ",
                                  style: TextStyle(
                                    color: _theme.secondaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30,
                                  ),

                                ),


                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        ChangeAvatar(),


                      ],
                    ),

                    CamerasButton(),

                    1==2?Container(
                      margin: EdgeInsets.only(top: _screenH - (_screenH / 4)),
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: _theme.scanButtonStyle,
                              child: Text(
                                "Save",
                                style: TextStyle(color: _theme.lightColor),
                              ),
                              onPressed: () {
                                print("save avatar");
                              },
                            ),
                          ),
                        ),
                      ),
                    ):SizedBox.shrink(),

                  ],
                ),
              )),
        ),
      ),
    );
  },
);
  }

}


class ChangeAvatar extends StatelessWidget {

  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {


    double screenW = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double imgW = (screenW / 1.2);
    return GetX<ChangeAvatarController>(
      init: Get.find<ChangeAvatarController>(),
      initState: (_) { Get.find<ChangeAvatarController>().imgPath =  Get.find<AuthController>().chargerUser.avatar;},
      builder: (ctrl) {
        return Center(
          child: Container(
            //margin: EdgeInsets.all(20),
            width: imgW,
            height: imgW,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _theme.secondaryColor),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage( ctrl.imgPath  )

                )
            ),
          ),
        );
      },
    );
  }
}


class CamerasButton extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double _sectionHeight = screenHeight / 8;
    double _boxTop = _sectionHeight * 4.5;

    return Center(
      child: Container(
        //padding:  EdgeInsets.only(top: kToolbarHeight, bottom: _sectionHeight),
        margin: EdgeInsets.only(top: _boxTop),
        child: Material(
          type: MaterialType.transparency,
          child: IconButton(
            onPressed: () async {
              await Get.find<ChangeAvatarController>().changeAvatar();
            },
            icon: Icon(Icons.add_a_photo_rounded, color: _theme.darkColor,
              size: 50,),
            color: _theme.lightColor,
          ),
        ),
      ),
    );
  }

}