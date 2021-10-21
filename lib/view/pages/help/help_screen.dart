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
            SizedBox(height: 100),
            Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child:
                Text("Help",
                  style: TextStyle(fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )
            ),
            SizedBox(height: 70),
            Column(
              children: [
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
                    padding: EdgeInsets.only(left: 40),
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
                        Spacer(),
                        Icon(Icons.arrow_right_rounded, size: 50,
                          color: Colors.teal,),
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
                    padding: EdgeInsets.only(left: 40),
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
                    padding: EdgeInsets.only(left: 40),
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
                    padding: EdgeInsets.only(left: 40),
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
                        Text("General problem",
                          style: TextStyle(
                              fontSize: 20, color: Color(0xFF084418)),
                        ),
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
                    padding: EdgeInsets.only(left: 40),
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
                        Text("FAQs",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFF084418))),
                        Spacer(),
                        Icon(Icons.arrow_right_rounded, size: 50,
                          color: Colors.teal,)
                      ],
                    )
                    ,
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 100,
                  //right: 80
                ),
                child: Row(
                  children: [
                    Container(
                      child: Text("more help please ",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    TextButton(onPressed: () {},

                        child: Text("Contact me"))
                  ],
                ),
              ),
            )
          ]
      ),
    );
  }
}
