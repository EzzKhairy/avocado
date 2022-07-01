import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/modules/lawyerScreens/lawyer_info_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../translation/locale_keys.g.dart';

class LawyersScreen extends StatelessWidget {
  LawyersScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
      listener: (context,state){},
      builder: (context,state) {
              List<LawyerData>? lawyerData = AvocadoCubit.get(context).getLawyers!.data;
              List<LawyerData>? searchLawyerData = AvocadoCubit.get(context).searchLawyersModel?.data ?? [];

              return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  LocaleKeys.totalLawyers.tr(),
                  style: TextStyle(
                    fontFamily: 'Nedian',
                    fontSize: 25.0,
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
                          controller:searchController ,
                          onChange: (value){
                            if(value.isNotEmpty) {
                              AvocadoCubit.get(context).searchLawyers(keyword: value);
                            }
                            else{
                              AvocadoCubit.get(context).getEveryLawyer();
                            }
                          }
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        searchLawyerData.isNotEmpty ?
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context,index) {
                            if(index % 2 == 0) {
                              return lawyerBuilder(searchLawyerData[index],grey, Colors.black,context);
                            } else {
                              return lawyerBuilder(searchLawyerData[index],Colors.black, gold,context);
                            }
                          },
                          separatorBuilder: (context,index) =>const SizedBox(height: 10,),
                          itemCount: lawyerData!.length,
                        ):
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context,index) {
                            if(index % 2 == 0) {
                              return lawyerBuilder(lawyerData![index],grey, Colors.black,context);
                            } else {
                              return lawyerBuilder(lawyerData![index],Colors.black, gold,context);
                            }
                          },
                          separatorBuilder: (context,index) =>const SizedBox(height: 10,),
                          itemCount: lawyerData!.length,
                        ),
                      ],
                    ),
                  ),
                ),
              );
           },
        );
      }
  }

  Widget lawyerBuilder(LawyerData lawyerData,Color avatarColor, Color avatarTextColor,context) {
    return InkWell(
      onTap: (){
        navigateTo(context, LawyerInfoScreen(lawyerData));
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
                  lawyerData.name![0].toUpperCase(),
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
                  Text('${lawyerData.name}'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${lawyerData.phone}'),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: (){
                  launchUrlString('tel:${lawyerData.phone}');
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
