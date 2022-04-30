import 'package:avocado/modules/login_screen.dart';
import 'package:avocado/modules/search_screen.dart';
import 'package:avocado/remoteNetwork/cache_helper.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

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
  TextInputType? type,
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
  onTap: onTap,
  enabled: isEnabled,
  validator: validate,
  cursorColor: gold,
  decoration: InputDecoration(
    border: UnderlineInputBorder(borderSide: BorderSide(color: gold)),
    enabledBorder:  UnderlineInputBorder(borderSide: BorderSide(color: grey)),
    // fillColor: defaultColor,
    // focusColor: defaultColor,
    labelText: label,
    labelStyle: TextStyle(
      color: gold,
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
  style: TextStyle(
    color: gold,
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
        color: gold,
      ),
    ),
    color: HexColor('494949'),
  ),
  decoration: const BoxDecoration(
    borderRadius: BorderRadius.zero,
  ),
);

Widget baseAlertDialog({
  required context,
  String? title,
  String? content,
  String? outlinedButtonText,
  String? elevatedButtonText,
  IconData? elevatedButtonIcon,
}){
  return AlertDialog(
    backgroundColor: Colors.white,
    title: Text('$title'),
    titlePadding: const EdgeInsetsDirectional.only(start:13,top: 15 ),
    content: Text('$content'),
    elevation: 8,
    contentPadding: const EdgeInsets.all(15),
    actions: [
      OutlinedButton(
          onPressed: (){
            Navigator.of(context).pop(false);
          },
          child: Text('$outlinedButtonText')
      ),
      Container(
        width: 100,
        child: ElevatedButton(
          style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.black)) ,
          onPressed: (){
            Navigator.of(context).pop(true);
          },
          child:Text('$elevatedButtonText',style: TextStyle(color: gold)),
        ),
      ),
    ],

  );
}

Widget scaleProgressIndicator(context){
  return Container(
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.842),
            Colors.black.withOpacity(0.845),
            Colors.black.withOpacity(0.89),
          ],
          begin: AlignmentDirectional.topEnd,
          end: AlignmentDirectional.bottomStart,
          stops: const [0.20, 0.17, 0.40]),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/output-onlinegiftools(1).gif'),
        const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50
          ),
          child: LinearProgressIndicator(),
        )
      ],
    ),
  );
}

void viewLocation(double lat, double lng) async {
var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
if (await canLaunchUrl(uri)) {
await launch(uri);
} else {
throw 'Could not launch ${uri.toString()}';
}
}

Widget horizontalDivider({
  double height =0.25,
  double width = double.infinity,
  Color hColor = Colors.black,
}) => Container(
  color: hColor,
  height: height,
  width: width,
);

Widget verticalDivider({
  double height = 90,
  Color vColor = Colors.black,
  double width = 0.25,
}) => Container(
  color: vColor,
  height: height,
  width: width,
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

void showToast({
  required context,
  required msg,
  Color? backgroundColor,
}){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Future launch(url) async {
  if (await launchUrl(url)) throw 'Could not launch $url';
}

Widget searchBar({
  context,
  bool readOnly = true,
  double height = 40,
  double width = double.infinity,
}){
  return Container(
    height: height,
    width: width,
    child: TextFormField(
      readOnly: readOnly,
      style: const TextStyle(color: Colors.grey),
      onTap: () => navigateTo(context, SearchScreen()),
      decoration: InputDecoration(
        border: OutlineInputBorder( borderRadius: BorderRadius.circular(50),borderSide: const BorderSide(style: BorderStyle.none,width: 0)),
        filled: true,
        fillColor: HexColor("C4C4C4"),
        disabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(50),borderSide: const BorderSide(style: BorderStyle.none,width: 0)),
        focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(50),borderSide: const BorderSide(style: BorderStyle.none,width: 0)),
        hintText: "Search",
        hintStyle: const TextStyle(fontSize: 15,color: Colors.black),
        prefixIcon: const Icon(Icons.search,color: Colors.black,),
        contentPadding: EdgeInsets.zero
      ),
    ),
  );
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