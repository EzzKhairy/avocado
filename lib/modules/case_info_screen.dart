import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class CaseInfoScreen extends StatelessWidget {
  CaseInfoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AvocadoCubit,AvocadoStates>(
      listener: (context,state){},
      builder: (context,state)

      {
        return Scaffold(
          appBar: NewGradientAppBar(
            centerTitle: true,
            title: Text(
              'Case Summary'.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Nedian',
                fontSize: 25.0,
                color: gold,
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
                stops: const [0.20, 0.17, 0.40]),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Case: BAR-25-5-2000-05',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        SizedBox(height: 10,),
                        RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Status: ',
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black)
                                  ),
                                  TextSpan(
                                      text: 'Closed ',
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.red)
                                  ),
                                ]
                            )
                        ),
                        SizedBox(height: 10,),

                      ],
                    ),
                  ),
                  buildCaseInfoScreenItem(context: context, title: 'Title', info: 'Karim Salem - Real estate Transaction'),
                  const SizedBox(height: 10,),
                  buildCaseInfoScreenItem(context: context,title: 'Type', info: 'Real estate'),
                  const SizedBox(height: 10,),
                  buildCaseInfoScreenItem(context: context,title: 'Lawyer', info: 'Ahmed Mohamed'),
                  const SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              color: gold,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height : 10),
                          const Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                                " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
                                " when an unknown printer took a galley of type and scrambled it to make a type specimen book."
                                "when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCaseInfoScreenItem({
    required context,
    required String? title,
    required String? info,
  }) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: const EdgeInsetsDirectional.all(2.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  '$title',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  '$info',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  
  Widget innerWidget(context) => Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black),
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: TextStyle(
                color: gold,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height : 10),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  
  Widget frontWidget(context) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsetsDirectional.all(2.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            child: Text(
                'Description',
              style: TextStyle(
                color: gold,
              ),
            ),
            onPressed: ()
            {
              final foldingCellState = context.findAncestorStateOfType<SimpleFoldingCellState>();
              foldingCellState?.toggleFold();
            },
          ),
        ),
      )
  );
}
