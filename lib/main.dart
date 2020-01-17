import 'package:ballfarm/UI/detailsPage.dart';
import 'package:ballfarm/UI/developPage.dart';
import 'package:ballfarm/UI/mainPage.dart';
import 'package:ballfarm/UI/teach.dart';
import 'package:ballfarm/Widets/shapeView.dart';
import 'package:ballfarm/models/user.dart';
import 'package:ballfarm/uti/databasehelper.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());
List<String> uperLetter = ["A","B","C","D","E","F","G","H",'I','J','K','L','M','N',"O","P","Q","R","S","T","U","V","W","X","Y","Z"];


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var db = DatabaseHelper();
  int user = 0;
  void getUser() async{
    User _user = await db.getUser(1);
    if(_user == null){
      setState(() {
        user = null;
      });
    }else{
      setState(() {
        user = 1;
      });
    }
  }
  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home:  user == 0 ? Container(color: Color(0xff121a25),) : user == 1 ? MainPage() : TeachPage()
    );
  }
}


