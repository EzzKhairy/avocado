import 'package:avocado/models/clients_model.dart';
import 'package:avocado/modules/clientScreens/edit_client_info_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/views/info_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../translation/locale_keys.g.dart';

class ClientInfoScreen extends StatelessWidget {
  ClientsData clientsData;
  ClientInfoScreen(this.clientsData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.clients.tr(),
          style: TextStyle(
            fontFamily: 'Nedian',
            fontSize: 25.0,
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
                    clientsData.name![0].toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 50),
                  ),
                ),            ],
            ),
          ),
          const SizedBox(height: 10,),
          Text('${clientsData.name}',style: const TextStyle(fontSize: 23),),
          Text('${clientsData.phone}',style: const TextStyle(color: Colors.grey,letterSpacing: 2)),
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
                    onPressed: ()async{
                      await canLaunchUrlString('tel:${clientsData.phone}')
                          ? launchUrlString('tel:${clientsData.phone}')
                          : showToast(context: context, msg: LocaleKeys.errorhappened.tr());
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: Icon(Icons.message,color: gold,),
                    onPressed: ()async{
                      await canLaunchUrlString('sms:${clientsData.phone}')
                          ? launchUrlString('sms:${clientsData.phone}')
                          : showToast(context: context, msg: LocaleKeys.errorhappened.tr());
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: Icon(Icons.edit,color: gold,),
                    onPressed: (){
                      navigateTo(context, EditClientInfoScreen(clientsData));
                    },
                  ),
                ),
              ],
            ),
          ),
          InfoCard(title: LocaleKeys.EmailAddress.tr(), body: '${clientsData.email}'),
          InfoCard(title: LocaleKeys.address.tr(), body: '${clientsData.address}'),
          InfoCard(title: LocaleKeys.nationalNumber.tr(), body: '${clientsData.clientNationalNumber}')
        ],
      ),
    );
  }
}
