import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/modules/lawyer_cases_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../translation/locale_keys.g.dart';

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
      body: Column(
        children: [
          Container(
            height: 250,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Align(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.842),
                          Colors.black.withOpacity(0.845),
                          Colors.black.withOpacity(0.89),
                        ],
                        begin: AlignmentDirectional.topEnd,
                        end: AlignmentDirectional.bottomStart,
                        stops: const [0.20, 0.17, 0.40]),
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(60))
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
          Text('${lawyerData.phone}',style: const TextStyle(color: Colors.grey,letterSpacing: 2),),
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
              ],
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
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text('Email',style: TextStyle(color: Colors.grey.shade500)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('${lawyerData.email}',style: TextStyle(fontSize: 18))
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
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text('Address',style: TextStyle(color: Colors.grey.shade500,
                    )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('${lawyerData.address}'!= null? '${lawyerData.address}': 'Not Found',style: TextStyle(fontSize: 18))
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
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text('National Number',style: TextStyle(color: Colors.grey.shade500,
                    )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('${lawyerData.lawyerNationalNumber != null ? lawyerData.lawyerNationalNumber : 'Not Found'}',style: TextStyle(fontSize: 18))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()
                {
                  navigateTo(context, LawyerCasesScreen(lawyerData.id));
                },
                child: Text('Cases of ${lawyerData.name?.split(' ').elementAt(0)}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,letterSpacing: 2)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
