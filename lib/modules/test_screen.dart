import 'package:avocado/cubit/avocadoCubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/lawyers_model.dart';
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
    return BlocProvider(
      create: (context)=> AvocadoCubit()..getLawyersData(),
      child: BlocConsumer<AvocadoCubit,AvocadoStates>(
          listener: (context,state){

          },
          builder: (context,state) {
            AvocadoCubit cubit = AvocadoCubit();
            List<Lawyers>? LawyersData = cubit.lawyers?.lawyersData;
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
              body: ListView.builder(
                  itemBuilder: (context,index) => ClientBuilder(cubit.lawyers?.lawyersData[index]),
                itemCount: cubit.lawyers?.lawyersData.length,
              )
        );
      },
      ),
    );
  }
  Widget ClientBuilder(Lawyers? lawyersModel) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: grey,
              child: const Text(
                'K',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 22),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${lawyersModel?.name}'),
                SizedBox(
                  height: 5,
                ),
                Text('${lawyersModel?.email}')
              ],
            ),
            const Spacer(),
            CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.phone_in_talk_outlined,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }

}
