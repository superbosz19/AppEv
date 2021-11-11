
import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/view/components/MenuButton.dart';
import 'package:ez_mobile/view/pages/main/ScanButton.dart';
import 'package:ez_mobile/view/pages/signup/SignupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';


import 'ChargerLocationInfo.dart';
import 'gMap.dart';

class MainPage extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  // GMapController _gMapController = Get.find(
  //     tag: "gMapCtrl"
  // );

  @override
  Widget build(BuildContext context) {

    // GMapController _gMapController = Get.put(
    //     GMapController(),
    //     tag: "gMapCtrl"
    // );
    GMapController _gMapController = Get.find<GMapController>();

    _gMapController.screenH =   MediaQuery.of(context).size.height;
    _gMapController.screenW =   MediaQuery.of(context).size.width;

    print("_gMapController => ${_gMapController}");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Material(
          type: MaterialType.transparency,
          child: GetX<GMapController>(
            init: Get.find<GMapController>(),
            builder: (gMapCtrl) {
              print("gMapCtrl => ${_gMapController}");
              print("Build Main");
              gMapCtrl.screenH =   MediaQuery.of(context).size.height;
              gMapCtrl.screenW =   MediaQuery.of(context).size.width;
              if (! gMapCtrl.isLocationLoaded){
                return Center(
                  child: Container(
                    width: double.infinity,
                    color: _theme.greyColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("Loading Map",style: _theme.boxSecondaryTextBold,),
                        CircularProgressIndicator(
                          backgroundColor: _theme.greyColor,
                          valueColor: AlwaysStoppedAnimation(_theme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                );
              }else {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/PageLogo.jpg'),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    GoogleMapSection(),
                    MenuButton(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10 ,right: 140,),
                      child: ScanButton(),
                    ),
                    ChargerLocationInfo(),
                    //_buildChargerInfo(context),
                    gMapCtrl.showSearch?SearchWidget():
                    SizedBox.shrink(),
                    MapFloatingButton(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
class SearchWidget extends StatelessWidget{
  Widget btn;
  Widget searchWidget;
  SearchWidget({this.btn, this.searchWidget});


  @override
  Widget build(BuildContext context) {
    CustomTheme _theme = CustomTheme.instance;
    if (searchWidget == null){
      searchWidget = SizedBox.shrink();
    }

    double screenH =   MediaQuery.of(context).size.height;
    double screenW =   MediaQuery.of(context).size.width;
    double _top =  screenH/2;
    double _left = 10;
    double _right = (screenW/6);
    double iconSize = 10;
    double _height = _top/2;//_top/2.25;//2.5;
    double _width = screenW - (screenW/8);

    return Container(
        color:  Colors.transparent,
        height: _height,
        width: _width,
        margin: EdgeInsets.only(top: _top, left: _left, right: _right),
    child: Column(
      children: [

//        EZSearchFormField(label: "", icon: Icons.tune_outlined),
    Stack(
    children: [
      TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          autofocus: false,
          style: TextStyle(
              fontSize: 12.0,
              height: 1.0,
              color: Colors.black
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: _theme.lightColor,
            hoverColor: Colors.red,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: _theme.secondaryColor,
              ),
            ),
          ),
        ),
        suggestionsCallback: (pattern) async {
          //return List.generate(10, (index) => "$index");
          // List<Map<String, String>>  val = List.generate(10, (index) {
          //   return {"name" : "${index}", "price" : "${index} xx ${pattern}" };
          // });
          // return val;
          List<Map<String, String>>  val =[];
          if (pattern != null && pattern.trim().length > 0) {
            var googlePlace = GooglePlace(
                "AIzaSyB-dZldP4jXqVOZYpXbGYFkeYOJHSHpoiw");
            var result = await googlePlace.autocomplete.get(pattern, language: "th");

            print("result = ${result}");

            for (var x in result.predictions) {
              print("${x.placeId}  ${x.toString()}");
              var rs = await googlePlace.details.get(x.placeId);
              DetailsResult details = rs.result;
              // print("details  ${details.name} => ${details.geometry.location
              //     .lat}");

              val.add(
                {
                  "name" : details.name,
                  "lat" : details.geometry.location.lat.toString(),
                  "lng" : details.geometry.location.lng.toString(),
                }
              );
            }
          }
          return val;
          //return await BackendService.getSuggestions(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            //leading: Icon(Icons.shopping_cart),
            title: Text(suggestion['name']),
            //subtitle: Text('\$${suggestion['price']}'),
          );
        },
        onSuggestionSelected: (suggestion) {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => ProductPage(product: suggestion)
          // ));
          print("select=> ${suggestion}");
          Get.find<GMapController>().navigateToPlace(suggestion);
        },
      ),
      Positioned(
        top: 2,
        right: 10,
        child: IconButton(
          icon: Icon(
            Icons.tune_outlined,
            color: _theme.secondaryColor,
            //_obscureText ? Icons.visibility : Icons.visibility_off,
          ),

          onPressed: () {
            Get.toNamed("/search");
          },
        ),
      ),
      ]
    )



      ],
    ),
    );
  }

}

class MapFloatingButton extends StatelessWidget{
  CustomTheme _theme = CustomTheme.instance;



  @override
  Widget build(BuildContext context) {
    double screenH =   MediaQuery.of(context).size.height;
    double screenW =   MediaQuery.of(context).size.width;
    double _top = screenH/2;
    double _left = screenW -(screenW/6);
    double iconSize = 10;
    double _height = _top/2.25; //_top/2.25;//2.5;
    return GetX<GMapController>(
  init: Get.find<GMapController>(),
  initState: (_) {},
  builder: (ctrl) {
    if (ctrl.isLocationSelect){
      return SizedBox.shrink();
    }else
    return Container(
      color:  Colors.transparent,
      height: _height,
      margin: EdgeInsets.only(top: _top, left: _left),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleButton(
            icon: Icon(Icons.search_outlined, color: _theme.darkColor,),
            size: iconSize,
            backgroundColor: _theme.lightColor,
            onTap: (){
              //Get.toNamed("/search-page");
              //Get.toNamed("/search");
              ctrl.showSearch = !ctrl.showSearch;
            },
          ),
          CircleButton(
            icon: Icon(Icons.navigation_outlined, color: _theme.darkColor,),
            size: iconSize,
            backgroundColor: _theme.lightColor,
            onTap: (){  ctrl.toCurrentLocation(); },

          ),
            CircleButton(
              icon: Icon(Icons.star_border_outlined, color: _theme.darkColor,),
              size: iconSize,
              backgroundColor: _theme.lightColor,
              onTap: () async{
                Get.toNamed("/fav");
                // var googlePlace = GooglePlace("AIzaSyB-dZldP4jXqVOZYpXbGYFkeYOJHSHpoiw");
                // var result = await googlePlace.autocomplete.get("1600 Amphitheatre");
                //
                // print("result = ${result}");
                //
                // for (var x  in result.predictions) {
                //   print("${x.placeId}  ${x.toString()}");
                //   var rs = await googlePlace.details.get(x.placeId);
                //   DetailsResult details = rs.result ;
                //   print("details  ${details.name} => ${details.geometry.location.lat}");
                //
                // }
              }
            ),
          // CircleButton(
          //   icon: Icon(Icons.tune_rounded, color: _theme.darkColor,),
          //   size: iconSize,
          //   backgroundColor: _theme.lightColor,
          //   onTap: (){
          //     //Get.toNamed("/search-page");
          //     Get.toNamed("/search");
          //   },
          //
          // ),

          // (ctrl.transaction!=null)?CircleButton(
          //   icon: Icon(_theme.icons['CAR_CHARGING'], color: _theme.secondaryColor, size:30),
          //   size: iconSize,
          //   backgroundColor: _theme.lightColor,
          //   onTap: (){  Get.toNamed("/charging-page"); },
          //
          // ):SizedBox.shrink(),
        ],
      ),
    );
  },
);
  }
}

class CircleButton extends StatelessWidget{
  final icon;
  final backgroundColor;
  final onTap;
  final size;

  const CircleButton({ this.icon, this.backgroundColor, this.onTap, this.size}) ;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(), padding: EdgeInsets.all(size),
        primary: backgroundColor,
      ),
      child: icon,
      onPressed: onTap,
    );
  }
}

