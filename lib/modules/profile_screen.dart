import 'package:avocado/modules/change_password_screen.dart';
import 'package:avocado/shared/components.dart';
import '../shared/profile_components.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var dateController = TextEditingController();
  var genderController = TextEditingController();
  bool readOnly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*(1/4),
              // decoration: const BoxDecoration(color: Colors.white),
              child:
                Column(
                  children: [
                    const SizedBox(height: 30,),
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage('https://lh3.googleusercontent.com/JKdSC1LFESgmWr1fNa4aO8W8YGWNA4H18hwRh6iPup7c6ZJePM7T9equv_I3WL0JS0lcmw=s85',),
                    ),
                    const SizedBox(height: 15,),
                    const Text(
                      'Ahmed Mohamed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,

                      ),),
                    const SizedBox(height: 4,),
                    Text(
                      'Ahmed_Mohamed@gmail.com',
                      style: TextStyle(
                        fontSize: 15,
                        color: HexColor('ADADAD'),
                      ),),
                  ],
                ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*(0.40),
              decoration: BoxDecoration(color: HexColor('E4E4E4')),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'PERSONAL INFORMATION',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    profileFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'name is required';
                          }
                        },
                        label: 'Name',
                        prefix: Icons.person_outline,
                    ),
                    const SizedBox(height: 15,),
                    profileFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'phone is required';
                        }
                      },
                      label: 'Phone',
                      prefix: Icons.phone_outlined,
                    ),
                    const SizedBox(height: 35,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            child: profileFormField(
                              controller: dateController,
                              label: 'Date',
                              validate: (value )
                              {
                                if(value!.isEmpty)
                                {
                                  return 'date is empty';
                                }
                              },
                              type: TextInputType.datetime,
                              readOnly: readOnly,
                            ),
                          ),
                        ),
                        const SizedBox(width:35,),
                        Expanded(
                          child: Container(
                            child: profileFormField(
                              controller: genderController,
                              label: 'Gender',
                              validate: (value )
                              {
                                if(value!.isEmpty)
                                {
                                  return 'gender is empty';
                                }
                              },
                              type: TextInputType.text,
                              readOnly: readOnly,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 23,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: HexColor('E4E4E4')),
              height: 120,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SECURITY INFORMATION',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 25,),
                    profileButton(
                      text: 'Change Password',
                      width: 180,
                      function: (){navigateTo(context, ChangePasswordScreen());},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
