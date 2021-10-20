import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/screen_args.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/models/charger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ChargerLocationPage extends StatefulWidget {
  ChargerLocation chargerLocation;
  final Function closeLocInfoFunc;
  final Function selectConnector;

  ChargerLocationPage({this.chargerLocation, this.closeLocInfoFunc, this.selectConnector});

  @override
  State<StatefulWidget> createState() => _ChargerLocationPageState();
}

class _ChargerLocationPageState extends State<ChargerLocationPage> {
  double _screenHeight;
  double _screenWidth;

  double _sectionHeight;

  double _boxTop;

  double _boxWidth;
  double _mainBoxHeight;

  int _spaceW;

  double _paddingLR;

  CustomTheme _theme;

  ChargerLocation _selChargerLoc;
  Charger _selCharger;
  Connector _selConnector;


  @override
  void initState() {
    super.initState();
    _selChargerLoc = widget.chargerLocation;
    _theme = Provider.of<CustomTheme>(context, listen: false);


  }

  @override
  Widget build(BuildContext context) {
    _spaceW = 50;
    _paddingLR = _spaceW / 2;
    _screenHeight = MediaQuery.of(context).size.height;
    _screenHeight -= _paddingLR;

    _screenWidth = MediaQuery.of(context).size.width;
    _boxWidth = _screenWidth - _spaceW;
    _boxTop = (_screenHeight - _paddingLR) / 3;
    _mainBoxHeight = _boxTop * 2; // 2 of 3 of screen
    _sectionHeight = _mainBoxHeight / 3;



    return _buildMainBody(context);
  }

