import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/clients_model.dart';
import 'package:avocado/modules/clients_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/profile_components.dart';
import 'package:avocado/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class AddClientScreen extends StatelessWidget {
  AddClientScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var nationalNumberController = TextEditingController();
  var clientFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
      listener: (context,state){
        if(state is AddNewClientSuccessful)
        {
          if(state.model.status == 'true')
          {
            print('asasasasa' '${state.model.message}');
            AvocadoCubit.get(context).getClients();
            showToast(context: context, msg: state.model.message);
            navigateAndKill(context, const ClientsScreen());
          }
        }
        if(state is AddNewClientError)
        {
          showToast(context: context, msg: state.model.message);
        }
      },
      builder: (context,state) {
        return Scaffold(
          appBar: NewGradientAppBar(
            centerTitle: true,
            title: Text(
              'ADD CLIENT',
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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      color: Colors.grey.shade200,
                      margin: const EdgeInsets.all(8.0),
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Row(
                              children: [
                                SizedBox(width: 5,),
                                Icon(Icons.person,size: 15,color: gold,),
                                SizedBox(width: 5,),
                                Text('Name',style: TextStyle(color: Colors.grey.shade500,)),
                              ],
                            ),
                            profileFormField(
                                controller: nameController,
                                validate: (value){
                                  if(value!.isEmpty) {
                                    return LocaleKeys.ThisFieldMustBeFilled.tr();
                                  }
                                  else if(value.compareTo(nameController.text)!=0){
                                    AvocadoCubit.get(context).toggleIsChanged();
                                  }
                                },
                                type: TextInputType.text
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      color: Colors.grey.shade200,
                      margin: const EdgeInsets.all(8.0),
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Row(
                              children: [
                                SizedBox(width: 5,),
                                Icon(Icons.phone,size: 15,color: gold,),
                                SizedBox(width: 5,),
                                Text(LocaleKeys.phoneNumber.tr(),style: TextStyle(color: Colors.grey.shade500,)),
                              ],
                            ),
                            profileFormField(
                                controller: phoneController,
                                validate: (value){
                                  if(value!.isEmpty) {
                                    return LocaleKeys.ThisFieldMustBeFilled.tr();
                                  }
                                  else if(value.length != 11)
                                  {
                                    return 'The phone Number must be 11 digits';
                                  }
                                  else if(value.compareTo(phoneController.text)!=0){
                                    AvocadoCubit.get(context).toggleIsChanged();
                                  }
                                },
                                type: TextInputType.text
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      color: Colors.grey.shade200,
                      margin: const EdgeInsets.all(8.0),
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Row(
                              children: [
                                SizedBox(width: 5,),
                                Icon(Icons.email,size: 15,color: gold,),
                                SizedBox(width: 5,),
                                Text(LocaleKeys.EmailAddress.tr(),style: TextStyle(color: Colors.grey.shade500,)),
                              ],
                            ),
                            profileFormField(
                                controller: emailController,
                                validate: (value){
                                  if(value!.isEmpty) {
                                    return LocaleKeys.ThisFieldMustBeFilled.tr();
                                  }
                                  else if (value.contains('@') == false) {
                                    return 'Email Formula is incorrect';
                                  }
                                  else if(value.compareTo(emailController.text)!=0){
                                    AvocadoCubit.get(context).toggleIsChanged();
                                  }
                                },
                                type: TextInputType.text
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      color: Colors.grey.shade200,
                      margin: const EdgeInsets.all(8.0),
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Row(
                              children: [
                                SizedBox(width: 5,),
                                Icon(Icons.location_on,size: 15,color: gold,),
                                SizedBox(width: 5,),
                                Text(LocaleKeys.address.tr(),style: TextStyle(color: Colors.grey.shade500,)),
                              ],
                            ),
                            profileFormField(
                              controller: addressController,
                              validate: (value){
                                if(value!.isEmpty) {
                                  return LocaleKeys.ThisFieldMustBeFilled.tr();
                                }
                                else if(value.compareTo(addressController.text)!=0){
                                  AvocadoCubit.get(context).toggleIsChanged();
                                }
                              },
                              type: TextInputType.text,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      color: Colors.grey.shade200,
                      margin: const EdgeInsets.all(8.0),
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Row(
                              children: [
                                SizedBox(width: 5,),
                                Icon(Icons.phone,size: 15,color: gold,),
                                SizedBox(width: 5,),
                                Text('National Number',style: TextStyle(color: Colors.grey.shade500,)),
                              ],
                            ),
                            profileFormField(
                                controller: nationalNumberController,
                                validate: (value){
                                  if(value!.isEmpty) {
                                    return LocaleKeys.ThisFieldMustBeFilled.tr();
                                  }
                                  else if(value.length != 14)
                                  {
                                    return 'The National Number must be 14 digits';
                                  }
                                  else if(value.compareTo(phoneController.text)!=0){
                                    AvocadoCubit.get(context).toggleIsChanged();
                                  }
                                },
                                type: TextInputType.text
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60,)

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
                                title: 'Discard Changes',
                                content: 'Are you sure you want to discard the changes?',
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
                        AvocadoCubit.get(context).addNewClient(
                            lawyerID: lawyerId.toString(),
                            clientNationalNumber: nationalNumberController.text,
                            name: nameController.text,
                            email: emailController.text,
                            address: addressController.text,
                            phone: phoneController.text
                        );
                      }
                    },
                    child: Text(LocaleKeys.save.tr(),style: TextStyle(fontSize: 18),)
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
