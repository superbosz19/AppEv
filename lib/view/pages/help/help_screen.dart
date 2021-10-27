import 'package:ez_mobile/view/pages/help/problem1.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text(widget.title),
      ),*/
      body: Column(
          children: [
            //SizedBox(height: 80),
            Row(
              children: [
                Container(
                  //color: Colors.redAccent,
                    padding: EdgeInsets.only(top: 80,bottom: 50,left: 30),
                    //margin: EdgeInsets.symmetric(horizontal: 40.0),
                    alignment: Alignment.topLeft,
                    child:
                    Text("Support",
                      style: TextStyle(fontSize: 50,
                          fontWeight: FontWeight.bold,
                          //color: Colors.gre
                        ),
                    )
                ),
                Icon(Icons.eco,color: Colors.green,),
              ],
            ),
            //SizedBox(height: 50),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) {
                        return Problem_1();
                      },
                    ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 30),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration( //เส้นใน Container
                      border:
                      Border.all(color: Colors.black12),
                    ),
                    //color: Colors.teal,
                    child:
                    Row(
                      children: [
                        Text("Issue with a recent charger",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF084418)
                          ),
                        ),
                        SizedBox(width: 5,),
                        Icon(Icons.eco_outlined ,color: Colors.green,),
                        Spacer(),
                        Icon(Icons.arrow_right_rounded, size: 50,
                          color: Colors.teal,),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) {
                        return Scaffold();
                      },
                    ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 30),
                    height: 70,
                    width: double.infinity,
                    /*decoration: BoxDecoration( //เส้นใน Container
                        border:
                        Border.all(color: Colors.black),
                      ),*/
                    //color: Colors.white,
                    child:
                    Row(
                      children: [
                        Text("Charger won't start",
                            style: TextStyle(fontSize: 20,
                                color: Color(0xFF084418))),
                        SizedBox(width: 5,),
                        Icon(Icons.eco_outlined ,color: Colors.green,),
                        Spacer(),
                        Icon(Icons.arrow_right_rounded, size: 50,
                          color: Colors.teal,)
                      ],
                    )
                    ,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) {
                        return Scaffold();
                      },
                    ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 30),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration( //เส้นใน Container
                      border:
                      Border.all(color: Colors.black12),
                    ),
                    //color: Colors.teal,
                    child:
                    Row(
                      children: [
                        Text("Damaged charger",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFF084418))),
                        SizedBox(width: 5,),
                        Icon(Icons.eco_outlined ,color: Colors.green,),
                        Spacer(),
                        Icon(Icons.arrow_right_rounded, size: 50,
                          color: Colors.teal,)
                      ],
                    )
                    ,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) {
                        return Scaffold();
                      },
                    ),
                    );
                  },
                  // child: Container(
                  //   padding: EdgeInsets.only(left: 30),
                  //   height: 70,
                  //   width: double.infinity,
                    /*decoration: BoxDecoration( //เส้นใน Container
                        border:
                        Border.all(color: Colors.black),
                      ),*/
                    //color: Colors.white,
                //     child:
                //     Row(
                //       children: [
                //         Text("General problem",
                //           style: TextStyle(
                //               fontSize: 20, color: Color(0xFF084418)),
                //         ),
                //         SizedBox(width: 5,),
                //         Icon(Icons.eco_outlined ,color: Colors.green,),
                //         Spacer(),
                //         Icon(Icons.arrow_right_rounded, size: 50,
                //           color: Colors.teal,)
                //       ],
                //     )
                //     ,
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context, MaterialPageRoute(
                //       builder: (context) {
                //         return Scaffold();
                //       },
                //     ),
                //     );
                //   },
                  child: Container(
                    padding: EdgeInsets.only(left: 30),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(
                            color: Colors.black12
                        ),)
                      //เส้นใน Container
                    //  border: Border.all(color: Colors.black12),
                    ),
                    //color: Colors.teal,
                    child:
                    Row(
                      children: [
                        Text("FAQs",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFF084418))),
                        SizedBox(width: 5,),
                        Icon(Icons.eco_outlined ,color: Colors.green,),
                        Spacer(),
                        Icon(Icons.arrow_right_rounded, size: 50,
                          color: Colors.teal,)
                      ],
                    )
                    ,
                  ),
                ),
              //],
            //),
            SizedBox(height: 100),
            Container(
              //color: Colors.redAccent,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 70,
                    //right: 50
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.contact_support_outlined),
                      Container(
                        child: Text(" More help please |",
                          style: TextStyle(fontSize: 16),
                        ),

                      ),
                      TextButton(onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) {
                            return Scaffold();
                          },
                        ),
                        );
                      },

                          child: Text("Contact me.",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16),),),
                      Text("|",style: TextStyle(fontSize: 16),),
                      SizedBox(width: 2,),
                      Icon(Icons.eco,color: Colors.green,),
                    ],
                  ),
                ),
              ),
            )
          ]
      ),],)
    );
  }
}
