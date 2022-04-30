import 'package:avocado/models/clients_model.dart';
import 'package:avocado/models/court_model.dart';
import 'package:avocado/modules/edit_client_info_screen.dart';
import 'package:avocado/modules/edit_court_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
          'Clients',
          style: TextStyle(
            fontFamily: 'Nedian',
            fontSize: 25.0,
            color: gold,
          ),
        ),
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
                    icon: Icon(Icons.edit,color: gold,),
                    onPressed: (){
                      navigateTo(context, EditCourtInfoScreen(courtData));
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
                    Text('${courtData.address}',style: TextStyle(fontSize: 18))
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
                    Text('${courtData.address}',style: TextStyle(fontSize: 18))
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
                    Text('${courtData.address}',style: TextStyle(fontSize: 18))
                  ],
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
