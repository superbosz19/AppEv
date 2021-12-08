import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class HelpDamagedscreen extends StatefulWidget {
  const HelpDamagedscreen({Key key}) : super(key: key);

  @override
  _HelpdamagedscreemState createState() => _HelpdamagedscreemState();
}

class _HelpdamagedscreemState extends State<HelpDamagedscreen> {
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
          "Damaged charger",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Material(
          child: Container(
        width: double.infinity,
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 50.0, 0, 0),
          child: Column(
            children: [
              Text(
                "Coming Soon",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
