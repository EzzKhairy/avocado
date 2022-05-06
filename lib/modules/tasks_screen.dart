import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/tasks_model.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
        listener: (context,state){},
        builder: (context,state){
      return Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                CalendarAgenda(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 140)),
                  lastDate: DateTime.now().add(const Duration(days: 4)),
                  backgroundColor: Colors.white,
                  dateColor: Colors.black,
                  selectedDateColor: gold,
                  onDateSelected: (date) {
                    if (kDebugMode) {
                      print(date);
                    }},
                  calendarEventSelectedColor: gold,
                  calendarEventColor: Colors.black,
                  leading: IconButton(
                    onPressed: (){
                      navigateTo(context, AddTaskScreen());
                    },
                    icon:  Icon(Icons.add,color: gold,size: 30,),
                  ),
                ),
                const SizedBox(height: 15,),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index) => tasks(AvocadoCubit.get(context).tasksModel?.tasksData![index]),
                    itemCount: AvocadoCubit.get(context).tasksModel?.tasksData!.length
                )
              ],
            ),
          ),
        ),
      );
    },
    );
  }
  Widget taskBuilder (){
    return  Expanded(
      child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            margin: const EdgeInsetsDirectional.all(2.5),
            color: HexColor("ECECEC"),
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const[
                   Text('Case Number : 4'),
                   SizedBox(height: 5,),
                   Text('Office Lawyer : Ahmed Abdallah'),
                   SizedBox(height: 5,),
                    ],
                ),
              ),
            ),
      );
  }
  Widget tasks(TasksData? tasksData){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('10:00 Am',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
          const SizedBox(width: 10,),
          Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: const [
                  CircleAvatar(radius: 5,),
                  CircleAvatar(radius: 3.5,backgroundColor: Colors.white),
                ],
              ),
              verticalDivider(),
            ],
          ),
          const SizedBox(width: 10,),
          taskBuilder(),
        ],
      ),
    );
  }
}
