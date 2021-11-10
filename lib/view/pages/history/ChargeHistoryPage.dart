import 'package:dotted_line/dotted_line.dart';
import 'package:ez_mobile/blocs/theme_bloc.dart';
import 'package:ez_mobile/controller/ChargeHistoryController.dart';
import 'package:ez_mobile/models/charger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChargeHistoryPage extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 2.5),
            child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.menu_rounded,
                  color: Colors.black,
                  size: 36,
                )),
          )
          // MenuButton(
          //   alignment: Alignment.topLeft,
          //   menuClick: () => Get.back(),
          // )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 3.0),
          child: Image.asset(
            "images/Easy-Charge.png",
            width: 160,
            height: 160,
          ),
        ),
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: GetX<ChargeHistoryController>(
              init: Get.put(ChargeHistoryController()),
              initState: (_) {},
              builder: (ctrl) {
                return Stack(
                    children: [
                       //rEZBackButton(),
                      (ctrl.loadDone) ? Padding(
                        padding: EdgeInsets.only(
                           // top: kToolbarHeight
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //SizedBox(height: 30),
                            Text(
                              "Charge History",
                              style: TextStyle(
                                  color: _theme.secondaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30),
                            ),
                            SizedBox(height: 30),
                            YearListSection(),
                            MonthListSection(),
                            HistList(),
                            // _buildYearList(context),
                            // _buildMonthList(context),
                            // _buildHistList(context)
                          ],
                        ),
                      ) : Padding(
                          padding:  EdgeInsets.only(top:kToolbarHeight*5),
                          child:  Center(child: CircularProgressIndicator())
                      ),
                    ]
                );
              },
            ),
          ),

        ),

      ),
    );
  }


}

class YearListSection extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    ButtonStyle selStyle = ElevatedButton.styleFrom(
        primary: _theme.secondaryColor,
        textStyle: TextStyle(
          color: _theme.lightColor,
        ));

    ButtonStyle notSelStyle = ElevatedButton.styleFrom(
        primary: _theme.greyColor,
        textStyle: TextStyle(
          color: _theme.darkColor,
        ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GetX<ChargeHistoryController>(
        init: Get.find<ChargeHistoryController>(),
        initState: (_) {},
        builder: (ctrl) {
          List<String> _years = ctrl.yearList;
          List<Widget> yearLists = [];
          for (var idx = 0; idx < _years.length; idx++) {
            yearLists.add(
              ElevatedButton(
                style: _years[idx] == ctrl.selYear ? selStyle : notSelStyle,
                child: Text(
                  _years[idx].toString(),
                  style: TextStyle(
                    color: _years[idx] == ctrl.selYear
                        ? _theme.lightColor
                        : _theme
                        .darkColor,
                  ),
                ),
                onPressed: () {},
              ),
            );
            yearLists.add(SizedBox(width: 10));
          }

          return Row(
            children: yearLists,
          );
        },
      ),
    );
  }
}

class MonthListSection extends StatelessWidget {
  static final List<String> months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    ButtonStyle selStyle = ElevatedButton.styleFrom(
        primary: _theme.secondaryColor,
        textStyle: TextStyle(
          color: _theme.lightColor,
        ));

    ButtonStyle notSelStyle = ElevatedButton.styleFrom(
        primary: _theme.greyColor,
        textStyle: TextStyle(
          color: _theme.darkColor,
        ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GetX<ChargeHistoryController>(
        init: Get.find<ChargeHistoryController>(),
        builder: (ctrl) {
          List<String> _months = ctrl.monthList;
          List<Widget> monthLists = [];
          print("_months=> ${_months}");
          for (var idx = 0; idx < _months.length; idx++) {
            monthLists.add(
              ElevatedButton(
                style: _months[idx] == ctrl.selMonth ? selStyle : notSelStyle,
                child: Text(
                  MonthListSection.months[ int.parse(_months[idx]) - 1],
                  style: TextStyle(
                    color: _months[idx] == ctrl.selMonth
                        ? _theme.lightColor
                        : _theme
                        .darkColor,
                  ),
                ),
                onPressed: () {
                  ctrl.selMonth = _months[idx];
                },
              ),
            );
            monthLists.add(SizedBox(width: 10));
          }
          return Row(
            children: monthLists,
          );
        },
      ),
    );
  }
}

class HistList extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double componentsHeight = 0.0;
    return GetX<ChargeHistoryController>(
      init: Get.find<ChargeHistoryController>(),
      builder: (ctrl) {
        List<Widget> datas = [];
        Map<String, Map<String, ChargeHistory>> dataList = ctrl.datasList;
        List<String> dayKeys = ctrl.dayKey;
        for (var idx = 0; idx < dayKeys.length; idx++) {
          var dayDatas = dataList[dayKeys[idx]];
          datas.add(
            SizedBox(height: 10),
          );
          datas.add(
            Text(dayDatas[dayDatas.keys.first].histDateDisplay,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: _theme.primaryColor,
                fontSize: 18,

              ),
            ),
          );

          List<String> dataKeys = dayDatas.keys.toList()..sort();
          for (var idx2 =0; idx2 < dataKeys.length; idx2++){
            var data = dayDatas[dataKeys[idx2] ];
            datas.add(
              SizedBox(height:10),
            );
            datas.add(
              Text(data.historyInfo,
                style:  TextStyle(
                  fontWeight:  FontWeight.normal,
                  color : _theme.greyColorFont,
                  fontSize: 16,

                ),
              ),
            );
            datas.add(
              SizedBox(height:5),
            );
            datas.add(LineSeperator());

          }

        }
        return Container(
          height: screenHeight,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: datas,
            ),
          ),
        );
      },
    );
  }

}

class LineSeperator extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;
  double dotLength; //0 is solid line

  LineSeperator({this.dotLength:0.0});
  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 4.0,
      dashColor: _theme.greyColorFont,
      dashRadius: 0.0,
      dashGapLength: dotLength,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }
}

class EZBackButton extends StatelessWidget {
  CustomTheme _theme = CustomTheme.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 40
              //top: kToolbarHeight
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              child: Icon(Icons.arrow_back_ios, color: Colors.redAccent,),
              // Text(
              //   "< back",
              //   style: _theme.boxPrimaryTextBold,
             // ),
              onTap: () {
                Get.back();
              },
            ),
          ),
        ),
      ],
    );
  }

}