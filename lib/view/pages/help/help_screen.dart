import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20.0, top: 2.5),
        //     child: IconButton(
        //         onPressed: () => Get.back(),
        //         icon: Icon(
        //           Icons.menu_rounded,
        //           color: Colors.black,
        //           size: 36,
        //         )),
        //   )
        //   // MenuButton(
        //   //   alignment: Alignment.topLeft,
        //   //   menuClick: () => Get.back(),
        //   // )
        // ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 3.0),
          child: Image.asset(
            "images/Easy-Charge.png",
            width: 160,
            height: 160,
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(
                "images/BannerHelp.png",
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  //color: Colors.white,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
                        child: Image.asset(
                          "images/icon5.png",
                          height: 40,
                          width: 30,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Issue with a recent charger",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                               // fontFamily: 'PhithanGreen1'
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  //color: Colors.white,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
                        child: Image.asset(
                          "images/icon7.png",
                          height: 40,
                          width: 30,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Charger isn't working            ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                //fontFamily: 'PhithanGreen1'
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  //color: Colors.white,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
                        child: Image.asset(
                          "images/icon9.png",
                          height: 40,
                          width: 25,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Damaged charger           ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                //fontFamily: 'PhithanGreen1'
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  //color: Colors.white,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
                        child: Image.asset(
                          "images/icon6.png",
                          height: 40,
                          width: 30,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "FAQs                              ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                //fontFamily: 'PhithanGreen1'
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 120,),
                      child: Row(
                        children: [
                          Text("POWERED BY",style: TextStyle(fontSize: 12),),
                          Image.asset(
                            "images/Phithan_Green_logo.png",
                            height: 100,
                            //width: 100,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 140, right: 150, bottom: 30),
                      child: Text(
                        "( Ver. 0.8 )",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
