import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
        listener: (context,state){},
        builder: (context,state) {
          AvocadoCubit cubit = AvocadoCubit.get(context);
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
            body: Conditional.single(
              widgetBuilder:(context) =>
                  Text('${cubit.lawyersList?.lawyersData[1].email}',style: const TextStyle(color: Colors.white),),
              fallbackBuilder: (context) => const Center(child: Text('Null',style: TextStyle(color: Colors.white),)),
              conditionBuilder: (context) => AvocadoCubit.get(context).lawyersList?.lawyersData != null,
              context: context,
        ),
      );
    },
    );
  }

}
