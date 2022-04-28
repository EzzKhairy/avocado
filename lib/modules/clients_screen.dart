import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/clients_model.dart';
import 'package:avocado/modules/client_info_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
        listener: (context,state){},
        builder: (context,state) {
          List<ClientsData>? clientData = AvocadoCubit.get(context).clientsModel?.clientsData;
          return Scaffold(
          appBar: NewGradientAppBar(
            centerTitle: true,
            title: Text(
              'Clients',
              style: TextStyle(
                fontFamily: 'Nedian',
                fontSize: 25.0,
                color: gold,
              ),
            ),
            gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.842),
                  Colors.black.withOpacity(0.845),
                  Colors.black.withOpacity(0.89),
                ],
                begin: AlignmentDirectional.topEnd,
                end: AlignmentDirectional.bottomStart,
                stops: const [0.20, 0.17, 0.40]),
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
          ));
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
                  Text('${clientsData.phone}')
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: (){
                  launchUrlString('tel:${clientsData.phone}');
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
