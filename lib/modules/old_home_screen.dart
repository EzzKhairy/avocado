import 'package:avocado/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class OldHomeScreen extends StatelessWidget {
  const OldHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsetsDirectional.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                searchBar(context: context),
                const SizedBox(height: 10,),
                const Text('Recent Cases',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                const SizedBox(height: 15,),

                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => recentCases(),
                    separatorBuilder: (context,index) => const SizedBox(height: 15,),
                    itemCount: 10
                )
              ],
            ),
          ),
        )
    );
  }
  Widget recentCases (){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:  EdgeInsets.symmetric(horizontal:5),
          child:  Text('Case Info',style: TextStyle(fontSize: 15),),
        ),
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          margin: const EdgeInsetsDirectional.all(2.5),
          color: HexColor('ECECEC'),
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: double.infinity,
            height: 130,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Case Number : 4'),
                const SizedBox(height: 5,),
                const Text('Office Lawyer : Ahmed Abdallah'),
                const SizedBox(height: 5,),
                const Text('Client Name : Karim Mohamed'),
                const SizedBox(height: 5,),
                const Text('Case Status : Closed'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){},
                      child: const Text( 'More info...',)
                      ,),
                  ],
                )

              ],
            ),
          ),
        ),
      ],
    );
  }
}
