import 'dart:async';

import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/services/FirebaseService.dart';
import 'package:ez_mobile/view/components/CloseButton.dart';
import 'package:ez_mobile/view/components/EncryptUtil.dart';
import 'package:ez_mobile/view/components/MenuButton.dart';
import 'package:ez_mobile/view/pages/msg/DisplayMsgPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class ScanPage extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  /** screen size **/
  double _screenHeight;
  double _screenWidth;

  double _sectionHeight;

  double _boxTop;

  double _boxWidth;
  double _mainBoxHeight;

  double _spaceW;

  double _paddingLR;
  /** end screen size **/

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    CustomTheme _theme = CustomTheme.instance;
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    _paddingLR = (_screenWidth / 3) / 2;
    _spaceW = _screenWidth / 3;
    _boxWidth = _screenWidth - _spaceW;
    _sectionHeight = _screenHeight / 3;
    _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;
    LightButtonController lbc = Get.put(LightButtonController());

    return Scaffold(
      backgroundColor: _theme.secondaryColor,
      body: Stack(
        //alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: _theme.lightColor,
              borderRadius: 1,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: _boxWidth,
              overlayColor: _theme.secondaryColor,
            ),
          ),
          MenuButton(),
          EzCloseButton(),
          GetX<LightButtonController>(
            init: lbc,
            initState: (_) {},
            builder: (logic) {
              if (lbc.controllerLoaded.value == true &&
                  lbc.qrCtrl.value != null) {
                return LightButton(controller);
              } else {
                return SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }

  StreamSubscription sts1 ;
  void _onQRViewCreated(QRViewController controllerQ) {
    controller = controllerQ;
    //Get.put(LightButtonController(controller.obs));
    if (Get.find<LightButtonController>() != null) {
      Get.find<LightButtonController>().qrCtrl = controller.obs; //.obs;
      Get.find<LightButtonController>().qrCtrl.value = controller;
      Get.find<LightButtonController>().controllerLoaded.value = true;
    }

   sts1 = controller.scannedDataStream.listen((scanData) async {
      // setState(() {
      //   result = scanData;
      //   print("result=> ${result}");
      // });
      print("scandata=> ${scanData.code}");

      /*
                            String decrypted = EncryptUtil.decrypt("gAAAAABg3fzMu9scoJIT6Ua651bjLseEDQcYS3u4Qrfz80SU0mFjhOFJ2o-4LXI9ArRNnfNLhd5bxXWZrAqq7XVRMA_O3B1CUdnd463xqyYVc94RT5UL9Hw=");
                      Get.snackbar("decropt", decrypted, duration:  Duration(minutes: 1));
       */
      if (scanData != null && scanData.code != null && scanData.code != "") {
       // String decrypted = EncryptUtil.decrypt(scanData.code);
        //Get.snackbar("decropt", decrypted, duration:  Duration(minutes: 1));
        //final chargerInfo = decrypted.split("^^");
        // if (chargerInfo != null && chargerInfo.length ==3) {
        //   bool docExist = await FirebaseService.instance.isChargerExist(
        //       chargerInfo[0], chargerInfo[1]);
        //   if (docExist){
        //     //prepare to set data to GMAPController and navigate to main screen
        //     await Get.find<GMapController>().prepareCharger(chargerInfo[0], chargerInfo[1], chargerInfo[2]);
        //     //Get.toNamed("/");
        //   }
        // }else{
        //   Get.snackbar("Error", "Invalid qr code ", duration:  Duration(seconds: 30));
        // }
        final chargerInfo = scanData.code;
        print("scandata => ${chargerInfo}");
        //Get.snackbar("chargerInfo", chargerInfo, duration:  Duration(minutes: 1));
        if (chargerInfo != null && chargerInfo.length > 0){
          final retVal = await FirebaseService.instance.isChargerExist2(chargerInfo);
          controller.pauseCamera();
          print("retVal-> ${retVal["exists"]}");
          if (retVal["exists"] == true){
            //print(Get.find<GMapController>());
            controller.stopCamera();
            print("scanpage=>before cancel subscription sts1");
            sts1.cancel();
            print("scanpage=> after cancel subscription sts1");
            print("scanpage=>before call prepareCharger");
            controller.dispose();
            await Get.find<GMapController>().prepareCharger(retVal["locationID"], chargerInfo, "1");
            //controller.resumeCamera();

          }else{
              await Get.to(DisplayMsgPage(txt: "Invalid Code", msgType: DisplayMsgType.Error,));
              controller.resumeCamera();
          }



        }
      }
    });
  }
}

class LightButton extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  QRViewController controller;
  LightButton(this.controller);
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _sectionHeight = _screenHeight / 3;
    double _boxTop = (_screenHeight - _sectionHeight) + kToolbarHeight;
    double center = _screenWidth / 3;

    return Align(
      alignment: Alignment.topRight,
      child: Container(
        //color: Colors.red,
        width: _sectionHeight,
        height: _sectionHeight,
        //  padding:  EdgeInsets.only(top: kToolbarHeight *5, right:10),
        margin: EdgeInsets.only(
            top: _boxTop,
            right: center,
            left: center,
            bottom: _sectionHeight / 2),
        child: Material(
          type: MaterialType.transparency,
          child: GetX<LightButtonController>(
            init: Get.put(LightButtonController()),
            builder: (logic) {
              if (logic.flashStatus.value) {
                return Ink(
                  decoration: ShapeDecoration(
                    color: _theme.lightColor,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(
                      _theme.icons['LIGHT_OFF'],
                      color: _theme.darkColor,
                      size: _sectionHeight / 4,
                    ),
                    onPressed: () {
                      logic.toggleFlash();
                    },
                  ),
                );
              } else {
                return IconButton(
                  splashColor: _theme.lightColor,
                  icon: Icon(
                    _theme.icons['LIGHT_ON'],
                    color: _theme.darkColor,
                    size: _sectionHeight / 4,
                  ),
                  onPressed: () {
                    logic.toggleFlash();
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class LightButtonController extends GetxController {
  Rx<QRViewController> qrCtrl = null;
  CustomTheme _theme = CustomTheme.instance;
  Rx<Icon> icon;
  RxBool flashStatus = false.obs;
  RxBool controllerLoaded = false.obs;
  @override
  void onInit() async {
    if (qrCtrl == null) {
      return;
    }
    icon = Icon(_theme.icons['LIGHT_OFF']).obs;
    var fStatus = await qrCtrl.value?.getFlashStatus();
    print("LightButtonController=>onInit=> fStatus=${fStatus}");
    if (fStatus == null) {
      flashStatus.value = false;
    } else {
      flashStatus.value = true;
    }
    print("flashStatus.value=> ${flashStatus.value}");

    super.onInit();
  }

  toggleFlash() async {
    print("qrCtrl=> ${qrCtrl}");
    print("enter togger flash");
    await qrCtrl.value?.toggleFlash();
    var fStatus = await qrCtrl.value?.getFlashStatus();
    if (fStatus == null) {
      flashStatus.value = false;
    } else {
      flashStatus.value = fStatus;
    }
  }
}
