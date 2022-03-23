import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
          title: Text(
            'AVOCADO',
            style: TextStyle(
              fontFamily: 'Nedian',
              fontSize: 23.0,
              color: gold,
              fontWeight: FontWeight.bold,
            ),
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            searchBar(),
          ],
        ),
      ),
    );
  }
}
