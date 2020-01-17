import 'package:flutter/material.dart';
import 'package:ballfarm/main.dart';
class ShapeView extends StatelessWidget {
  final Size widgetSize;
  GlobalKey keyC = GlobalKey();
  final String shape;

  ShapeView(this.shape,this.widgetSize);

  double fromWidth(String upLetterCode){
    int n ;
    for(int i = 0; i < uperLetter.length ; i++){ // know the arrangement of letter in list
      if(uperLetter[i] == upLetterCode){
        n = i + 1; // i = 0 , i +1 = 1 ; ex for A
      }
    }
    return ((1/(uperLetter.length + 4)) * n); // equation to set ball from left

  }

  double fromHeight(String letterCode){
    int n ;
    for(int i = 0; i < uperLetter.length ; i++){ // know the arrangement of letter in list
      if(uperLetter[i].toLowerCase() == letterCode){
        n = i + 1; // i = 0 , i +1 = 1 ; ex for A
      }
    }
    return ((1/(uperLetter.length + 4)) * n); // equation to set ball from left

  }
  double roungFix = 0.05;
  @override
  Widget build(BuildContext context) {
    List<Widget> balls = [];
    int _n = 0;
    if(shape != null){
      for(int i = 0; i < shape.length;i++){
        _n++;
        if(_n == 2){
            balls.add(ballOfDraw(context, shape[i-1], shape[i]));
          _n = 0;
        }
      }
    }


    return Container(
      width: widgetSize.width ,
      height: widgetSize.height ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(widgetSize.width > 325 ? 45:widgetSize.width > 150 ? 25 : 10)
        )
      ),
      child: Container(
        padding: EdgeInsets.all(widgetSize.width > 325 ? 6:widgetSize.width > 150 ? 4 : 2),
        child: Stack(
          children: List.generate(
            balls.length,
              (index){
              return balls[index];
              }
          )
        ),
      ),
    );
  }

  Widget ballOfDraw(context,String upLetter,String smallLetter,{bool colored}){
    return Positioned(
      left:  widgetSize.width * fromWidth(upLetter),
      top:  widgetSize.height * fromHeight(smallLetter),
      child: Container(
        width: (widgetSize.width > 325 ? 0.00013 * (widgetSize.width * widgetSize.height) : widgetSize.width > 150 ? 0.00027 * (widgetSize.width * widgetSize.height) : 0.0003 * (widgetSize.width * widgetSize.height) ),
        height: (widgetSize.width > 325 ? 0.00013 * (widgetSize.width * widgetSize.height) : widgetSize.width > 150 ? 0.00027 * (widgetSize.width * widgetSize.height) : 0.0003 * (widgetSize.width * widgetSize.height) ),
        decoration: BoxDecoration(
          color: colored == null ? Colors.white:Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