  Widget _buildMainBody(BuildContext context) {
    return Container(
      //padding is padding for inside box
      // padding:  EdgeInsets.only(left: _paddingLR, right: _paddingLR,),

      margin:
          EdgeInsets.only(top: _boxTop, left: _paddingLR, bottom: _paddingLR),
      width: _boxWidth,
      decoration: _theme.boxDecoration,
      child: Stack(children: [
        Column(
          children: [
            _buildImageSection(context),
            _buildLocationInfo(context),
            _buildChargerLists(context),
            _buildChargerInfo(context),
          ],
        ),
        Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              child:
                  Icon(_theme.icons["DOWN_ARROW"], color: _theme.primaryColor, size: 30,),
              onTap: widget.closeLocInfoFunc,
            ),
        ),
      ]),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    if (_selCharger != null){
      return SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      height: _sectionHeight,
      width: _screenWidth,
      decoration: _theme.boxBorderBottomOnly,
      child: Image.network(
        "https://f.ptcdn.info/285/006/000/1371443624-3659210151-o.jpg",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLocationInfo(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        height: _sectionHeight,
        width: _screenWidth,
        decoration: _theme.boxBorderBottomOnly,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  _selChargerLoc.locationName,
                  style: _theme.boxPrimaryTextBold,
                ),
                SizedBox(height: 5),
                Text(
                  _selChargerLoc.locationAddress,
                  style: _theme.boxPrimaryText,
                ),
                SizedBox(height: 5),
                TextLabel(
                  label: Text(
                    "Open",
                    style: _theme.boxPrimaryTextBold,
                  ),
                  text: Text(
                    _selChargerLoc.openPeriodDisplay,
                    style: _theme.boxPrimaryText,
                  ),
                ),
                SizedBox(height: 5),
                TextLabel(
                  label: Text(
                    "Type",
                    style: _theme.boxPrimaryTextBold,
                  ),
                  text: Text(
                    _selChargerLoc.locationTypeDisplay,
                    style: _theme.boxPrimaryText,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(_theme.icons['NAVIGATOR'],
                            color: _theme.primaryColor),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.phone_outlined, color: _theme.primaryColor),
                      ],
                    ),
                    Icon(Icons.star_border_outlined,
                        color: _theme.primaryColor),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _chargerMiniInfo(Charger charger_, Color color, double rowHeight) {
    List<Widget> connectors_ = [];
    for (var cnn in charger_.connectors) {
      connectors_.add(
        Icon(
          _theme.icons[cnn.connectorType],
          color: cnn.status == "AVAILABLE"
              ? _theme.secondaryColor
              : _theme.darkColor,
          size: rowHeight * 0.7,
        ),
      );
      connectors_.add(SizedBox(
        width: 10,
      ));
    }
    connectors_.add(
      Icon(
        _theme.icons['RIGHT_ARROW'],
        color: _theme.primaryColor,
        size: rowHeight * 0.7,
      ),
    );
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                charger_.chargerName,
                style: _theme.boxSecondaryTextBold,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: connectors_,
              ),
            ],
          ),
          onTap: () {
            _showChargerDetail(charger_);
          },
          splashColor: _theme.secondaryColor,
        ),
      ),
      color: color,
      height: rowHeight,
    );
  }

  Widget _buildChargerLists(BuildContext context) {
    if (_selCharger != null){
      return SizedBox.shrink();
    }

    List<Widget> children = [];
    children.add(
      Text(
        "Chargers",
        style: _theme.boxPrimaryTextBold,
      ),
    );
    var rowGap = 10;
    var rowHeight = (_sectionHeight / 3) - rowGap;
    var idx = 0;
    for (var charger_ in _selChargerLoc.chargers) {
      children.add(_chargerMiniInfo(
        charger_,
        (idx % 2 == 1) ? _theme.lightColor : _theme.greyColor,
        rowHeight,
      ));
      idx++;
    }

    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      height: _sectionHeight,
      width: _screenWidth,
      //decoration: _theme.boxBorderBottomOnly,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildChargerInfo(BuildContext context){
    if (_selCharger == null){
      return SizedBox.shrink();
    }else{

      List<Widget> children = [];
      children.add(
        InkWell(
          child: Text(
            "< back",
            style: _theme.boxPrimaryTextBold,
          ),
          onTap: (){
            setState(() {
              _selCharger = null;
            });
          },
        ),
      );

      children.add(
        Center(
          child: Text(
            _selChargerLoc.locationName,
            style: _theme.boxPrimaryTextBold,
          ),

        ),
      );

      children.add(
        SizedBox(height :10),
      );

      for (var cnn in _selCharger.connectors){
        Color color;
        if (cnn.status == "AVAILABLE"){
          color = _theme.secondaryColor;
        }else if (cnn.status == "RESERVED"){
          color = _theme.warningColor;
        }else{
          color = _theme.greyColor;
        }
        var cnn_block = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(_theme.icons[cnn.connectorType], size:  30, color: color),
            RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: _theme.fontSizeBody1,
                    color: color,
                  ),
                  children: <TextSpan>[
                    new TextSpan(text : cnn.connectorName, style: TextStyle(fontSize: _theme.fontSizeHeader1, fontWeight: FontWeight.bold )),
                    new TextSpan(text : "   ${cnn.status.substring(0,1)}${cnn.status.substring(0).toLowerCase()}", style: TextStyle( fontStyle:  FontStyle.italic)),
                    new  TextSpan(text : "\n${cnn.chargePrice[0].timeRateDisplay}\n ${cnn.chargePrice[0].actualRateDisplay}" ),
                  ],
                )
            ),
            Icon(_theme.icons['CHARGE_STATION'], size: 30, color: color),
            // Material(
            //
            //   child: InkWell(
            //       child: Icon(_theme.icons['CHARGE_STATION'], size: 30, color: color),
            //     onTap: (){
            //         _selConnector = cnn;
            //         _startChargePage();},
            //     splashColor:color,
            //
            //   ),
            //   color: _theme.lightColor,
            // ),
          ],
        );


          children.add(Padding(
            padding: const EdgeInsets.only(left:15.0 , right:15, top:15),
            child: Material(
              child: InkWell(
                  child: cnn_block,
                onTap: cnn.status=="AVAILABLE"?(){
                  _selConnector = cnn;
                  _startChargePage();
                  }:(){},
                splashColor:color,
              ),
              color: _theme.lightColor,
            ),
          ));

          children.add(SizedBox(height:10));

      }



      return Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        height: _sectionHeight + _sectionHeight,
        width: _screenWidth,
        //decoration: _theme.boxBorderBottomOnly,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      );


    }


  }

  void _showChargerDetail(Charger charger_) {
    setState(() {
      _selCharger = charger_;
    });
  }

  void _startChargePage() {
    Navigator.pushNamed(
      context,
      "/scanqr",
      arguments: GenericParams(
          params: {
            'charger' : _selCharger,
            'connector' : _selConnector,
          }
      ),
    );

  }
}


