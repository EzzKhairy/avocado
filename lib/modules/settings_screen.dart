import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/modules/casesScreen/cases_screen.dart';
import 'package:avocado/modules/clientScreens/clients_screen.dart';
import 'package:avocado/modules/courts_screen.dart';
import 'package:avocado/modules/profile_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/views/settings_card.dart';
import 'package:avocado/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'lawyer_cases_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text( LocaleKeys.ahlan.tr() + ' ' + AvocadoCubit.get(context).lawyerData!.data![0].name!.split(' ').elementAt(0),
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                      SizedBox(height: 5,),
                      Text('${AvocadoCubit.get(context).lawyerData!.data![0].email}',style: TextStyle(letterSpacing: 1.5),),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(15),
                    child:  Text(LocaleKeys.myAccount.tr().toUpperCase(),style: const TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),)),
                horizontalDivider(),
                SettingsCard(goTo: ClientsScreen(), cardName: LocaleKeys.clients.tr(),cardIcon: Icons.group,),
                horizontalDivider(),
                SettingsCard(goTo: ProfileScreen(), cardName: LocaleKeys.profile.tr(),cardIcon: Icons.person),
                horizontalDivider(),
                SettingsCard(goTo: CasesScreen(), cardName: LocaleKeys.totalCases.tr(),cardIcon: Icons.cases_sharp),
                horizontalDivider(),
                SettingsCard(goTo: const CourtsScreen(), cardName: LocaleKeys.courts.tr(),cardIcon: Icons.villa),
                horizontalDivider(),
                SettingsCard(goTo: const CourtsScreen(), cardName: LocaleKeys.legistilation.tr(),cardIcon: Icons.picture_as_pdf),
                horizontalDivider(),
                SettingsCard(goTo: const CourtsScreen(), cardName: LocaleKeys.models.tr(),cardIcon: Icons.topic_outlined),
                Container(
                    padding:const EdgeInsets.all(15),
                    child:  Text(LocaleKeys.Settings.tr(),style: const TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),)),
                InkWell(
                  onTap: (){},
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                         Icon(Icons.dark_mode_outlined,color: gold,),
                        separator(15, 0),
                         Text(LocaleKeys.darkMode.tr(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        const Spacer(),
                        // Switch(
                        //   value: value ,
                        //   onChanged: (newValue){
                        //     setState(() {
                        //       value = newValue;
                        //     });
                        //
                        //   },
                       // ),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                horizontalDivider(),
                SettingsCard(cardName: LocaleKeys.language.tr(),cardIcon: Icons.flag,isLanguage: true,),
                Container(
                    padding: const EdgeInsets.all(15),
                    child:  Text(LocaleKeys.reachUs.tr().toUpperCase(),style: const TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),)),
                InkWell(
                  onTap: (){
                    // ShopCubit.get(context).getFAQsData();
                    // navigateTo(context, FAQsScreen());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                         Icon(Icons.info_outline_rounded,color: gold,),
                        separator(15, 0),
                        const Text('FAQs',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                horizontalDivider(),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.white,
                    child: Row(
                      children:
                      [
                         Icon(Icons.phone_in_talk_outlined,color: gold,),
                        separator(15, 0),
                         Text(LocaleKeys.contactUs.tr(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  height: 60,
                  child: InkWell(
                    onTap: (){
                      signOut(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                       [
                        const Icon(Icons.power_settings_new),
                        const SizedBox(width: 10,),
                        Text(LocaleKeys.SignOut.tr(),style: const TextStyle(fontSize: 18),)
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
