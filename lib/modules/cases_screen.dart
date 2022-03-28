import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';

class CasesScreen extends StatelessWidget {
  const CasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cases',style: TextStyle(color: gold),),),
      body: Text('Cases Screen'),
    );
  }
}
