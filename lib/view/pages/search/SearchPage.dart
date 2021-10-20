import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/components/text_label.dart';
import 'package:ez_mobile/controller/gMapController.dart';
import 'package:ez_mobile/models/searchCriteria.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget{
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    _theme = CustomTheme.instance;

    double _screenW = MediaQuery.of(context).size.width;
    double _screenH =  MediaQuery.of(context).size.height;

    double _sectionH = (_screenH ) /16;
    double _paddLR = _screenW*.1;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Material(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: double.infinity,
              //height: double.infinity,
              // margin:  EdgeInsets.only(top: kToolbarHeight),
              child: Padding(
                padding:
                EdgeInsets.only(top: kToolbarHeight, left: _paddLR, right: _paddLR),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        child: Text(
                          "< back",
                          style: _theme.boxPrimaryTextBold,
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:  kToolbarHeight),
                        Text(
                          "Connector Type",
                          style: TextStyle(
                            color: _theme.secondaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ),
                        ),

                        //SizedBox(height: _sectionH),
                        ConnectorFilterList(),

                        // TextLabel(
                        //   label: Text("Location Type", style: _theme.textLabelStyle),
                        //   text: Text("xxxx"),
                        //   position: TextLabelDisplayFormat.TEXTBELOW,
                        // ),

                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }


}

class ConnectorFilterList extends StatelessWidget{
  CustomTheme _theme = CustomTheme.instance;
  @override
  Widget build(BuildContext context) {
    List<String> cnns = ["ALL", "TYPE1", "TYPE2", "CHAdeMO"  ];
    List<IconData> cnnIcons = [
      Icons.select_all, _theme.icons[cnns[1]], _theme.icons[cnns[2]], _theme.icons[cnns[3]]
    ];
    List<Widget> children =[];
    for (var index = 0; index < cnns.length; index++){
      children.add( TextLabel(
        label: Center(child: Text(cnns[index], style: _theme.boxSecondaryText)),
        text : EZPushButton(
          background: _theme.dangerColor,
          child:  Icon(cnnIcons[index], size: 50, color: _theme.secondaryColor,),
        ),
        position: TextLabelDisplayFormat.TEXTBELOW,
      ),
      );


    }


    // return SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(
    //     children: children,
    //   ),
    // );
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var cardSize = height/12;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    GMapController ctrl = Get.find<GMapController>();
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemCount: cnns.length,

        itemBuilder: (BuildContext context, int index) {
          return GetBuilder<GMapController>(
  builder: (ctrl1) {
    return InkWell(
            child: TextLabel(
              label: Center(child: Text(cnns[index], style: TextStyle(color: _theme.secondaryColor),)),
              text : EZPushButton(
                background:ctrl1.criteria.connectors[cnns[index]]?_theme.lightColor:_theme.greyColor,
                child:  Icon(cnnIcons[index], size: cardSize, color: _theme.secondaryColor,),
              ),
              position: TextLabelDisplayFormat.TEXTBELOW,
            ),
            onTap: (){
              print("click");
              SearchCriteria sc = ctrl1.criteria;
              if (index ==0){
                sc.connectors[cnns[0]] = !sc.connectors[cnns[0]];
                for (var i=1; i < cnns.length; i++){
                  sc.connectors[cnns[i]] = sc.connectors[cnns[0]];
                }
              }else {
                  sc.connectors[cnns[index]] = !sc.connectors[cnns[index]];
                  sc.connectors[cnns[0]] = false;
              }
              ctrl1.criteria = sc;
              //ctrl.criteria.connectors[cnns[index]] = !ctrl.criteria.connectors[cnns[index]];
              },
            splashColor: _theme.secondaryColor,
          );
  },
);

        }
    );
  }


}

class EZPushButton extends StatelessWidget{
  CustomTheme _theme = CustomTheme.instance;
  Widget child;
  Color background;
  EZPushButton({this.child:const Text(""), this.background:Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return
        Card(
            color: background,
            child: Center(child: child),
        );


  }

}