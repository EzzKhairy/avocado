import 'package:flutter/material.dart';

import '../../cubit/avocado_cubit.dart';
import '../../translation/locale_keys.g.dart';
import '../components.dart';
import '../constants.dart';

class SettingsCard extends StatelessWidget {
  Widget? goTo;
  String cardName;
  bool isLanguage;
  IconData cardIcon;

  SettingsCard({
    this.goTo,
    required this.cardName,
    required this.cardIcon,
    this.isLanguage = false,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        if(isLanguage == false) {
          navigateTo(context, goTo);
        }},
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Row(
          children:
          [
            Icon(cardIcon,color: gold,),
            separator(15, 0),
            Text( cardName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            const Spacer(),
            isLanguage?
            PopupMenuButton(
              onSelected: (value){
                if(value == 'Arabic') {
                  AvocadoCubit.get(context).changeLocalToAr(context);
                } else {
                  AvocadoCubit.get(context).changeLocalToEn(context);
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'Arabic',
                  child: Text('عربي',style: TextStyle(color: Colors.black),),),
                PopupMenuItem(
                  value: 'English',
                  child: Text('English',style: TextStyle(color: Colors.black)),),
              ],
              child: Row(
                children: [
                  const Text('English'),
                  separator(10,0),
                  const Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
            )
                : const Icon(Icons.arrow_forward_ios_rounded),
            separator(10,0),
          ],
        ),
      ),
    );
  }
}
