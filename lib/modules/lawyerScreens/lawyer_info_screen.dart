import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/modules/lawyerProfile/edit_Lawyer_Profile_screen.dart';
import 'package:avocado/modules/lawyerScreens/lawyer_cases_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/views/info_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../translation/locale_keys.g.dart';

class LawyerInfoScreen extends StatelessWidget {
  final LawyerData lawyerData;
  const LawyerInfoScreen(this.lawyerData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.totalLawyers.tr(),
          style: TextStyle(
            fontFamily: 'Nedian',
            fontSize: 20.0,
            color: gold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
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
                    child:Text(
                      lawyerData.name![0].toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 50),
                    ),
                  ),            ],
              ),
            ),
            const SizedBox(height: 10,),
            Text('${lawyerData.name}',style: const TextStyle(fontSize: 23),),
            Text(lawyerData.phone ?? LocaleKeys.notFound.tr(),style: const TextStyle(color: Colors.grey,letterSpacing: 2),),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: Icon(Icons.phone,color: gold,),
                      onPressed: (){
                        launchUrlString('tel:${'${lawyerData.phone}'}');
                      },
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: Icon(Icons.message,color: gold,),
                      onPressed: (){
                        launchUrlString('sms:${lawyerData.phone}');
                      },
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: Icon(Icons.edit,color: gold,),
                      onPressed: (){
                        navigateTo(context, EditLawyerProfileScreen(lawyerData));
                      },
                    ),
                  ),
                ],
              ),
            ),
            InfoCard(title: LocaleKeys.EmailAddress.tr(), body: '${lawyerData.email}'),
            InfoCard(title: LocaleKeys.address.tr(), body: '${lawyerData.address}'),
            InfoCard(title: LocaleKeys.nationalNumber.tr(), body: '${lawyerData.lawyerNationalNumber}'),
          ],
        ),
      ),
    );
  }
}
