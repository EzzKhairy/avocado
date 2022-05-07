import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/case_model.dart';
import 'package:avocado/models/session_model.dart';
import 'package:avocado/modules/case_info_screen.dart';
import 'package:avocado/modules/cases_screen.dart';
import 'package:avocado/modules/clients_screen.dart';
import 'package:avocado/modules/session_info_screen.dart';
import 'package:avocado/modules/tasks_screen.dart';
import 'package:avocado/remoteNetwork/cache_helper.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit, AvocadoStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        List<CaseData>? casesData = AvocadoCubit.get(context).caseModel?.casesData;
        if(casesData!.isEmpty){return const Center(child: CircularProgressIndicator());}
        else
          {
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Dashboard',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          buildHomeCard(
                            function: (){
                              navigateTo(context,  CasesScreen());
                              print (token);
                              print(CacheHelper.getData(key: 'token'));
                            },
                            title: 'Total Cases',
                            icon: Icons.format_align_justify_outlined,
                            number: casesData.length,
                          ),
                          const SizedBox(width: 10,),
                          buildHomeCard(
                            function: (){navigateTo(context, const ClientsScreen());},
                            title: 'Total Clients',
                            icon: Icons.people_alt_outlined,
                            number: AvocadoCubit.get(context).clientsModel!.clientsData!.length,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12,),
                      Row(
                        children: [
                          buildHomeCard(
                            function: (){navigateTo(context,const TasksScreen());},
                            title: 'Total Tasks',
                            icon: Icons.assignment_turned_in_rounded,
                            number: 15,
                          ),
                          const SizedBox(width: 10,),
                          buildHomeCard(
                            function: (){navigateTo(context, SessionInfoScreen());},
                            title: 'Total Sessions',
                            icon: Icons.people_alt_outlined,
                            number: 50
                          ),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      buildTaskHomeItem(context),
                      const SizedBox(height: 15,),
                      Container(
                        height: 165,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildCasesItem(casesData[index], context,width: MediaQuery.of(context).size.width*.70),
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

      },
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


  Widget buildTaskHomeItem(context)
  {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsetsDirectional.all(2.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Whats up Today?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    child: Text(
                      'View All',
                      style: TextStyle(color: gold),),
                    onTap: (){navigateTo(context, const TasksScreen());},
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: const [
                        CircleAvatar(radius: 5,),
                        CircleAvatar(radius: 3.5,backgroundColor: Colors.white),
                        ]
                      ),
                      verticalDivider(height: 30,),
                    ],
                  ),
                  const SizedBox(width: 7,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Sending out some paper work'),
                      SizedBox(height: 5,),
                      Text('10.00 Am',style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Column(
                    children: [
                      Stack(
                          alignment: AlignmentDirectional.center,
                          children: const [
                            CircleAvatar(radius: 5,),
                            CircleAvatar(radius: 3.5,backgroundColor: Colors.white),
                          ]
                      ),
                      verticalDivider(height: 30),
                    ],
                  ),
                  const SizedBox(width: 7,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Sending out some paper work'),
                      SizedBox(height: 5,),
                      Text('10.00 Am',style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildCasesItem(CaseData caseData, context, {required width,})
  => GestureDetector(
      onTap: (){navigateTo(context, CaseInfoScreen(caseData));},
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: const EdgeInsetsDirectional.all(2.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 160,
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${caseData.caseID}'.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: horizontalDivider(height: 1.5,hColor: Colors.grey),
                ),
                 Text(
                  'Opened ${caseData.createdAt}'.split('T').elementAt(0),
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Mohamed Ahmed',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  '${caseData.caseType}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    const Spacer(),
                    caseData.status == 'open'?
                    Text(
                      '${caseData.status}'[0].toUpperCase() + '${caseData.status}'.substring(1),
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ):Text(
                      '${caseData.status}'[0].toUpperCase() + '${caseData.status}'.substring(1),
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );


}
