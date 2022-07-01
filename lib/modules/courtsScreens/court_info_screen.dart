import 'package:avocado/models/court_model.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/views/info_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../translation/locale_keys.g.dart';

class CourtInfoScreen extends StatelessWidget {
  CourtData courtData;
  CourtInfoScreen(this.courtData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          LocaleKeys.courts.tr(),
          style: TextStyle(
            fontFamily: 'Nedian',
            fontSize: 25.0,
            color: gold,
          ),
        ),
      ),
      body: Column(
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
                    courtData.name![0].toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 50),
                  ),
                ),            ],
            ),
          ),
          const SizedBox(height: 10,),
          Text('${courtData.name}',style: const TextStyle(fontSize: 23),),
          Text('${courtData.phone}',style: const TextStyle(color: Colors.grey,letterSpacing: 2)),
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
                      launchUrlString('tel:${'${courtData.phone}'}');
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: Icon(Icons.message,color: gold,),
                    onPressed: (){
                      launchUrlString('sms:${courtData.phone}');
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: Icon(Icons.location_on_rounded,color: gold,),
                    onPressed: (){
                      if(courtData.longitude != null && courtData.latitude != null) {
                        openMap(longitude: courtData.longitude,latitude:  courtData.latitude);
                      }
                      else{
                        showToast(context: context, msg: LocaleKeys.coordinatesNotAvailable.tr(),);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          InfoCard(title: LocaleKeys.address.tr(), body: courtData.address??LocaleKeys.notFound.tr()),
        ],
      ),
    );
  }
}
