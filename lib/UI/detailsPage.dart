import 'package:ballfarm/models/shape.dart';
import 'package:ballfarm/uti/databasehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ballfarm/Widets/shapeView.dart';
import 'dart:math';
class DetailsPage extends StatefulWidget {
  final int id;
  DetailsPage(this.id);

  @override
  _DetailsPageState createState() => _DetailsPageState(id);
}

class _DetailsPageState extends State<DetailsPage> {
  Shape shape = Shape("","");
  final int id;
  _DetailsPageState(this.id);

  var db = DatabaseHelper();
  void getShape() async{
    Shape _shape = await db.getShape(id);
    setState(() {
      shape = _shape;
    });
  }
  @override
  void initState() {
    getShape();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double year = ((((shape.shCode.length/2) * 0.6) * 100).ceil() / 100);
    return Scaffold(
      backgroundColor:  Color(0xff121a26),
      body: SingleChildScrollView(
        child: Container(
          child:SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height:280,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Color(0xff0d1520)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: ShapeView(shape.shCode,Size(170,170)),
                        width: 175,
                        height: 175,
                        decoration: BoxDecoration(
                          color: Color(0xff0c6291),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25)
                          )
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10),),
                      Text("${shape.name}",
                      style: TextStyle(
                        color: Color(0xfff8f9fa),
                        fontSize: 35
                      ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          children: <Widget>[
                            Text("Code : ",
                            style: TextStyle(
                                color: Color(0xfff8f9fa),
                              fontSize: 27
                            ),
                            ),
                            Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    
                                  },
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(shape.shCode,
                                        style: TextStyle(   color: Color(0xffcecece), fontSize: 25),),
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          children: <Widget>[
                            Text("Duration : ",
                              style: TextStyle(
                                  color: Color(0xfff8f9fa),
                                  fontSize: 27
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                 scrollDirection: Axis.horizontal,
                                 child: Text("${((year - year.floor())*40).ceil() == 0 ? year.toInt() : year} million years", // 190.0 => 190 , 190.2343 => 190.2
                                 style: TextStyle(color: Color(0xffcecece),fontSize: 25),),
                                  ),
                                )
                          ],
                        ),
                      )

                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff121a26)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
