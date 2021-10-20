import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/view/components/CloseButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DisplayMsgType{
  Error,
  Warning,
  Info,
}

class DisplayMsgPage extends StatelessWidget{

  final Widget msg;
  final DisplayMsgType msgType;
  final String txt;

  const DisplayMsgPage({Key key, this.msg, this.msgType:DisplayMsgType.Info, this.txt:"", }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    CustomTheme _theme = CustomTheme.instance;
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _paddingLR = (_screenWidth / 3) / 4;
    double _spaceW = _screenWidth / 3;
    double _boxWidth = _screenWidth - _spaceW;
    double _sectionHeight = _screenHeight / 3;
    double _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;

    var btns = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: _theme.primaryColor,
              textStyle: TextStyle(
                color: _theme.secondaryColor,
              ),
            ),
            child: Text(
              "Dismiss",
              style: TextStyle(
                  color: _theme.lightColor,
                  fontSize: _sectionHeight / 12),
            ),
            onPressed: () {
              Get.back();
            }
        ),
      ],
    );

    Widget icon = SizedBox(height: _sectionHeight/2);
    if (msgType == DisplayMsgType.Error) {
      icon = Icon(Icons.error_outline_outlined, size: _sectionHeight / 2, color: _theme.dangerColor);
    }

    Widget txtMsg = SizedBox.shrink();
    if (txt != null && txt.isNotEmpty){
      txtMsg = Text(txt, style: TextStyle(
        color: _theme.lightColor,
        fontWeight: FontWeight.normal,
        fontSize: _sectionHeight / 12,
      ),);
    }

    return Material(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: _theme.secondaryColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  EzCloseButton(),
                  SizedBox(
                    height: _sectionHeight / 2,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: kToolbarHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: kToolbarHeight ,
                        ),

                        Center(
                          child: icon
                        ),
                        SizedBox(
                          height: _sectionHeight/6,
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, left: _paddingLR, right: _paddingLR),
                            child: msg
                          ),
                        ),
                        Center(
                          child: Padding(
                              padding: EdgeInsets.only(top: 10, left: _paddingLR, right: _paddingLR),
                              child: txtMsg
                          ),
                        ),
                        SizedBox(height: 10,),
                      //  msg,

                        SizedBox(
                          height: _sectionHeight / 3,
                        ),
                        btns,

                      ],
                    ),
                  )
                ],
              ),
        ),
        ),
    );




  }

}