import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/clients_model.dart';
import 'package:avocado/models/court_model.dart';
import 'package:avocado/modules/clientScreens/add_client_screen.dart';
import 'package:avocado/modules/clientScreens/client_info_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../translation/locale_keys.g.dart';
import 'court_info_screen.dart';

class CourtsScreen extends StatelessWidget {
  const CourtsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
      listener: (context,state){},
      builder: (context,state) {
        List<CourtData>? courtData = AvocadoCubit.get(context).getCourtModel?.courtData;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              LocaleKeys.courts.tr(),
              style: TextStyle(
                fontFamily: 'Nedian',
                fontSize: 20.0,
                color: gold,
              ),
            ),
            backgroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  searchBar(context: context),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index) {
                      if(index % 2 == 0) {
                        return clientBuilder(courtData![index],grey, Colors.black,context);
                      } else {
                        return clientBuilder(courtData![index],Colors.black, gold,context);
                      }
                    } ,
                    separatorBuilder: (context,index) =>const SizedBox(height: 10,),
                    itemCount: courtData!.length,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget clientBuilder(CourtData courtData,Color avatarColor, Color avatarTextColor,context) {
    return InkWell(
      onTap: (){
        navigateTo(context, CourtInfoScreen(courtData));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 70,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: avatarColor,
                child: Text(
                  courtData.name![0].toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: avatarTextColor,
                      fontSize: 22),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text('${courtData.name}'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${courtData.phone}')
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: (){
                  if(courtData.longitude != null && courtData.latitude != null) {
                    Location(courtData.longitude,courtData.latitude);
                  }
                  else{
                    showToast(context: context, msg: 'Coordinates are not available');
                  }
                },
                child: CircleAvatar(
                    backgroundColor: avatarColor,
                    child: Icon(
                      Icons.location_on_outlined,
                      color: avatarTextColor,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
