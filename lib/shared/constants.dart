import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

String ?token;

HexColor gold = HexColor('D8C690');

HexColor grey = HexColor('ADADAD');


HexColor default2 = HexColor('494949');


Widget separator (double wide,double high){
  return SizedBox(width: wide,height: high,);
}
void pop (context) {
  Navigator.pop(context);
}
