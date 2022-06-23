import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/clients_model.dart';
import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/modules/clientScreens/clients_screen.dart';
import 'package:avocado/modules/lawyerProfile/Lawyer_profile_new.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/profile_components.dart';
import 'package:avocado/shared/views/edit_Dropdown_card.dart';
import 'package:avocado/shared/views/edit_Info_card.dart';
import 'package:avocado/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class EditLawyerProfileScreen extends StatelessWidget {
  LawyerData lawyersModel;
  EditLawyerProfileScreen(this.lawyersModel,{Key? key}) : super(key: key);
   var nameController = TextEditingController();
   var emailController = TextEditingController();
   var addressController = TextEditingController();
   var phoneController = TextEditingController();
   var dateController = TextEditingController();
   var genderController = TextEditingController();
   var roleController = TextEditingController();
   var clientFormKey = GlobalKey<FormState>();

   @override
  Widget build(BuildContext context) {
    nameController.text = lawyersModel.name?? 'Not Found';
    emailController.text = lawyersModel.email?? 'Not Found';
    addressController.text = lawyersModel.address ?? 'Not Found';
    phoneController.text = lawyersModel.phone?? 'Not Found';
    dateController.text = lawyersModel.dateOfBirth?? 'Not Found';
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
        listener: (context,state){
          if(state is UpdateLawyerProfileSuccessful)
            {
              if(state.model.status == 'true')
                {
                  print('asasasasa' '${state.model.message}');
                  AvocadoCubit.get(context).getClients();
                  showToast(context: context, msg: state.model.message);
                  navigateAndKill(context,  LawyerProfileScreen());
                }
            }
          if(state is UpdateLawyerProfileError)
          {
              showToast(context: context, msg: state.model.message);
          }
        },
      builder: (context,state) {
          print(lawyersModel.id);
        return Scaffold(
        appBar: NewGradientAppBar(
          centerTitle: true,
          title: Text(
            LocaleKeys.editProfile.tr(),
            style: TextStyle(
              fontFamily: 'Nedian',
              fontSize: 25.0,
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
              stops: const [0.20,0.17,0.40]
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: clientFormKey,
            child: Column(
              children: [
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
                SizedBox(height: 20,),
                EditInfoCard(
                    controller: nameController,
                    prefix: Icons.person,
                    title: LocaleKeys.name.tr(),
                ),
                EditInfoCard(
                  controller: phoneController,
                  prefix: Icons.phone,
                  title: LocaleKeys.phoneNumber.tr(),
                ),

                EditInfoCard(
                  controller: emailController,
                  prefix: Icons.email,
                  title: LocaleKeys.EmailAddress.tr(),
                ),
                EditInfoCard(
                  controller: addressController,
                  prefix: Icons.location_on_rounded,
                  title: LocaleKeys.address.tr(),
                ),
                EditInfoCard(
                  controller: dateController,
                  prefix: Icons.calendar_today_outlined,
                  title: LocaleKeys.dateOfBirth.tr(),
                  suffix: Icons.calendar_today_outlined,
                  suffixPressed: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now().subtract(const Duration(days: 6574)),
                      firstDate: DateTime.parse('1920-01-01'),
                      lastDate: DateTime.now().subtract(const Duration(days: 6574)),
                  ).then((value) {
                    return dateController.text = DateFormat.yMMMMd().format(value!);
                  })
                ),
                Row(
                  children: [
                    Expanded(
                      child: EditDropdownCard(
                          value: '${lawyersModel.gender == null ? 'Not Found' : lawyersModel.gender}',
                          choice:  ['Male','Female'],
                          prefix: Icons.transgender,
                          title: 'Gender',
                        onChange: (value){
                            AvocadoCubit.get(context).changeGenderValue(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: EditDropdownCard(
                          value: '${lawyersModel.role == null ? 'Not Found' : lawyersModel.role}',
                          choice:  ['Admin','Lawyer'],
                          prefix: Icons.transgender,
                          title: 'Role',
                        onChange: (value){
                          AvocadoCubit.get(context).changeRoleValue(value);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60)
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
                    if(clientFormKey.currentState!.validate())
                    {
                      if(AvocadoCubit.get(context).isChanged)
                      {
                        final shouldPop = await showDialog(
                            context: context,
                            builder:
                                (context) => baseAlertDialog(
                              context: context,
                              title: LocaleKeys.discardChanges.tr(),
                              content: LocaleKeys.sureDiscardChanges.tr(),
                              outlinedButtonText: 'No',
                              elevatedButtonText: 'Yes',
                            )
                        );
                        if (shouldPop == true)
                        {pop(context);}
                      }
                      else
                        {
                          pop(context);
                        }
                    }
                  },
                  child: Text(LocaleKeys.cancel.tr(),style: TextStyle(fontSize: 18),)
              ),
              verticalDivider(height: 25,vColor: gold),
              TextButton(
                  onPressed: (){
                    if(clientFormKey.currentState!.validate()) {
                      AvocadoCubit.get(context).updateLawyerProfile(
                          lawyerID: lawyersModel.id,
                          lawyerNationalNumber: lawyersModel.lawyerNationalNumber,
                          name: nameController.text,
                          email: emailController.text,
                          address: addressController.text,
                          role: roleController.text,
                          phoneNumber: phoneController.text,
                          dateOfBirth: dateController.text,
                        gender: genderController.text,
                      );
                    }
                  },
                  child: Text(LocaleKeys.save.tr(),style: const TextStyle(fontSize: 18),)
              ),
            ],
          ),
        ),
      );
      },
    );
  }
}