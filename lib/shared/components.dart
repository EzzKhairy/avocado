import 'package:avocado/modules/login_screen.dart';
import 'package:avocado/remoteNetwork/cache_helper.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void navigateTo(context, screen) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => screen,
  ),
);

void navigateAndKill (context,widget) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
}


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  VoidCallback? onTap,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  bool isEnabled = true,
  IconData? suffix,
  VoidCallback? suffixPressed,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted:onSubmit,
  onChanged: onChange,
  onTap: onTap,
  enabled: isEnabled,
  validator: validate,
  cursorColor: defaultColor,
  decoration: InputDecoration(
    border: UnderlineInputBorder(borderSide: BorderSide(color: defaultColor)),

    // fillColor: defaultColor,
    // focusColor: defaultColor,
    labelText: label,
    labelStyle: TextStyle(
      color: defaultColor,
    ),
    // border: const OutlineInputBorder(),
    prefixIcon: Icon(
      prefix,
      color: defaultColor,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon : Icon(suffix),color: defaultColor,) : null,
  ),
  style: TextStyle(
    color: defaultColor,
    fontSize: 18.0,
  ),
  obscureText: isPassword,
);


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 5.0,
  VoidCallback ?function,
  required String text,
}) => Container(
  height: 55.0,
  width: width,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        fontSize: 20.0,
        color: defaultColor,
      ),
    ),
    color: Colors.black,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.zero,
    color: HexColor('494949'),
  ),
);



void signOut(context){
  CacheHelper.deleteToken(key: 'token').then((value)
  {
    if(value)
    {
      navigateAndKill(context, LoginScreen());
    }
  });
}



MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}