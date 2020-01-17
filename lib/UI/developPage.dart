import 'package:ballfarm/Widets/shapeView.dart';
import 'package:ballfarm/models/shape.dart';
import 'package:ballfarm/uti/databasehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ballfarm/main.dart';
import 'dart:math';
bool changeHapedned;
class DevelopPage extends StatefulWidget {
  final int id;
  DevelopPage(this.id);
  @override
  _DevelopPageState createState() => _DevelopPageState(id);
}
whereLetter(String letter){
  int n ;
  for(int i = 0; i < uperLetter.length ; i++){ // know the arrangement of letter in list
    if(uperLetter[i].toLowerCase() == letter.toLowerCase()){
      n = i ;
    }
  }
  return n;
}
String getLetter(int number){
  return uperLetter[number];
}
class _DevelopPageState extends State<DevelopPage> {
  final int id;
  _DevelopPageState(this.id);
  var db = DatabaseHelper();
  Shape shape;
  void getShape() async{
    Shape _shape = await db.getShape(id);
    if(_shape.shCode == ""){
      int uper = Random().nextInt(uperLetter.length);
      int lawer = Random().nextInt(uperLetter.length);
      String uperS = getLetter(uper);
      String lawerS = getLetter(lawer);
      _shape.shCode = uperS+lawerS;
    }
    setState(() {
      shape = _shape;
      print("shape ${shape.shCode}");
      generator();
    });
  }
  List<String> shapesToChose = ["",""];
  void generator(){
    if(shapesToChose[0].isEmpty){
      shapesToChose[0] = shape.shCode;
    }
    if(shapesToChose[1].isEmpty){
      shapesToChose[1] =  shape.shCode;
    }
    List<int> uperIntList = [];
    List<int> smallIntList = [];
    int n = 0;
    for(int i = 0;i <  shape.shCode.length;i++){
      n++;
      if(n == 2){
        uperIntList.add(whereLetter(shape.shCode[i-1]));
        smallIntList.add(whereLetter(shape.shCode[i]));
        n = 0;
      }
    }
    List<List<int>> courentPoinets = [];
    for(int i = 0;i < uperIntList.length;i++){
      courentPoinets.add([uperIntList[i],smallIntList[i]]);
    }
    List<List<int>> allPoints = [];
    for(int u = 0;u < uperLetter.length ;u++){
      for(int s = 0;s < uperLetter.length ;s++){
        allPoints.add([u,s]);
      }
    }
    List<List<int>> pointsAvailble = [] ;
    for(final e in courentPoinets){
      for(final f in allPoints){
        if(e.first == f.first){
          if(!(e.first == f.first && e.last == f.last)){
            if(e.last + 1 == f.last || e.last - 1 == f.last){
              bool clear = true;
              for(final h in courentPoinets){
                if(listEquals(f, h)){
                  clear = false;
                }
              }
              if(clear){
                pointsAvailble.add(f);
              }
            }
          }
        }else if(e.last == f.last){
          if(!(e.first == f.first && e.last == f.last)){
            if(e.first + 1 == f.first || e.first - 1 == f.first){
              bool clear = true;
              for(final h in courentPoinets){
                if(listEquals(f, h)){
                  clear = false;
                }
              }
              if(clear){
                pointsAvailble.add(f);
              }
            }
          }

        }
      }
    }

    pointsAvailble.removeWhere(
        (e){
         for(final f in courentPoinets){
           if(listEquals(e, f)){
             print("tt worlk");
             return true;
           }else{
             return false;
           }
         }
         return false;
        }
    );

    String uperOne ;
    String smallOne ;
    String uperTow ;
    String smallTow ;
    int rand = Random().nextInt(10);
    void normal(){
      void randomGenerate(){
        int rand = Random().nextInt(pointsAvailble.length);
        int _uperOneN = pointsAvailble[rand][0];
        uperOne = getLetter(_uperOneN);
        int _smallOneN = pointsAvailble[rand][1];
        smallOne = getLetter(_smallOneN).toLowerCase();
      }
      randomGenerate();
      void randomT(){
        int rand = Random().nextInt(pointsAvailble.length);
        int _uperTn = pointsAvailble[rand][0];
        uperTow = getLetter(_uperTn);
        int _smallTn = pointsAvailble[rand][1];
        print("_smallTn $_smallTn");
        smallTow = getLetter(_smallTn).toLowerCase();
      }
      randomT();
    }
    void near(){
      List toChose = [];
      List point = [whereLetter(shape.shCode[shape.shCode.length - 2]) , whereLetter(shape.shCode[shape.shCode.length - 1])];
      for(final e in pointsAvailble){
        if(e.first == point.first){
          if(e.last + 1== point.last  || e.last - 1 == point.last ){
            toChose.add(e);
          }
        }else if(e.last == point.last){
          if(e.first + 1== point.first || e.first - 1 == point.first ){
            toChose.add(e);
          }
        }
      }
      if(toChose.isNotEmpty){
        int rand = Random().nextInt(toChose.length);
        int randT = Random().nextInt(toChose.length);
        uperOne = getLetter(toChose[rand][0]).toUpperCase();
        smallOne = getLetter(toChose[rand][1]).toLowerCase();
        uperTow =getLetter(toChose[randT][0]).toUpperCase();
        smallTow = getLetter(toChose[randT][1]).toLowerCase();
      }else{
        normal();
      }
    }
    if(rand < 1){
      normal();
    }else{
      near();
    }
      shapesToChose[0] = shapesToChose[0] + uperOne + smallOne;
      shapesToChose[1] = shapesToChose[1] + uperTow + smallTow;
  }
  @override
  void initState() {
    getShape();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xff121a25),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              size.width >= 360 ?Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      shapeWidget(0),
                      shapeWidget(1)
                    ],
                  )
              ) :
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    shapeWidget(0),
                    shapeWidget(1)
                  ],
                ),
              )
              ,
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Choose the fittest to stay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )
    );
  }
  Widget shapeWidget(index){
    return GestureDetector(
      onTap: () async{
        if(index == 0){
          Shape _upShape = shape;
          _upShape.shCode = shape.shCode + (shapesToChose[index][shapesToChose[index].length - 2] ) + (shapesToChose[index][shapesToChose[index].length - 1] );
          print("up ${_upShape.shCode}");
          int  n = await db.updateShape(_upShape);
          changeHapedned = true;
          print("nn $n");
          Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => DevelopPage(id)));
        }
        else if(index == 1){
          Shape _upShape = shape;
          _upShape.shCode = shape.shCode + (shapesToChose[index][shapesToChose[index].length - 2] ) + (shapesToChose[index][shapesToChose[index].length - 1] );
          print("up ${_upShape.shCode}");
          int n = await db.updateShape(_upShape);
          changeHapedned = true;
          print("n $n");
          Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => DevelopPage(id)));
        }
      },
      child: Container(
        width: 180,
        height: 240,
        child: Card(
          color: Color(0xff1c2834),
          elevation: 5,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
              width: 180,
              height: 180,
              margin: EdgeInsets.only(bottom: 5),
              child: ShapeView( shapesToChose[index], Size(170,170)
              )
          ),
              Text(index == 0 ? "A" : "B",style: TextStyle(color: Colors.white,fontSize: 30),)
            ],
          ),
        ),
      ),
    );



  }

}
