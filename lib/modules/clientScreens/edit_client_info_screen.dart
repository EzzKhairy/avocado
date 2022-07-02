import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/clients_model.dart';
import 'package:avocado/modules/clientScreens/clients_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/profile_components.dart';
import 'package:avocado/shared/views/edit_Info_card.dart';
import 'package:avocado/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditClientInfoScreen extends StatelessWidget {
  ClientsData clientsData;
   EditClientInfoScreen(this.clientsData,{Key? key}) : super(key: key);
   var nameController = TextEditingController();
   var emailController = TextEditingController();
   var addressController = TextEditingController();
   var phoneController = TextEditingController();
   var clientFormKey = GlobalKey<FormState>();

   @override
  Widget build(BuildContext context) {
    nameController.text = clientsData.name?? LocaleKeys.notFound.tr();
    emailController.text = clientsData.email?? LocaleKeys.notFound.tr();
    addressController.text = clientsData.address ?? LocaleKeys.notFound.tr();
    phoneController.text = clientsData.phone?? LocaleKeys.notFound.tr();
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
        listener: (context,state){
          if(state is UpdateClientProfileSuccessful)
            {
              if(state.model.status == 'true')
                {
                  print('asasasasa' '${state.model.message}');
                  AvocadoCubit.get(context).getClients();
                  showToast(context: context, msg: state.model.message);
                  pop(context);
                  pop(context);
                }
            }
          if(state is UpdateClientProfileError)
          {
              showToast(context: context, msg: state.model.message);
          }
        },
      builder: (context,state) {
          print(clientsData.id);
        return Scaffold(
        appBar:AppBar(
          centerTitle: true,
          title: Text(
            LocaleKeys.editClient.tr(),
            style: TextStyle(
              fontFamily: 'Nedian',
              fontSize: 25.0,
              color: gold,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: clientFormKey,
            child: Column(
              children: [
                EditInfoCard(
                    controller: nameController,
                    prefix: Icons.person,
                    title: LocaleKeys.name.tr()
                ),
                EditInfoCard(
                    controller: emailController,
                    prefix: Icons.email_outlined,
                    title: LocaleKeys.EmailAddress.tr()
                ),
                EditInfoCard(
                    controller: phoneController,
                    prefix: Icons.phone,
                    title: LocaleKeys.phoneNumber.tr()
                ),
                EditInfoCard(
                    controller: addressController,
                    prefix: Icons.location_on,
                    title: LocaleKeys.address.tr()
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
                              outlinedButtonText: LocaleKeys.no.tr(),
                              elevatedButtonText: LocaleKeys.yes.tr(),
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
                  child: Text(LocaleKeys.cancel.tr().toUpperCase(),style: TextStyle(fontSize: 18),)
              ),
              verticalDivider(height: 25,vColor: gold),
              TextButton(
                  onPressed: (){
                    if(clientFormKey.currentState!.validate()) {
                      AvocadoCubit.get(context).updateClientProfile(
                          clientsID: clientsData.id,
                          lawyerID: clientsData.lawyerId,
                          clientNationalNumber: clientsData.clientNationalNumber,
                          name: nameController.text,
                          email: emailController.text,
                          address: addressController.text,
                          phone: phoneController.text
                      );
                    }
                  },
                  child: Text(LocaleKeys.save.tr().toUpperCase(),style: TextStyle(fontSize: 18),)
              ),
            ],
          ),
        ),
      );
      },
    );
  }
}
