import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/controller/AuthController.dart';
import 'package:ez_mobile/controller/bindings/AuthBinding.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/view/pages/ChargingPage/ChargeResultPage.dart';
import 'package:ez_mobile/view/pages/ChargingPage/ChargingPage.dart';
import 'package:ez_mobile/view/pages/ConfirmPayment/ConfirmPaymentPage.dart';
import 'package:ez_mobile/view/pages/LinePay/LinePayPage.dart';
import 'package:ez_mobile/view/pages/PaymentConfig/AddPaymentPage.dart';
import 'package:ez_mobile/view/pages/PaymentConfig/PaymentConfigPage.dart';
import 'package:ez_mobile/view/pages/chageAvatar/ChangeAvatarPage.dart';
import 'package:ez_mobile/view/pages/favorite/FavoritePage.dart';
import 'package:ez_mobile/view/pages/help/help_screen.dart';
import 'package:ez_mobile/view/pages/history/ChargeHistoryPage.dart';
import 'package:ez_mobile/view/pages/idcard/IDCardPage.dart';
import 'package:ez_mobile/view/pages/login/LoginPage.dart';
import 'package:ez_mobile/view/pages/main/MainPage.dart';
import 'package:ez_mobile/view/pages/menu/MenuPage.dart';
import 'package:ez_mobile/view/pages/profile/profile.dart';
import 'package:ez_mobile/view/pages/scan/ScanPage.dart';
import 'package:ez_mobile/view/pages/search/SearchPage.dart';
import 'package:ez_mobile/view/pages/selectPayment/SelectPaymentPage.dart';
import 'package:ez_mobile/view/pages/signup/ConfirmSignupPage.dart';
import 'package:ez_mobile/view/pages/signup/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EzEVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Get.put(GMapController());
    return GetMaterialApp(
      //  initialBinding: AuthBinding(),
      title: "EasyCharge",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(headline1: TextStyle(backgroundColor: Colors.red)),
      ),
      home: MainPage(),
      getPages: [
        GetPage(
          name: "/",
          page: () => MainPage(),
        ),
        GetPage(
          name: "/menu",
          page: () => MenuPage(),
        ),
        GetPage(
          name: "/scan-qr",
          page: () => ScanPage(),
        ),
        GetPage(
          name: "/profile-page",
          page: () => ProfilePage(),
        ),
        GetPage(
          name: "/charge-history",
          page: () => ChargeHistoryPage(),
        ),
        GetPage(
          name: "/help-page",
          page: () => HelpScreen(),
        ),
        GetPage(
          name: "/login",
          page: () => LoginPage(),
        ),
        GetPage(
          name: "/signup",
          page: () => SignupPage(),
        ),
        GetPage(
          name: "/confirm-signup",
          page: () => ConfirmSignupPage(),
        ),
        GetPage(
          name: "/change-avatar",
          page: () => ChangeAvatarPage(),
        ),
        GetPage(
          name: "/idcard-page",
          page: () => IDCardPage(),
        ),
        GetPage(
          name: "/select-payment",
          page: () => SelectPaymentPage(),
        ),
        GetPage(
          name: "/charging-page",
          page: () => ChargingPage(),
        ),
        GetPage(
          name: "/charge-result",
          page: () => ChargeResultPage(),
        ),
        GetPage(
          name: "/payment-config",
          page: () => PaymentConfigPage(),
        ),
        GetPage(
          name: "/addpayment-page",
          page: () => AddPaymentPage(),
        ),
        GetPage(
          name: "/confirm-payment",
          page: () => ConfirmPaymentPage(),
        ),
        GetPage(
          name: "/linepay",
          page: () => LinePayPage(),
        ),
        GetPage(
          name: "/search",
          page: () => SearchPage(),
        ),
        GetPage(
          name: "/fav",
          page: () => FavoritePage(),
        ),
      ],
    );
  }
}

class _EzEVAppState {
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = CustomTheme.defaultTheme();
    return MultiProvider(
      providers: [
        Provider<CustomTheme>(
          create: (_) => theme,
        ),
      ],
      child: MaterialApp(
        title: "EasyCharge",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // backgroundColor: Color(0xff034f63),
          //elevatedButtonTheme: theme.btnColorPrimary,
          textTheme:
              TextTheme(headline1: TextStyle(backgroundColor: Colors.red)),
        ),
        //home:MainPage(),
        initialRoute: "/",
        routes: {},
      ),
    );
  }
}
