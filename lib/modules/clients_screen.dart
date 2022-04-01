import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        return ClientBuilder(grey, Colors.black);
                      } else {
                        return ClientBuilder(Colors.black, gold);
                      }
                    } ,
                    separatorBuilder: (context,index) =>const SizedBox(height: 10,),
                    itemCount: 10
                )
              ],
            ),
          ),
        ));
  }

  Widget ClientBuilder(Color avatarColor, Color avatarTextColor) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: avatarColor,
              child: Text(
                'K',
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
              children: [
                Text('Kareem Salem'),
                SizedBox(
                  height: 5,
                ),
                Text('0000-000-0000')
              ],
            ),
            const Spacer(),
            CircleAvatar(
                backgroundColor: avatarColor,
                child: Icon(
                  Icons.phone_in_talk_outlined,
                  color: avatarTextColor,
                )),
          ],
        ),
      ),
    );
  }
}
