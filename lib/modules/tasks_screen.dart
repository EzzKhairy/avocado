import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/tasks_model.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:hexcolor/hexcolor.dart';

import 'add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit, AvocadoStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                      AvocadoCubit.get(context).getTodayTasks(
                          date.toString().split(' ').elementAt(0));
                      if (kDebugMode) {
                        print(date.toString().split(' ').elementAt(0));
                      }
                    },
                    calendarEventSelectedColor: gold,
                    calendarEventColor: Colors.black,
                    leading: IconButton(
                      onPressed: () {
                        navigateTo(context, AddTaskScreen());
                      },
                      icon: Icon(
                        Icons.add,
                        color: gold,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Conditional.single(
                      context: context,
                      conditionBuilder: (context) => AvocadoCubit.get(context)
                          .getTasksModel!
                          .tasksData!
                          .isNotEmpty,
                      widgetBuilder: (context) => ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const SizedBox(height: 0,),
                          itemBuilder: (context, index) => tasks(
                              AvocadoCubit.get(context)
                                  .getTasksModel
                                  ?.tasksData![index]),
                          itemCount: AvocadoCubit.get(context)
                              .getTasksModel!
                              .tasksData!
                              .length),
                      fallbackBuilder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height- 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.toc,size: 80,color: Colors.grey.shade400,textDirection: Directionality.of(context)),
                            Text('No Tasks found \n for Today',style: TextStyle(color: Colors.grey.shade500),textAlign: TextAlign.center,)
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget tasks(TasksData? tasksData) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${tasksData?.startTime}',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          pole(),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5,
              margin: const EdgeInsetsDirectional.all(2.5),
              color: HexColor("ECECEC"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${tasksData?.title}'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('${tasksData?.description}'),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
