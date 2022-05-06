import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/profile_components.dart';
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

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        dateController.text = DateFormat.yMMMd().format(DateTime.now().add(const Duration(days: 1)));
        return Scaffold(
          appBar: NewGradientAppBar(
            centerTitle: true,
            title: Text(
              'Add New Task',
              style: TextStyle(
                fontFamily: 'Nedian',
                fontSize: 20.0,
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
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: tasksFormKey,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  const Text('TASK NAME',style: TextStyle( fontSize: 15,color: Colors.grey) ),
                  profileFormField(
                    controller: taskNameController,
                    type: TextInputType.name,
                    validate: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'name is required';
                      }
                    },
                    hintText: 'Enter The Task Name',
                  ),
                  const SizedBox(height: 20,),
                  const Text('DATE',style: TextStyle( fontSize: 15,color: Colors.grey) ),
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
                        return dateController.text = DateFormat.yMMMd().format(value!);
                    });
                      },
                    validate: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'phone is required';
                      }
                    },
                    hintText: 'Enter The Task Date',
                    suffix: Icons.calendar_today_outlined,
                    suffixPressed: (){
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 90)),
                      ).then((value) => dateController.text = DateFormat.yMMMd().format(value!));
                    }
                  ),
                  const SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('START TIME',style: TextStyle( fontSize: 15,color: Colors.grey) ),
                      profileFormField(
                          controller: startTimeController,
                          hintText: 'Start Time',
                          validate: (value )
                          {
                            if(value!.isEmpty)
                            {
                              return 'Start Time is empty';
                            }
                          },
                          type: TextInputType.datetime,
                          suffix: Icons.access_time_outlined,
                          readonly: true,
                          onTap: (){
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              startTimeController.text = value!.format(context).toString();
                            });
                          },
                          suffixPressed: (){
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              print(value!.format(context).toString());
                              startTimeController.text = (value.format(context).toString());
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
                        text: const TextSpan(
                            children: [
                              TextSpan(text: 'END TIME',
                                  style: TextStyle( fontSize: 15,color: Colors.grey)
                              ),
                              TextSpan(text: ' (Optional)',
                                  style: TextStyle( fontSize: 10,color: Colors.grey)
                              ),
                      ]),),
                      profileFormField(
                          controller: endTimeController,
                          hintText: 'End Time',
                          validate: (value ) {},
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
                  const Text('DESCRIPTION',style: TextStyle( fontSize: 15,color: Colors.grey) ,),
                  profileFormField(
                    controller: descriptionController,
                    type: TextInputType.text,
                    maxLines: 4,
                    validate: (value) {},
                    hintText: 'Enter The Task Description',
                  ),
                ],
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
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
                                title: 'Discard Changes',
                                content: 'Are you sure you want to discard the changes?',
                                outlinedButtonText: 'No',
                                elevatedButtonText: 'Yes',
                              )
                          );
                          if (shouldPop == true)
                          {pop(context);}
                        }
                      }
                    },
                    child: Text('CANCEL',style: TextStyle(fontSize: 18),)
                ),
                verticalDivider(height: 25,vColor: gold),
                TextButton(
                    onPressed: (){
                      if(tasksFormKey.currentState!.validate()) {
                        // AvocadoCubit.get(context).addNewTask(
                        //     title: taskNameController.text,
                        //   date: dateController.text,
                        //   startTime: startTimeController.text,
                        //   endTime: endTimeController.text,
                        //   description: descriptionController.text
                        // );
                      }
                    },
                    child: Text('SAVE',style: TextStyle(fontSize: 18),)
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
