import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuButton extends StatefulWidget {
  VoidCallback menuClick;
  Alignment alignment;

  MenuButton({this.menuClick: _toMenuPage, this.alignment: Alignment.topLeft});

  static void _toMenuPage() {
    Get.toNamed("/menu");
  }

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: Padding(
        padding:
            const EdgeInsets.only(top: kToolbarHeight, left: 20.0, right: 30.0),
        child: Material(
          type: MaterialType.transparency,
          child: IconButton(
            splashColor: Colors.grey,
            icon: Icon(
              Icons.menu_rounded,
              size: 36,
              //color: Colors.pink,
            ),
            //CustomTheme.instance.menuIcon,
            onPressed: widget.menuClick,
          ),
        ),
      ),
    );
  }
}
