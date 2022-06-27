import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/modules/change_password_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/profile_components.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var dateController = TextEditingController();
  var genderController = TextEditingController();
  var profileFormKey = GlobalKey<FormState>();
  String? profilePhoto;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      LawyerData lawyersModel = AvocadoCubit.get(context).lawyerData!.data![0];
      nameController.text = lawyersModel.name!;
      phoneController.text = lawyersModel.phone ?? 'Not Found';
      return BlocConsumer<AvocadoCubit, AvocadoStates>(
        listener: (context, state) {
          if (state is UpdateLawyerProfileSuccessful) {
            showToast(
                context: context,
                msg: state.model.message,
                backgroundColor: Colors.green
            );
          } else if (state is UpdateLawyerProfileError) {
            showToast(
                context: context,
                msg: "Error >>> ${state.model.message}",
                backgroundColor: Colors.red);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * (0.25),
                    // decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            AvocadoCubit.get(context).pickImage(
                              lawyerID: lawyerId,
                              name: lawyersModel.name,
                              email: lawyersModel.email,
                              address: lawyersModel.address,
                              role: lawyersModel.role,
                              lawyerNationalNumber:
                                  lawyersModel.lawyerNationalNumber,
                            );
                          },
                          child: CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                                '${lawyersModel.profilePhotoPath ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZG3qkyaZZsnYyKv3-iTLyK_WT6QFmBQz3IQ&usqp=CAU'}'),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${lawyersModel.name}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${lawyersModel.email}',
                          style: TextStyle(
                            fontSize: 15,
                            color: HexColor('ADADAD'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: HexColor('E4E4E4')),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          if (state is UpdateLawyerProfileLoading)
                            Column(
                              children: const [
                                LinearProgressIndicator(),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              const Text(
                                'PERSONAL INFORMATION',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  if (profileFormKey.currentState!.validate()) {
                                    AvocadoCubit.get(context).editPressed(
                                      lawyerID: lawyerId,
                                      email: lawyersModel.email,
                                      lawyerNationalNumber:
                                          lawyersModel.lawyerNationalNumber,
                                      address: phoneController.text,
                                      name: nameController.text,
                                    );
                                  }
                                },
                                child: Text(AvocadoCubit.get(context).editText),
                              ),
                            ],
                          ),
                          Form(
                            key: profileFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                profileFormField(
                                  controller: nameController,
                                  type: TextInputType.name,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'name is required';
                                    }
                                  },
                                  label: 'Name',
                                  isEnabled: AvocadoCubit.get(context).isEdit
                                      ? true
                                      : false,
                                  prefix: Icons.person_outline,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                profileFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'phone is required';
                                    }
                                  },
                                  label: 'Phone',
                                  isEnabled: AvocadoCubit.get(context).isEdit
                                      ? true
                                      : false,
                                  prefix: Icons.phone_outlined,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: profileFormField(
                                            // controller: dateController,
                                            initialValue: "15-7-1986",
                                            label: 'Date',
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return 'date is empty';
                                              }
                                            },
                                            type: TextInputType.datetime,
                                            isEnabled:
                                                AvocadoCubit.get(context).isEdit
                                                    ? true
                                                    : false,
                                            prefix:
                                                Icons.calendar_today_outlined),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 35,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: profileFormField(
                                          //controller: genderController,
                                          initialValue: 'Male',
                                          label: 'Gender',
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'gender is empty';
                                            }
                                          },
                                          type: TextInputType.text,
                                          isEnabled:
                                              AvocadoCubit.get(context).isEdit
                                                  ? true
                                                  : false,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                    height: MediaQuery.of(context).size.height * (0.159),
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
                          const SizedBox(
                            height: 25,
                          ),
                          profileButton(
                            text: 'Change Password',
                            width: 180,
                            function: () {
                              navigateTo(context, ChangePasswordScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
