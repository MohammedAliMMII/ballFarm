
import 'package:ballfarm/UI/developPage.dart';
import 'package:ballfarm/Widets/shapeView.dart';
import 'package:ballfarm/models/shape.dart';
import 'package:ballfarm/uti/databasehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'detailsPage.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var db = DatabaseHelper();
  List<Shape> shapesList= [];
  bool get = false;
  void getShapesView() async{
    List shapes = await db.getAllShape();
    for(final e in shapes){
      setState(() {
        shapesList.add(Shape.fromMap(e));
      });
    }
    setState(() {
      get = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getShapesView();
  }
  randomName(){
    List<String> names = ["Alani","Amarillo","Amber","Apricot","Auburn","Autumn",
      "Butter","Carrot","Cayenne","Cheetah","Cinnamon","Citrus",
      "Clementine","Curry","Cutie","Goldfish","Goldie","Honey",
      "Mango","Marigold","Marmite","Nemo","Orange","Orangina",
      "Peach","Peaches","Persimmon","Poppy","Pumpkin","Quartz",
      "Saffy","Scarlet","Sherbet","Sunflower","Sunny","Sunshine",
      "Sweet","Tang","Tangerine","Tango","Ablaze","Blaze",
      "Brick","Chuck","Clay","Copper","Copperfield","Coral",
      "Crimson","Desert","Ember","Fire","Fireball","Firecr",
      "fighter","Firefly","Fox","Fuego","Garnet","Ginger",
      "Gingersnap","Ginger","Inferno","Merida","Mimosa","Monarch",
      "Nevada","Peaches","Penny","Phoenix","Pumpkin","Red",
      "Rose","Rosy","Ruby","Rusty","Saffron","Sahara",
      "Scorch","Tiger","Tigress","Aslan","Brian","Crooks",
      "Apollo","Archie","Axl","Blake","Chester","Damian",
      "Sheeran","Stoltz","Opie","Ossie","Qais","Qasem",
    ];
    List<String> namesToUse = [];
    for(final e in names){
      bool unFound = true;
      for(final f in shapesList){
        if(e == f.name){
          unFound = false;
          break;
        }
      }
      if(unFound){
        namesToUse.add(e);
      }
    }
    if(namesToUse.length > 0){
      return namesToUse[Random().nextInt(namesToUse.length)];
    }else{
      List<String> obj = [];
      for(final e in shapesList){
        if(e.name[0] + e.name[1] + e.name[2] == "Obj"){
          obj.add(e.name);
        }
      }
      if(obj.isNotEmpty){
        String name = obj.last;
        int num = int.parse(name.replaceAll("Obj", ""));
        return "Obj${num + 1}";
      }else{
        return "Obj1";
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    if(changeHapedned != null){
      if( changeHapedned == true){
        shapesList = [];
        getShapesView();
        changeHapedned = false;
      }
    }
    List leftShapes = [];
    List rightShapes = [];
    bool isLeft = true;
    for(int i = 0 ; i < shapesList.length;i++){
      if(isLeft){
        leftShapes.add(containerUn(i));
      }else{
        rightShapes.add(containerUn(i));
      }
      isLeft = !isLeft;
    }
    if(leftShapes.length > rightShapes.length){
      rightShapes.add(Container(
        width: 180,
        height: 240,
      ));
    } else{
      rightShapes.removeWhere(
          (e){
           return e ==  Container(
             width: 180,
             height: 240,
           );
          }
      );
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff121a25),
      body:get == false ? Container(color: Color(0xff121a25),) : shapesList.isNotEmpty ? SafeArea(
       child:   SingleChildScrollView(
          child: size.width >= 360 ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: List.generate(leftShapes.length, (index){
                          return leftShapes[index];
                        })
                      ),
                      Column(
                        children: List.generate(rightShapes.length, (index){
                          return rightShapes[index];
                        })
                      ),
                    ],
                  ) :
          Container(
            alignment: Alignment.center,
            child: Column(
             children: List.generate(shapesList.length,
                 (index){
                 return containerUn(index);
                 }
             )
            ),
          )
         ,
        ),
    
      ) : SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 2,right: 2),
                child: Text(
                  "To add new Organism just click on + button" ,style: TextStyle(color: Color(0xff888c92),fontSize: 28),textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40,bottom:10,left: 2,right: 2),
                child: Text(
                  "To delete Organism or show details jsut have long press on Organism shape" ,style: TextStyle(color: Color(0xff888c92),fontSize: 28),textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.details,color:  Color(0xff32a4c6),),
                  Padding(padding: EdgeInsets.only(left: 15),),
                  Icon(Icons.delete,color: Color(0xffe72b5c),),
                ],
              )
            ],
          ),
        ),),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () async{
            int uper = Random().nextInt(26);
            int lawer = Random().nextInt(26);
            String uperS = getLetter(uper);
            String lawerS = getLetter(lawer).toLowerCase();
            String _shCode = uperS+lawerS;
            int id = await db.saveShape(Shape(_shCode,randomName()));
            Shape _shape = await db.getShape(id);
            setState(() {
              shapesList.add(_shape);
            });
          },
          child: Icon(Icons.add,color: Colors.white,size: 35,),
        ),
      ),
    );
  }
  _showDialog(index){
    showDialog(
        context: context,
      builder: (context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30)
              )
            ),
            backgroundColor:  Color(0xff0d1520),
            child: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            int id = shapesList[index].id;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(id)));
                          },
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.details,color: Color(0xff32a4c6),),
                                Text("details",style: TextStyle(fontSize: 20,color: Color(0xfff8f9fa,)),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            db.deleteShape(shapesList[index].id);
                            setState(() {
                              shapesList.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.delete,color: Color(0xffe72b5c),),
                                Text("remove",style: TextStyle(fontSize: 20,color: Color(0xfff8f9fa,)),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
      }
    );
  }
  Widget containerUn(index){
    Shape _shape = shapesList[index];
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DevelopPage(_shape.id)));
      },
      onLongPress: (){
        _showDialog(index);
      },
      child: Container(
        width: 180,
          height: 240,
          child: Card(
            color: Color(0xff1c2834),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width:180,
                  height: 180,
                  child: ShapeView(shapesList[index].shCode,Size(170,170))),
                Text(shapesList[index].name,style: TextStyle(color: Colors.white,fontSize: 30),)
              ],
            ),
          )
      ),
    );
  }
}
