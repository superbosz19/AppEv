import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class HelpChargerScreen extends StatefulWidget {
  const HelpChargerScreen({Key key}) : super(key: key);

  @override
  _HelpChargerScreenState createState() => _HelpChargerScreenState();
}

class _HelpChargerScreenState extends State<HelpChargerScreen> {
  @override
  Widget build(BuildContext context) {
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
        title: Text(
          "Charger isn't working",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Material(
          color: Colors.grey[200],
          child: Padding(
              padding: EdgeInsets.fromLTRB(40.0, 20.0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //color: Colors.amber,
                    width: double.infinity,
                    child: Text(
                        "You may br unable to stat charging the vehicle if:",
                        style: TextStyle(
                            //fontFamily: 'PhithanGreen1',
                            color: Colors.black,
                            fontSize: 16)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "-   You do not have a valid payment method\n    connection",
                      style: TextStyle(
                          //fontFamily: 'PhithanGreen1',
                          color: Colors.black,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                        "-   You do not have a valid payment method\n    Please check your wallet confirm",
                        style: TextStyle(
                            //fontFamily: 'PhithanGreen1',
                            color: Colors.black,
                            fontSize: 16)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text("-   The charger is out of service",
                        style: TextStyle(
                            //fontFamily: 'PhithanGreen1',
                            color: Colors.black,
                            fontSize: 16)),
                  ),
                ],
              ))),
    );
  }
}
