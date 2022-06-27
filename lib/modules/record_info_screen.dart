import 'dart:async';

import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/case_model.dart';
import 'package:avocado/models/records_model.dart';
import 'package:avocado/models/session_model.dart';
import 'package:avocado/modules/expert_session_screen.dart';
import 'package:avocado/modules/session_info_screen.dart';
import 'package:avocado/modules/sessions_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'dart:math' as math;

import '../translation/locale_keys.g.dart';


class RecordInfoScreen extends StatelessWidget {
  RecordsData recordsData;
  RecordInfoScreen(this.recordsData,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
          String? lawyerName;
          AvocadoCubit.get(context).getLawyerById(recordsData.lawyerId);
        return BlocConsumer<AvocadoCubit, AvocadoStates>(
          listener: (context, state) {},
          builder: (context, state) {
           lawyerName = AvocadoCubit.get(context).getLawyerModel?.data![0].name ?? 'Not Found';
            return Conditional.single(
                context: context,
                conditionBuilder: (context) => state is GetLawyerProfileSuccessful || state is GetRecordsDataSuccessful,
                widgetBuilder:(context) => Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: Text(
                        LocaleKeys.records.tr(),
                        style: TextStyle(
                          fontFamily: 'Nedian',
                          fontSize: 20.0,
                          color: gold,
                        ),
                      ),
                      backgroundColor: Colors.black,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Record: ''${recordsData.recordId?.toUpperCase()}',
                                    style: const TextStyle(
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            buildRecordInfoScreenItem(
                                context: context,
                                title: 'Topic',
                                info: '${recordsData.topic}'),
                            const SizedBox(
                              height: 10,
                            ),
                            buildRecordInfoScreenItem(
                                context: context, title: 'Client', info: '${recordsData.clientName}'),
                            const SizedBox(
                              height: 10,
                            ),
                            buildRecordInfoScreenItem(
                                context: context, title: 'Lawyer', info: '${lawyerName}'),
                            const SizedBox(
                              height: 10,
                            ),
                            buildRecordInfoScreenItem(
                                context: context, title: 'Contender', info: '${recordsData.contender}'),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black),
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Note'.toUpperCase(),
                                      style: TextStyle(
                                        color: gold,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text('${recordsData.note}')
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: (){},
                                  child: Text(LocaleKeys.attachments.tr(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,letterSpacing: 2)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
                fallbackBuilder: (context) => scaleProgressIndicator(context)
            );
          },
        );
      }
    );
  }

  Widget buildSessionItem(SessionData? sessionData,context)=> GestureDetector(
    onTap: (){navigateTo(context, SessionInfoScreen(sessionData));},
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsetsDirectional.all(2.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 160,
        width: MediaQuery.of(context).size.width*75/100,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Role.No ${sessionData?.roleNumber}'.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 3,
                ),
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(vertical: 5.0),
                child: horizontalDivider(height: 1.5,hColor: Colors.grey),
              ),
              Text(
                'Opened ${sessionData?.createdAt}'.split('T').elementAt(0),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                '${sessionData?.presentLawyerName}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                '${sessionData?.sessionReason}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${sessionData?.sessionDate}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${sessionData?.nextDate}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );


  Widget buildRecordInfoScreenItem({
    required context,
    required String? title,
    required String? info,
    bool extras = false,
    num? animationValue
  }) =>
      Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          margin: const EdgeInsetsDirectional.all(2.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$title',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$info',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if(extras)
                    Transform.rotate(
                      child: const Icon(Icons.arrow_forward_ios_outlined),
                      angle: math.pi * animationValue! / 2,
                  ),
                ],
              ),
            ),
          ));

  Widget innerWidget(context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black),
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: TextStyle(
                  color: gold,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                    " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
                    ", when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );

  Widget frontWidget(context) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsetsDirectional.all(2.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            child: Text(
              'Description',
              style: TextStyle(
                color: gold,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ));
}
