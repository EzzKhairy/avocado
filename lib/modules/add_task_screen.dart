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
                    readOnly: true,
                    onTap: (){
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 90)),
                    ).then((value) => dateController.text = DateFormat.yMMMd().format(value!));
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
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
                                    return 'date is empty';
                                  }
                                },
                                type: TextInputType.datetime,
                                suffix: Icons.access_time_outlined,
                                readOnly: true,
                                onTap: (){
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                },
                              suffixPressed: (){
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width:35,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('END TIME',style: TextStyle( fontSize: 15,color: Colors.grey) ),
                            profileFormField(
                              controller: endTimeController,
                              hintText: 'End Time',
                              validate: (value )
                              {
                                if(value!.isEmpty)
                                {
                                  return 'gender is empty';
                                }
                              },
                              type: TextInputType.text,
                                readOnly: true,
                                onTap: (){
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                },
                                suffix: Icons.access_time_outlined,
                                suffixPressed: (){
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const Text('DESCRIPTION',style: TextStyle( fontSize: 15,color: Colors.grey) ,),
                  profileFormField(
                    controller: descriptionController,
                    type: TextInputType.text,
                    maxLines: 4,
                    validate: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'name is required';
                      }
                    },
                    hintText: 'Enter The Task Description',
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
