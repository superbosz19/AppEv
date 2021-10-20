import 'dart:async';

import 'package:flutter/material.dart';

class EZAppBlocLocalizations {
  static EZAppBlocLocalizations of(BuildContext context) {
    return Localizations.of<EZAppBlocLocalizations>(
      context,
      EZAppBlocLocalizations,
    );
  }

  String get appTitle => "Flutter Todos";
}

class EZAppBlocLocalizationsDelegate
    extends LocalizationsDelegate<EZAppBlocLocalizations> {
  @override
  Future<EZAppBlocLocalizations> load(Locale locale) =>
      Future(() => EZAppBlocLocalizations());

  @override
  bool shouldReload(EZAppBlocLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains("en");
}