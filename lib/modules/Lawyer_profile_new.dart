import 'package:avocado/models/clients_model.dart';
import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/modules/clientScreens/edit_client_info_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/views/info_card.dart';
import 'package:avocado/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../cubit/avocado_cubit.dart';

class LawyerProfileScreen extends StatelessWidget {
  LawyerProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LawyerData? lawyersModel = AvocadoCubit.get(context).lawyerData!.data![0];
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Align(
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(60))
                      ),
                    ),
                    alignment: AlignmentDirectional.topCenter,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: grey,
                    backgroundImage: NetworkImage('${lawyersModel.profilePhotoPath}'),
                  ),],
              ),
            ),
            const SizedBox(height: 10,),
            Text('${lawyersModel.name}',style: const TextStyle(fontSize: 23),),
            Text('${lawyersModel.email}',style: const TextStyle(color: Colors.grey,letterSpacing: 2)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit,color: gold,),
                    SizedBox(width: 10,),
                    Text('Edit Profile',style: TextStyle(color: gold,fontSize: 20,letterSpacing: 1.5),),
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                ), onPressed: () {  },
              )
            ),
            InfoCard(title: LocaleKeys.EmailAddress.tr(), body: '${lawyersModel.email}'),
            InfoCard(title: LocaleKeys.phoneNumber.tr(), body: '${lawyersModel.phone}'),
            InfoCard(title: LocaleKeys.address.tr(), body: '${lawyersModel.address}'),
            InfoCard(title: LocaleKeys.nationalId.tr(), body: '${lawyersModel.lawyerNationalNumber}'),
            Row(
              children: [
                Expanded(
                  child: InfoCard(
                    title: LocaleKeys.dateOfBirth.tr(),
                    body: '${lawyersModel.dateOfBirth}',
                  ),
                ),
                Expanded(
                  child: InfoCard(
                    title: LocaleKeys.gender.tr(),
                    body: '${lawyersModel.gender}',
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
