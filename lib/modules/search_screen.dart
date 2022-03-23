import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        automaticallyImplyLeading: false,
        title: Padding(
            padding: const EdgeInsets.all(7),
            child: Row(
              children: [
                Container(
                  height: 35,
                  width: 250,
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: searchController,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'What are you looking for ?',
                      hintStyle: TextStyle(fontSize: 15,color: Colors.grey),
                      prefixIcon: Icon(Icons.search,),
                    ),
                    onChanged: (value) {
                      //cubit.getSearchData(value);
                    },
                  ),
                ),
                const Spacer(),
                InkWell(
                    onTap: ()
                    {
                      pop(context);
                    },
                    child: const Text('cancel',style: TextStyle(color: Colors.grey,fontSize: 15),)
                ),
              ],
            ),
          ),
        gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.842),
              Colors.black.withOpacity(0.845),
              Colors.black.withOpacity(0.89),
            ],
            begin: AlignmentDirectional.topEnd,
            end: AlignmentDirectional.bottomStart,
            stops: const [0.20,0.17,0.40]
        ),
      )
      // AppBar(
      //   automaticallyImplyLeading: false,
      //   toolbarHeight: 60,
      //   title: Padding(
      //     padding: const EdgeInsets.all(7),
      //     child: Row(
      //       children: [
      //         Container(
      //           height: 35,
      //           width: 250,
      //           child: TextFormField(
      //             style: Theme.of(context).textTheme.bodyText1,
      //             controller: searchController,
      //             textCapitalization: TextCapitalization.words,
      //             keyboardType: TextInputType.text,
      //             autofocus: true,
      //             decoration: const InputDecoration(
      //               hintText: 'What are you looking for ?',
      //               hintStyle: TextStyle(fontSize: 15),
      //               prefixIcon: Icon(Icons.search,),
      //             ),
      //             onChanged: (value) {
      //               //cubit.getSearchData(value);
      //             },
      //           ),
      //         ),
      //         const Spacer(),
      //         TextButton(
      //             onPressed: ()
      //             {
      //               pop(context);
      //             },
      //             child: const Text('cancel',style: TextStyle(color: Colors.black),)
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
