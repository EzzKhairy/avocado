import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/expert_session_model.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'expert_session__info_screen.dart';

class ExpertSessionScreen extends StatelessWidget {
  int? caseId;
   ExpertSessionScreen(this.caseId,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AvocadoCubit.get(context).getExpertSessions(caseId: caseId);
        return BlocConsumer<AvocadoCubit,AvocadoStates>(
          listener: (context,state){},
          builder: (context,state) {
            List<ExpertSessionData>? expertSessionData = AvocadoCubit.get(context).expertSessionModel!.expertSessionData;
            return Conditional.single(
              context: context,
              conditionBuilder: (context) => state is GetExpertSessionDataSuccessful,
              widgetBuilder:(context)=> Scaffold(
                appBar: NewGradientAppBar(
                  centerTitle: true,
                  title: Text(
                    'EXPERT SESSIONS',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      searchBar(),
                      const SizedBox(height: 20,),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context)=> expertSessionData!.isNotEmpty,
                        widgetBuilder:(context) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildExpertSessionItem(expertSessionData![index],context),
                          separatorBuilder: (context, index) => const SizedBox(height: 10,),
                          itemCount: expertSessionData!.length,
                        ),
                        fallbackBuilder: (context) => const Center(child: Text(
                          'No Expert Sessions Included',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        ),
                      ),                    ],
                  ),
                ),
              ),
              fallbackBuilder: (context) => scaleProgressIndicator(context)
            );
          },
        );
      }
    );
  }

  Widget buildExpertSessionItem(ExpertSessionData expertSessionData,context)=> GestureDetector(
    onTap: (){navigateTo(context, ExpertSessionInfoScreen(expertSessionData));},
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
