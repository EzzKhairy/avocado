import 'package:avocado/Layout/app_layout.dart';
import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/profile_components.dart';
import 'package:avocado/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../localNotificationManager.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  var taskNameController = TextEditingController();

  var descriptionController = TextEditingController();

  var dateController = TextEditingController();

  var startTimeController = TextEditingController();

  var endTimeController = TextEditingController();

  var tasksFormKey  = GlobalKey<FormState>();

  final dateFormat = DateFormat('yyyy-MM-dd');
  final timeFormat = TimeOfDayFormat.H_colon_mm;

  DateTime taskDate = DateTime.now();
  DateTime taskTime =  DateTime.now();
  var myTime =  '';


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        dateController.text =DateFormat.yMMMMd().format(DateTime.now().add(const Duration(days: 1))) ;
        return BlocConsumer<AvocadoCubit,AvocadoStates>(
            listener: (context, state){
              if(state is AddNewTaskSuccessful)
              {
                if(state.model.status == 'true')
                {
                  print('asasasasa' '${state.model.message}');
                  AvocadoCubit.get(context).getTodayTasks(DateTime.now().toString().split(' ').elementAt(0));
                  showToast(context: context, msg: state.model.message);
                  navigateAndKill(context,  AppLayout(index: 1,));
                }
              }
              if(state is AddNewTaskError)
              {
                showToast(context: context, msg: state.model.message);
              }
            },
          builder: (context,state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  LocaleKeys.addNewTask.tr(),
                  style: TextStyle(
                    fontFamily: 'Nedian',
                    fontSize: 20.0,
                    color: gold,
                  ),
                ),
                backgroundColor: Colors.black,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: tasksFormKey,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        Text(LocaleKeys.taskName.tr().toUpperCase(),style: const TextStyle( fontSize: 15,color: Colors.grey) ),
                        profileFormField(
                          controller: taskNameController,
                          type: TextInputType.name,
                          hintText:LocaleKeys.EnterTaskName.tr(),
                        ),
                        const SizedBox(height: 20,),
                        Text(LocaleKeys.date.tr(),style: const TextStyle( fontSize: 15,color: Colors.grey) ),
                        profileFormField(
                            controller: dateController,
                            type: TextInputType.phone,
                            readonly: true,
                            onTap: (){
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 90)),
                              ).then((value) {
                                print(value.toString());
                                taskDate = DateTime.parse(dateFormat.format(value!).split(' ').elementAt(0));
                                print(taskDate.toString());
                                return dateController.text = DateFormat.yMMMMd().format(value);
                              });
                            },
                            suffix: Icons.calendar_today_outlined,
                            suffixPressed: (){
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 90)),
                              ).then((value) {
                                taskDate = DateTime.parse(dateFormat.format(value!).split(' ').elementAt(0));
                                print(taskDate.toString());
                                return dateController.text = DateFormat.yMMMMd().format(value);
                              }
                              );
                            }
                        ),
                        const SizedBox(height: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.startTime.tr().toUpperCase(),style: const TextStyle( fontSize: 15,color: Colors.grey) ),
                            profileFormField(
                                controller: startTimeController,
                                hintText: LocaleKeys.startTime.tr(),
                                type: TextInputType.datetime,
                                suffix: Icons.access_time_outlined,
                                onTap: (){
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    DateTime date = DateFormat.jm().parse(value!.format(context).toString());
                                    print( ' Formated ' +  date.toString());
                                    myTime = DateFormat("HH:mm").format(date);
                                    taskDate = DateTime.parse(taskDate.toString().split(' ').elementAt(0)+ ' ' + myTime);
                                    startTimeController.text = value.format(context).toString();
                                    startTimeController.text.contains('PM') ? taskDate.hour + 12 : debugPrint('AM');
                                    print(myTime);
                                    print(taskDate);
                                  });
                                },
                                suffixPressed: (){
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    DateTime date = DateFormat.jm().parse(value!.format(context).toString());
                                    print(date.toString());
                                    // date.toString().contains('PM') ? date.add(Duration(hours: 12)) : date.
                                    myTime = DateFormat("HH:mm").format(date);
                                    taskDate = DateTime.parse(taskDate.toString().split(' ').elementAt(0)+ ' ' + myTime);
                                    startTimeController.text = (value.format(context).toString());
                                    print(myTime);
                                    print(taskDate);
                                  });
                                }
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text:  TextSpan(
                                  children: [
                                    TextSpan(text: LocaleKeys.endTime.tr().toUpperCase(),
                                        style: const TextStyle( fontSize: 15,color: Colors.grey)
                                    ),
                                    TextSpan(text: LocaleKeys.optional.tr(),
                                        style: const TextStyle( fontSize: 10,color: Colors.grey)
                                    ),
                                  ]),),
                            profileFormField(
                                controller: endTimeController,
                                hintText: LocaleKeys.endTime.tr(),
                                type: TextInputType.text,
                                readonly: true,
                                validate: (value){return null;},
                                onTap: (){
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    endTimeController.text = value!.format(context).toString();
                                  });
                                },
                                suffix: Icons.access_time_outlined,
                                suffixPressed: (){
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    endTimeController.text = value!.format(context).toString();
                                  });
                                }
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Text(LocaleKeys.description.tr().toUpperCase(),style: const TextStyle( fontSize: 15,color: Colors.grey) ,),
                        profileFormField(
                          validate: (value){return null;},
                          controller: descriptionController,
                          type: TextInputType.text,
                          maxLines: 4,
                          hintText: LocaleKeys.EnterTaskDescription.tr(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomSheet: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient:LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.842),
                          Colors.black.withOpacity(0.845),
                          Colors.black.withOpacity(0.89),
                        ],
                        begin: AlignmentDirectional.topEnd,
                        end: AlignmentDirectional.bottomStart,
                        stops: const [0.20,0.17,0.40]
                    ),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () async {
                            if(tasksFormKey.currentState!.validate())
                            {
                              if(AvocadoCubit.get(context).isChanged)
                              {
                                final shouldPop = await showDialog(
                                    context: context,
                                    builder:
                                        (context) => baseAlertDialog(
                                      context: context,
                                      title:LocaleKeys.discardChanges.tr(),
                                      content: LocaleKeys.sureDiscardChanges.tr(),
                                      outlinedButtonText: LocaleKeys.no.tr(),
                                      elevatedButtonText: LocaleKeys.yes.tr(),
                                    )
                                );
                                if (shouldPop == true)
                                {pop(context);}
                              }
                            }
                          },
                          child:  Text(LocaleKeys.cancel.tr(),style: const TextStyle(fontSize: 18))
                      ),
                    ),
                    verticalDivider(height: 25,vColor: gold),
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            if(tasksFormKey.currentState!.validate()) {
                              AvocadoCubit.get(context).addNewTask(
                                  title: taskNameController.text,
                                  date: dateController.text,
                                  startTime: startTimeController.text,
                                  endTime: endTimeController.text,
                                  description: descriptionController.text
                              );
                              print(DateTime.now().timeZoneName);
                              ScheduleNotification(
                                taskDate: taskDate,
                                hour:  int.parse(myTime.split(':').elementAt(0)),
                                minutes: int.parse(myTime.split(':').elementAt(1)),
                                isPm: startTimeController.text.contains('PM') ? true : false,
                                body: descriptionController.text,
                                title: taskNameController.text,
                              );
                            }
                          },
                          child: Text(LocaleKeys.save.tr(),style: const TextStyle(fontSize: 18),)
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}
