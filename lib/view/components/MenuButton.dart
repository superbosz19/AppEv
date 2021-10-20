import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuButton extends StatelessWidget{
  VoidCallback menuClick;
  Alignment alignment;

  MenuButton({this.menuClick: _toMenuPage,this.alignment :Alignment.topLeft });


  static void _toMenuPage(){
        Get.toNamed("/menu");
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight, left: 10.0, right:10.0),
        child: Material(
          type: MaterialType.transparency,
          child: IconButton(
            splashColor: Colors.grey,
            icon: CustomTheme.instance.menuIcon,
            onPressed: menuClick,
          ),
        ),
      ),
    );
  }

}