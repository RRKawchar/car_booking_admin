import 'package:flutter/material.dart';

class AppTextStyle{

  static normalTextStyle({double fontSize = 15.0,FontWeight fontWeight=FontWeight.w800,Color color=Colors.black}){

    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color
    );
  }



}