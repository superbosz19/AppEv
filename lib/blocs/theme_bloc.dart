import 'package:ez_mobile/custom_icon/phithan_green_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomTheme {
  final ButtonStyle scanButtonStyle;

  final TextStyle btnTextStyle;

  final Icon menuIcon;
  final Color iconDarkColor;

  final Color boxBorderColor;
  final BoxDecoration boxDecoration;
  final BoxDecoration boxBorderBottomOnly;

  final TextStyle boxPrimaryTextBold;
  final TextStyle boxPrimaryText;

  final TextStyle boxSecondaryTextBold;
  final TextStyle boxSecondaryText;

  final TextStyle boxWarningBoldText;
  final TextStyle boxWarningText;

  final Color primaryColor;
  final Color secondaryColor;
  final Color greyColor;
  final Color lightColor;
  final Color darkColor;
  final Color warningColor;
  final Color dangerColor;

  final double fontSizeHeader1;
  final double fontSizeBody1;

  final TextStyle chargingPageTextBold;
  final TextStyle chargingPageText;

  final Map<String, IconData> icons;

  final Color greyColorFont;

  final TextStyle headerStyle;
  final TextStyle textLabelStyle;

  CustomTheme({
    this.headerStyle,
    this.textLabelStyle,
    this.chargingPageTextBold,
    this.chargingPageText,
    this.fontSizeBody1,
    this.fontSizeHeader1,
    this.boxPrimaryTextBold,
    this.boxPrimaryText,
    this.boxSecondaryTextBold,
    this.boxSecondaryText,
    this.boxWarningBoldText,
    this.boxWarningText,
    this.primaryColor,
    this.secondaryColor,
    this.greyColor,
    this.greyColorFont,
    this.lightColor,
    this.darkColor,
    this.boxBorderBottomOnly,
    this.boxBorderColor,
    this.boxDecoration,
    this.menuIcon,
    this.iconDarkColor,
    this.btnTextStyle,
    this.scanButtonStyle,
    this.icons,
    this.warningColor,
    this.dangerColor,
  });

  static final CustomTheme instance = CustomTheme.defaultTheme();

  TextStyle fontLableStyle({double fontSize :25, Color color: Colors.transparent }){
    if (color == Colors.transparent){
      return TextStyle(
        color: primaryColor,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      );

    }else{
      return TextStyle(
        color: color,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      );

    }
  }

  factory CustomTheme.defaultTheme() {
    Color _primaryColor = Color(0xff006140);
    Color _secondaryColor = Color(0xff3eb871);
    Color _greyColor = Color(0xffebeae8);
    Color _lightColor = Colors.white;
    Color _darkColor = Color(0xff000005);
    Color _warningColor = Color(0xfffac710);
    Color _greyColorFont = Color(0xff909090);

    Color _dangerColor = Color(0xffb84a3e);
    TextStyle _btnTextStyle = TextStyle(
      color: _lightColor,
    );

    FontWeight _fBold = FontWeight.bold;
    FontStyle _fStyle = FontStyle.normal;
    double fontSizeN = 14;
    double fontSizeB = 16;

    Map<String, IconData> _icons = {};
    _icons['TYPE1'] = PhithanGreen.phithan_39;
    _icons['TYPE2'] = PhithanGreen.phithan_40;
    _icons['CHAdeMO'] = PhithanGreen.phithan_41;
    _icons['MENU'] = Icons.menu;
    _icons['RIGHT_ARROW'] = Icons.keyboard_arrow_right;
    _icons['DOWN_ARROW'] = Icons.keyboard_arrow_down;
    _icons['LIGHT_ON'] = PhithanGreen.phithan_85;
    _icons['LIGHT_OFF'] = PhithanGreen.phithan_85;
    _icons['CLOSE'] = Icons.close;
    _icons['NAVIGATOR'] = PhithanGreen.phithan_03;
    _icons['CHARGE_STATION'] = PhithanGreen.phithan_62;
    _icons['CAR_CHARGING'] = PhithanGreen.phithan_35;

    return CustomTheme(
      primaryColor: _primaryColor,
      secondaryColor: _secondaryColor,
      greyColor: _greyColor,
      lightColor: _lightColor,
      darkColor: _darkColor,
      dangerColor: _dangerColor,
      scanButtonStyle: ElevatedButton.styleFrom(
        primary: _secondaryColor,
        textStyle: TextStyle(
          color: _secondaryColor,
        ),
      ),
      iconDarkColor: _darkColor,
      menuIcon: Icon(
        _icons['MENU'],
        color: _darkColor,
        size: 30,
      ),
      boxBorderColor: _primaryColor,
      boxDecoration: BoxDecoration(
        border: Border.all(color: _primaryColor),
        color: _lightColor, //background
      ),
      boxBorderBottomOnly: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: _primaryColor),
        ),
        color: _lightColor,
      ),
      boxPrimaryTextBold: TextStyle(
        color: _primaryColor,
        fontSize: fontSizeB,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      boxPrimaryText: TextStyle(
        color: _primaryColor,
        fontSize: fontSizeN,
        fontStyle: _fStyle,
        fontWeight: FontWeight.normal,
      ),
      boxSecondaryTextBold: TextStyle(
        color: _secondaryColor,
        fontSize: fontSizeB,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      boxSecondaryText: TextStyle(
        color: _secondaryColor,
        fontSize: fontSizeN,
        fontStyle: _fStyle,
        fontWeight: FontWeight.normal,
      ),
      boxWarningBoldText: TextStyle(
        color: _warningColor,
        fontSize: fontSizeB,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      boxWarningText: TextStyle(
        color: _warningColor,
        fontSize: fontSizeN,
        fontStyle: _fStyle,
        fontWeight: FontWeight.normal,
      ),
      icons: _icons,
      fontSizeHeader1: fontSizeB,
      fontSizeBody1: fontSizeN,
      warningColor: _warningColor,
      chargingPageText: TextStyle(
        color: _lightColor,
        fontSize: fontSizeN,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
      ),
      chargingPageTextBold: TextStyle(
        color: _lightColor,
        fontSize: fontSizeB,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      greyColorFont: _greyColorFont,
      headerStyle: TextStyle(
        color: _primaryColor,
        fontSize: 30,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      textLabelStyle: TextStyle(
        color: _primaryColor,
        fontSize: 25,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
