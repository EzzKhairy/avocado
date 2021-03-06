import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/clients_model.dart';
import 'package:avocado/modules/clientScreens/add_client_screen.dart';
import 'package:avocado/modules/clientScreens/client_info_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../translation/locale_keys.g.dart';

class ClientsScreen extends StatelessWidget {
   ClientsScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
        listener: (context,state){},
        builder: (context,state) {
          List<ClientsData>? clientData = AvocadoCubit.get(context).clientsModel?.clientsData;
          List<ClientsData>? searchClientData = AvocadoCubit.get(context).searchClientsModel?.clientsData ?? [];
          return Scaffold(
          appBar:AppBar(
            centerTitle: true,
            title: Text(
              LocaleKeys.clients.tr(),
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
                  searchBar(
                    controller: searchController,
                    hint: LocaleKeys.searchClients.tr(),
                    onChange: (value){
                      if(value.isNotEmpty) {
                      AvocadoCubit.get(context).searchClients(value);
                    }
                      else{
                        AvocadoCubit.get(context).getClients();
                      }
                  }
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  searchClientData.isNotEmpty ?
                    ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index) {
                      if(index % 2 == 0) {
                        return clientBuilder(searchClientData[index],grey, Colors.black,context);
                      } else {
                        return clientBuilder(searchClientData[index],Colors.black, gold,context);
                      }
                    } ,
                    separatorBuilder: (context,index) =>const SizedBox(height: 10,),
                    itemCount: searchClientData.length,
                  ) : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index) {
                      if(index % 2 == 0) {
                        return clientBuilder(clientData![index],grey, Colors.black,context);
                      } else {
                        return clientBuilder(clientData![index],Colors.black, gold,context);
                      }
                    } ,
                    separatorBuilder: (context,index) =>const SizedBox(height: 10,),
                    itemCount: clientData!.length,
                  )
                ],
              ),
            ),
          ),
            floatingActionButton: Padding(
              padding: EdgeInsetsDirectional.only(end: 10,bottom: 10),
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                splashColor: Colors.blue,
                onPressed: (){
                  navigateTo(context, AddClientScreen());
                },
                child: Icon(Icons.add,color: gold,size: 35,),
              ),
            ),
          );
        },
    );
  }

  Widget clientBuilder(ClientsData clientsData,Color avatarColor, Color avatarTextColor,context) {
    return InkWell(
      onTap: (){
        navigateTo(context, ClientInfoScreen(clientsData));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: avatarColor,
                child: Text(
                  clientsData.name![0].toUpperCase(),
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
                  Text('${clientsData.name}'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(clientsData.phone??LocaleKeys.notFound.tr())
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: ()async{
                   await canLaunchUrlString('tel:${clientsData.phone}')
                       ? launchUrlString('tel:${clientsData.phone}') 
                       : showToast(context: context, msg: LocaleKeys.errorhappened.tr());
                },
                child: CircleAvatar(
                    backgroundColor: avatarColor,
                    child: Icon(
                      Icons.phone_in_talk_outlined,
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
