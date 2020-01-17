import 'package:ballfarm/UI/mainPage.dart';
import 'package:ballfarm/models/user.dart';
import 'package:ballfarm/uti/databasehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeachPage extends StatefulWidget {
  @override
  _TeachPageState createState() => _TeachPageState();
}

class _TeachPageState extends State<TeachPage> {
  int page = 1;
  var db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle tittleStyle = TextStyle(color: Colors.white,fontSize: 25);
    TextStyle detStyle = TextStyle(color: Color(0xffD6D6D6),fontSize: 22);
    return Scaffold(
      backgroundColor: Color(0xff121A25),
      body: Container(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                width: 280,
                height: 280,
                margin: EdgeInsets.only(bottom: 10),
                child: page == 1 ? Image(image: AssetImage("images/earth.png"),) :
                page == 2 ? Image(image: AssetImage("images/single.png"),) :
                page == 3 ? Image(image: AssetImage("images/dna.png"),)
                /* page == 4 */    : Image(image: AssetImage("images/brain.png"),)
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child:
                        page == 1 ? Text("Formation of the planet Earth",style: tittleStyle,)
                        : page ==2 ? Text("First life",style: tittleStyle,)
                        :page == 3 ? Text("Genetics",style: tittleStyle,)
                        : Text("Now after 2600 years",style: tittleStyle,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40,left: 2,right: 2),
                    child:
                    page == 1 ? Text("Before 4600 million years ago the earth was formed in the solar system , and there our stroy is begining",style: detStyle,textAlign: TextAlign.center,)
                        : page ==2 ? Text("Before 4000 million years ago The first simple form of life appeared because the conditions and climate of the earth were appropriate for its appearance",style: detStyle,textAlign: TextAlign.center)
                        :page == 3 ? Text("It is possible that an error occurs in the transfer of a small part of the gene, and this error can be beneficial or harmful to the organism, and thus comes the role of naturalists to choose the most suitable organism to survive.",style: detStyle,textAlign: TextAlign.center)
                        : Text("We will simulate the evolution of animals and your brain will play the role of nature to obtain the most suitable form of survival",style: detStyle,textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.navigate_before,color: page > 1 ? Colors.white : Colors.white30,size: 30,),
                    onPressed: (){
                      if(page > 1){
                        setState(() {
                          page = page - 1;
                        });
                      }
                    },
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  page == 1 ? ball(1,white: true) : ball(1),
                  page == 2 ? ball(2,white: true) : ball(2),
                  page == 3 ? ball(3,white: true) : ball(3),
                  page == 4 ? ball(4,white: true) : ball(4),
                  Expanded(
                    child: Container(),
                  ),
                  IconButton(
                    onPressed: (){
                      if(page < 4){
                        setState(() {
                          page = page + 1;
                        });
                      }else{
                        User _user = User("y");
                        print(   db.saveUser(_user));
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>MainPage()));
                      }
                    },
                    icon: Icon(page < 4 ? Icons.navigate_next:Icons.done,color: Colors.white,size: 30,),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget ball(int pageIn,{bool white}){
    if(white != null&& white == true){
      return GestureDetector(
        onTap:(){
          print("page $page");
          setState(() {
            page = pageIn;
          });
        },
        child: Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.only(left: 5,right: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
          ),
          child: Container(),
        ),
      );
    } else if(white != null){
      return null;
    }else{
      return GestureDetector(
        onTap: (){
          setState(() {
            page = pageIn;
          });
        },
        child: Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.only(left: 5,right: 5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white,style: BorderStyle.solid,width: 2)
          ),
          child: Container(),
        ),
      );
    }
  }

}