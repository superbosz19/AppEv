import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';

class EzCloseButton extends StatelessWidget{

  CustomTheme _theme = CustomTheme.instance;
  final CloseButtonAction closeAction;
  final VoidCallback onTap ;
  EzCloseButton({this.closeAction: CloseButtonAction.backToMain, this.onTap:null });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding:  EdgeInsets.only(top: kToolbarHeight, right:10),
        child: Material(
          type: MaterialType.transparency,
          child: IconButton(
            splashColor: _theme.lightColor,
            icon: Icon(_theme.icons["CLOSE"], color: _theme.darkColor),
            onPressed: _closeNormal,
            // onPressed: onTap==null?_closeNormal:onTap,
          ),
        ),
      ),
    );
  }

  VoidCallback _closeNormal(){
    if (onTap != null){
      onTap();
    }
    if (closeAction == CloseButtonAction.backToMain){
      //Get.toNamed("/");
      Get.back();
    }else{
      Get.back();
    }
  }

}

enum CloseButtonAction{
  backToMain,
  backToPrevious,
}