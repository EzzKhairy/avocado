import 'package:avocado/modules/clients_screen.dart';
import 'package:avocado/modules/profile_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Ahlan Ahmed ',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                      SizedBox(height: 5,),
                      Text('Ahmed_Mohamed@gmail.com'),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text('MY ACCOUNT',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                InkWell(
                  onTap: (){
                    //navigateTo(context, FavoritesScreen());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                        Icon(Icons.favorite_border_rounded,color: gold,),
                        separator(15, 0),
                        const Text('Favorites',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                horizontalDivider(),
                InkWell(
                  onTap: (){
                    navigateTo(context, const ClientsScreen());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                         Icon(Icons.group_outlined,color: gold,),
                        separator(15, 0),
                        const Text('Clients',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                horizontalDivider(),
                InkWell(
                  onTap: (){
                    navigateTo(context, ProfileScreen());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                         Icon(Icons.person_outline,color: gold,),
                        separator(15, 0),
                        const Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                horizontalDivider(),
                Container(
                    padding:const EdgeInsets.all(15),
                    child: const Text('SETTINGS',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                InkWell(
                  onTap: (){},
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                         Icon(Icons.dark_mode_outlined,color: gold,),
                        separator(15, 0),
                        const Text('Dark Mode',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        const Spacer(),
                        // Switch(
                        //   value: value ,
                        //   onChanged: (newValue){
                        //     setState(() {
                        //       value = newValue;
                        //     });
                        //
                        //   },


                       // ),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                horizontalDivider(),
                InkWell(
                  onTap: (){},
                  child: Container(
                    color: Colors.white,
                    padding:const EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                         Icon(Icons.map_outlined,color: gold,),
                        separator(15, 0),
                        const Text('Country',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        const Spacer(),
                        const Text('Egypt'),
                        separator(10,0),
                        const Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                horizontalDivider(),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.white,
                    child: Row(
                      children:
                      [
                         Icon(Icons.flag_outlined,color: gold,),
                        separator(15, 0),
                        const Text('Language',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        const Spacer(),
                        const Text('English'),
                        separator(10,0),
                        const Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text('REACH OUT TO US',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                InkWell(
                  onTap: (){
                    // ShopCubit.get(context).getFAQsData();
                    // navigateTo(context, FAQsScreen());
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children:
                      [
                         Icon(Icons.info_outline_rounded,color: gold,),
                        separator(15, 0),
                        const Text('FAQs',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                horizontalDivider(),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.white,
                    child: Row(
                      children:
                      [
                         Icon(Icons.phone_in_talk_outlined,color: gold,),
                        separator(15, 0),
                        const Text('Contact Us',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios_rounded),
                        separator(10,0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  height: 60,
                  child: InkWell(
                    onTap: (){
                      signOut(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      const [
                        Icon(Icons.power_settings_new),
                        SizedBox(width: 10,),
                        Text('SignOut',style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
