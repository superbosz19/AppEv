import 'dart:async';

import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GoogleMapSection extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  GMapController gMapCtrl = Get.find<GMapController>();
  Completer<GoogleMapController> _googleMapCtrl = Completer();

  GoogleMapSection(){
    print("gMapCtrl=> ${gMapCtrl}");

  }


  @override
  Widget build(BuildContext context) {
    return GetX<GMapController>(
      init: gMapCtrl,
      initState: (_) {_.controller.getUserLocation();},
      builder: (ctrl) {
        print("Build GMAP");
        if (! ctrl.isLocationLoaded){
         return SizedBox.shrink();
        }else {
          return Container(
            child: GoogleMap(
              initialCameraPosition: ctrl.cameraPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: _onMapCreated,
              onCameraMove: _onCameraMove,
              onCameraIdle: _onCameraMoveEnd,
              markers: ctrl.markers,
              ),
          );


        }
      },
    );
  }





  void _onMapCreated(GoogleMapController controller) {
    _googleMapCtrl.complete(controller);
    gMapCtrl.googleMapController = controller;
  }

  _onCameraMove(CameraPosition position) async {
    // developer.log('camera move ${position.target}', name: 'my.app.category');

    gMapCtrl.updatePosition ( position.target.latitude, position.target.longitude);
    // final GoogleMapController controller = await this.controller1.future;
  }

  void _onCameraMoveEnd() {
    gMapCtrl.moveCameraEnd();


  }
}