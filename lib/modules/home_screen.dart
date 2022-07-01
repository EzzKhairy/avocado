import 'package:avocado/Layout/app_layout.dart';
import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/case_model.dart';
import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/models/tasks_model.dart';
import 'package:avocado/modules/casesScreen/case_info_screen.dart';
import 'package:avocado/modules/casesScreen/cases_screen.dart';
import 'package:avocado/modules/clientScreens/clients_screen.dart';
import 'package:avocado/modules/TaskScreens/tasks_screen.dart';
import 'package:avocado/modules/lawyerScreens/lawyer_cases_screen.dart';
import 'package:avocado/remoteNetwork/cache_helper.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/views/case_info_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../translation/locale_keys.g.dart';
import 'lawyerScreens/lawyers_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit, AvocadoStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        List<CaseData>? casesData = AvocadoCubit.get(context).caseModel?.casesData;
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(LocaleKeys.dashboard.tr(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          buildHomeCard(
                            function: (){
                              navigateTo(context, CasesScreen());
                              print (token);
                              print(CacheHelper.getData(key: 'token'));},
                            title: LocaleKeys.totalCases.tr(),
                            icon: Icons.format_align_justify_outlined,
                            number: casesData!.length,
                          ),
                          const SizedBox(width: 10,),
                          buildHomeCard(
                            function: (){navigateTo(context,  ClientsScreen());},
                            title: LocaleKeys.totalClients.tr(),
                            icon: Icons.people_alt_outlined,
                            number: AvocadoCubit.get(context).clientsModel!.clientsData!.length,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12,),
                      Row(
                        children: [
                          buildHomeCard(
                            function: (){navigateTo(context,AppLayout(index: 1,));},
                            title: LocaleKeys.totalTasks.tr(),
                            icon: Icons.assignment_turned_in_rounded,
                            number: 15,
                          ),
                          const SizedBox(width: 10,),
                          buildHomeCard(
                            function: (){
                              if(AvocadoCubit.get(context).isAdmin == false) {
                                navigateTo(context, LawyersScreen());
                              }
                              else{
                                showToast(context: context, msg: LocaleKeys.notAuthorized.tr());
                              }
                            },
                            title: LocaleKeys.totalLawyers.tr(),
                            icon: Icons.people_alt_outlined,
                            number: AvocadoCubit.get(context).getLawyers!.data!.length,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      buildTaskHomeItem(context,AvocadoCubit.get(context).getTasksModel),
                      const SizedBox(height: 15,),
                      Container(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => CaseInfoCard(casesData[index],width: MediaQuery.of(context).size.width*.70),
                          separatorBuilder: (context, index) => const SizedBox(width: 10,),
                          itemCount: casesData.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
    );
  }

  Widget buildHomeCard({
    required String title,
    required IconData icon,
    required int number,
    FontWeight bold = FontWeight.bold,
    required VoidCallback? function,
    context,
  })
  {
    return Expanded(
      child: GestureDetector(
        onTap: function,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          margin: const EdgeInsetsDirectional.all(2.5),
          color: Colors.black,
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: double.infinity,
            height: 126,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: gold,
                ),
                const Spacer(),
                Text(title,
                  style: TextStyle(
                    color: gold,
                    fontWeight: bold,
                    fontSize: 19,
                  ),
                ),
                const Spacer(),
                Text(
                  '$number',
                  style: TextStyle(
                    color: gold,
                    fontWeight: bold,
                    fontSize: 27,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildTaskHomeItem(context,TasksModel? tasksModel)
  {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsetsDirectional.all(2.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    LocaleKeys.whatsUpToday.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    child: Text(
                      LocaleKeys.viewAll.tr(),
                      style: TextStyle(color: gold),),
                    onTap: (){navigateTo(context, const TasksScreen());},
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Conditional.single(
                context: context,
                conditionBuilder: (context) =>  tasksModel!.tasksData!.isNotEmpty,
                widgetBuilder:(context) => ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder:(context, index) => taskItem(tasksModel!.tasksData![index]),
                    separatorBuilder: (context,index) => SizedBox(height: 5),
                    itemCount: tasksModel!.tasksData!.length < 2 ? tasksModel.tasksData!.length : 2
                ),
                fallbackBuilder: (context) => SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.toc,size: 80,color: Colors.grey.shade400,textDirection: Directionality.of(context)),
                      Text(LocaleKeys.noTasks.tr(),style: TextStyle(color: Colors.grey.shade500),textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget whatsUp(
      String? title,
      String? time
      ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!),
        SizedBox(height: 2,),
        Text(time!,style: TextStyle(color: Colors.grey),),
      ],
    );
  }

  Widget taskItem(TasksData tasksData){
    return Row(
      children: [
        pole(25),
        const SizedBox(width: 7,),
        whatsUp(
            tasksData.title,
            tasksData.startTime
        )
      ],
    );
  }

}
