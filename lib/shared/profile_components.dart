import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget profileFormField({
  TextEditingController ?controller,
  required TextInputType type,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  VoidCallback? onTap,
  required String? Function(String?)? validate,
  String? label,
  IconData ?prefix,
  bool isPassword = false,
  bool isEnabled = true,
  bool readonly = false,
  IconData? suffix,
  String ?hintText,
  bool spaced = false,
  VoidCallback? suffixPressed,
  String ?initialValue,
  int ?maxLines
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted:onSubmit,
  onChanged: onChange,
  maxLines: maxLines ?? 1,
  onTap: onTap,
  enabled: isEnabled,
  readOnly: readonly,
  validator: validate,
  cursorColor: Colors.black,
  initialValue: initialValue,
  textAlignVertical: TextAlignVertical.center,
  textAlign: TextAlign.start,
  decoration: InputDecoration(
    border: UnderlineInputBorder(borderSide: BorderSide(color: gold)),
    enabledBorder:  UnderlineInputBorder(borderSide: BorderSide(color: gold)),
    labelText: label,
    hintText: hintText,
    contentPadding: EdgeInsets.symmetric(vertical:12,horizontal: 25 ),
    hintStyle: TextStyle(color: Colors.grey,),
    labelStyle: TextStyle(
      color: HexColor('838383'),
    ),
    prefixIcon: prefix != null ? Icon(
      prefix,
      color: gold,
    ): null,
    suffixIcon: suffix != null ? IconButton(
        onPressed: suffixPressed,
        icon : Icon(suffix,color: gold,)) : null,
  ),
  style: const TextStyle(
    color: Colors.black,
    fontSize: 18.0,
  ),
  obscureText: isPassword,
);


Widget profileButton({
  double width = double.infinity,
  Color background = Colors.black,
  bool isUpperCase = true,
  double radius = 5.0,
  VoidCallback ?function,
  required String text,
}) => Container(
  height: 45.0,
  width: width,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        color: gold,
      ),
    ),
  ),
  decoration: const BoxDecoration(
    borderRadius: BorderRadius.zero,
    color: Colors.black,
  ),
);


Widget changePasswordFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  bool isEnabled = true,
  IconData? suffix,
  VoidCallback? suffixPressed,
  required String ?hintText,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted:onSubmit,
  onChanged: onChange,
  onTap: onTap,
  enabled: isEnabled,
  cursorColor: Colors.black,
  decoration: InputDecoration(
    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
    suffixIcon: suffix != null ? IconButton(
        onPressed: suffixPressed,
        icon : Icon(suffix,color: Colors.black,)) : null,
  ),
  style: const TextStyle(
    color: Colors.black,
    fontSize: 18.0,
  ),
  obscureText: isPassword,
);