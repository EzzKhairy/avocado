import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text('AVOCADO'),
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
            stops: const [0.15,0.15,0.15,0.15,0.15,0.60]
        ),
      ),
      body: Container(
        decoration:  BoxDecoration(
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
                stops: const [0.15,0.15,0.15,0.15,0.15,0.60]
            ),
            image: const DecorationImage(image: AssetImage("assets/images/VerticalLogo.png"),fit: BoxFit.cover),
        ),
      ),
    );
  }
}
