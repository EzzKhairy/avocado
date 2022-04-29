import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/expert_session_model.dart';
import 'package:avocado/models/session_model.dart';
import 'package:avocado/modules/session_info_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ExpertSessionScreen extends StatelessWidget {
  const ExpertSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
      listener: (context,state){},
      builder: (context,state) {
        List<ExpertSessionData>? expertsessionData = AvocadoCubit.get(context).expertSessionModel!.expertSessionData;
        return Scaffold(
          appBar: NewGradientAppBar(
            centerTitle: true,
            title: Text(
              'SESSIONS',
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchBar(),
              const SizedBox(height: 20,),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildSessionItem(expertsessionData![index],context),
                separatorBuilder: (context, index) => const SizedBox(height: 10,),
                itemCount: 10,
              ),
            ],
          ),
        );
      },
    );
  }


  Widget buildSessionItem(ExpertSessionData expertSessionData,context)=> GestureDetector(
    onTap: (){navigateTo(context, SessionInfoScreen());},
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsetsDirectional.all(2.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 160,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Office Address ${expertSessionData.officeAddress}'.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 3,
                ),
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(vertical: 5.0),
                child: horizontalDivider(height: 1.5,hColor: Colors.grey),
              ),
              Text(
                'Opened ${expertSessionData.createdAt}'.split('T').elementAt(0),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                '${expertSessionData.expertName}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                '${expertSessionData.sessionReason}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${expertSessionData.sessionDate}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${expertSessionData.nextDate}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );

}
