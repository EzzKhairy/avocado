import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget profileFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  VoidCallback? onTap,
  required String? Function(String?)? validate,
  required String label,
  IconData ?prefix,
  bool isPassword = false,
  bool isEnabled = true,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool readOnly = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted:onSubmit,
  onChanged: onChange,
  onTap: onTap,
  enabled: isEnabled,
  validator: validate,
  cursorColor: Colors.black,
  decoration: InputDecoration(
    border: UnderlineInputBorder(borderSide: BorderSide(color: gold)),
    enabledBorder:  UnderlineInputBorder(borderSide: BorderSide(color: gold)),
    // fillColor: defaultColor,
    // focusColor: defaultColor,
    labelText: label,
    labelStyle: TextStyle(
      color: HexColor('838383'),
    ),
    // border: const OutlineInputBorder(),
    prefixIcon: Icon(
      prefix,
      color: gold,
    ),
    suffixIcon: suffix != null ? IconButton(
        onPressed: suffixPressed,
        icon : Icon(suffix,color: gold,)) : null,
  ),
  style: const TextStyle(
    color: Colors.black,
    fontSize: 18.0,
  ),
  obscureText: isPassword,
  readOnly: readOnly,
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