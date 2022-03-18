import 'package:avocado/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.70),
            Colors.black.withOpacity(0.75),
            Colors.black.withOpacity(0.60),
            Colors.black.withOpacity(0.65),
            Colors.black.withOpacity(0.70),
            Colors.black.withOpacity(0.95),
          ],
          begin: AlignmentDirectional.topEnd,
          end: AlignmentDirectional.bottomStart,
          stops: const [0.15,0.15,0.15,0.15,0.15,0.60],
      ),
      appBar: NewGradientAppBar(
        title: Text(
          'AVOCADO',
          style: TextStyle(
            fontFamily: 'Conquera',
            fontSize: 17.0,
            color: defaultColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        // gradient: LinearGradient(
        //     colors: [
        //       Colors.black.withOpacity(0.70),
        //       Colors.black.withOpacity(0.75),
        //       Colors.black.withOpacity(0.60),
        //       Colors.black.withOpacity(0.65),
        //       Colors.black.withOpacity(0.70),
        //       Colors.black.withOpacity(0.95),
        //     ],
        //     begin: AlignmentDirectional.topEnd,
        //     end: AlignmentDirectional.bottomStart,
        //     stops: const [0.15,0.15,0.15,0.15,0.15,0.60]
        // ),
      ),
      body: Column(),
    );
  }
}
