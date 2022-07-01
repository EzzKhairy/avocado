import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../models/tasks_model.dart';

String ?token;
int ?lawyerId;


HexColor gold = HexColor('D8C690');

HexColor grey = HexColor('ADADAD');


HexColor default2 = HexColor('494949');


Widget separator (double wide,double high){
  return SizedBox(width: wide,height: high,);
}
void pop (context) {
  Navigator.pop(context);
}

// static const male = 'male';
//   static const female = 'female';