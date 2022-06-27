import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/profile_components.dart';
import 'package:avocado/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  var taskNameController = TextEditingController();

  var descriptionController = TextEditingController();

  var dateController = TextEditingController();

  var startTimeController = TextEditingController();

  var endTimeController = TextEditingController();

  var tasksFormKey  = GlobalKey<FormState>();

  final dateFormat = DateFormat('yyyy-MM-dd');
  final timeFormat = DateFormat('hh:mm');
  final dateTimeFormat = DateFormat('yyyy-MM-dd hh:mm:ss');

  DateTime taskDate = DateTime.now();
  DateTime taskTime =  DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        dateController.text = DateFormat.yMMMMd().format(DateTime.now().add(const Duration(days: 1)));
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
                          taskDate = DateTime.parse(dateFormat.format(value!));
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
                          taskDate = DateTime.parse(dateFormat.format(value!));
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
                                return startTimeController.text = value!.format(context).toString();
                              });
                            },
                            suffixPressed: (){
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                print(value!.format(context).toString());
                                return startTimeController.text = (value.format(context).toString());
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
                      controller: descriptionController,
                      type: TextInputType.text,
                      maxLines: 4,
                      hintText: LocaleKeys.EnterTaskDescrepsion.tr(),
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
                            startTime: startTimeController.text.split(' ').elementAt(0),
                            endTime: endTimeController.text.split(' ').elementAt(0),
                            description: descriptionController.text
                          );
                          AvocadoCubit.get(context).ScheduleNotification(
                              taskDate: taskDate,
                              body: descriptionController.text,
                              title: taskNameController.text
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
      }
    );
  }
}
