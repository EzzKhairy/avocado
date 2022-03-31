import 'package:avocado/modules/case_summary_screen.dart';
import 'package:avocado/modules/cases_screen.dart';
import 'package:avocado/modules/clients_screen.dart';
import 'package:avocado/modules/tasks_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Dashboard',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 15,),
              Row(
                children: [
                  buildHomeCard(
                    function: (){navigateTo(context, const CasesScreen());},
                    title: 'Total Cases',
                    icon: Icons.format_align_justify_outlined,
                    number: 700,
                  ),
                  const SizedBox(width: 10,),
                  buildHomeCard(
                    function: (){navigateTo(context, const ClientsScreen());},
                    title: 'Total Clients',
                    icon: Icons.people_alt_outlined,
                    number: 509,
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
                    function: (){navigateTo(context, const ClientsScreen());},
                    title: 'Total Clients',
                    icon: Icons.people_alt_outlined,
                    number: 700,
                  ),
                ],
              ),
              SizedBox(height: 15,),
              buildTaskHomeItem(context),
              SizedBox(height: 15,),
              Container(
                height: 160,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildRecentCasesHomeItem(context,),
                  separatorBuilder: (context, index) => const SizedBox(width: 10,),
                  itemCount: 10,
                ),
              ),
              const SizedBox(height: 15,),
            ],
          ),
        ),
      ),
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


  Widget buildRecentCasesHomeItem(context)
  {
    return GestureDetector(
      onTap: (){navigateTo(context, CaseSummary());},
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: const EdgeInsetsDirectional.all(2.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width*.60,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BAR-25-5-2000-05',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                horizontalDivider(height: 1.5,hColor: Colors.grey),
                const Text(
                  'Opened 25-5',
                  style: TextStyle(
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
                const Text(
                  'Civil',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: const [
                    Spacer(),
                    Text(
                      'In Progress',
                      style: TextStyle(
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

}
