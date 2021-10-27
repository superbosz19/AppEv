import 'package:ez_mobile/view/pages/help/help_screen.dart';
import 'package:ez_mobile/view/pages/scan/ScanPage.dart';
import 'package:flutter/material.dart';

class Problem_1 extends StatefulWidget {
  const Problem_1({key}) : super(key: key);

  @override
  _Problem_1State createState() => _Problem_1State();
}

class _Problem_1State extends State<Problem_1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            //color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.only(top: 60,bottom: 30,),
              child: Row(
                children: [
                  IconButton( onPressed: () {
                    Navigator.pop(
                        context, MaterialPageRoute(
                        builder: (context) {
                      return HelpScreen();
                    },));
                  }, icon: Icon(Icons.arrow_back_ios),),
                  //SizedBox(width: 2,),
                  Text("Report a damaged Charger.",
                    style: TextStyle(fontSize: 28,
        fontWeight: FontWeight.bold,
        //color: Colors.grey
      ),),

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50,left: 50),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration( //เส้นใน Container
                border:
                Border.all(color: Colors.black45
                ),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) {
                      return ScanPage();
                    },
                  ),
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                        child: Container(
                            child: Icon((Icons.qr_code_outlined),
                              size: 44,
                              color: Colors.green,
                            ),
                        ),
                    ),
                    SizedBox(width: 15,),
                    Center(child: Text("Scan the charger",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54),)),
                    SizedBox(width: 5,),
                    Icon(Icons.eco,color: Colors.green,),
                  ],
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20,top: 10),
          //   child: Container(
          //     child: Row(
          //       children: [
          //         Icon(Icons.location_on,size: 40,color: Colors.lightGreen,),
          //         SizedBox(width: 10),
          //         Text("Location",style: TextStyle(fontSize: 16),)
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
