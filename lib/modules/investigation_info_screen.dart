import 'dart:async';

import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/case_model.dart';
import 'package:avocado/models/investegation_model.dart';
import 'package:avocado/models/records_model.dart';
import 'package:avocado/models/session_model.dart';
import 'package:avocado/modules/expert_session_screen.dart';
import 'package:avocado/modules/session_info_screen.dart';
import 'package:avocado/modules/sessions_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'dart:math' as math;


class InvestigationInfoScreen extends StatelessWidget {
  InvestigationData investigationData;
  InvestigationInfoScreen(this.investigationData,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
          String? lawyerName;
          AvocadoCubit.get(context).getLawyerById(investigationData.lawyerId);
        return BlocConsumer<AvocadoCubit, AvocadoStates>(
          listener: (context, state) {},
          builder: (context, state) {
           lawyerName = AvocadoCubit.get(context).getLawyerModel?.data![0].name ?? 'Not Found';
            return Conditional.single(
                context: context,
                conditionBuilder: (context) => state is GetLawyerProfileSuccessful || state is GetInvestigationsDataSuccessful,
                widgetBuilder:(context) => Scaffold(
                    appBar: NewGradientAppBar(
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: (){
                            AvocadoCubit.get(context).resetSession();
                            lawyerName = '';
                            pop(context);
                          }
                      ),
                      centerTitle: true,
                      title: Text(
                        'Investigation Summary'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Nedian',
                          fontSize: 22.0,
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
                                    'Investigation: ''${investigationData.investigationId?.toUpperCase()}',
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
                                info: '${investigationData.topic}'),
                            const SizedBox(
                              height: 10,
                            ),
                            buildRecordInfoScreenItem(
                                context: context, title: 'Client', info: '${investigationData.client}'),
                            const SizedBox(
                              height: 10,
                            ),
                            buildRecordInfoScreenItem(
                                context: context, title: 'Lawyer', info: '${lawyerName}'),
                            const SizedBox(
                              height: 10,
                            ),
                            buildRecordInfoScreenItem(
                                context: context, title: 'Contender', info: '${investigationData.contender}'),
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
                                    Text('${investigationData.note}')
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // if(sessionModel!=null && sessionModel.sessionData!.isNotEmpty)
                            //     ExpansionWidget(
                            //   titleBuilder: (double animationValue, _,
                            //       bool isExpand, toogleFunction) {
                            //     return InkWell(
                            //       onTap: () => toogleFunction(animated: true),
                            //       child: buildCaseInfoScreenItem(
                            //           animationValue: animationValue,
                            //           extras: true,
                            //           context: context,
                            //           title: 'Sessions',
                            //           info:
                            //               '${sessionModel.sessionData!.length}'
                            //               ' Sessions included'),
                            //     );
                            //   },
                            //   content: SizedBox(
                            //     height: 180,
                            //     child: ListView.separated(
                            //         scrollDirection: Axis.horizontal,
                            //         itemBuilder: (context, index) {
                            //           return buildSessionItem(
                            //               sessionModel.sessionData![index],
                            //               context);
                            //         },
                            //         separatorBuilder: (context, index) =>
                            //             const SizedBox(
                            //               width: 10,
                            //             ),
                            //         itemCount:
                            //             sessionModel.sessionData!.length),
                            //   ),
                            // )
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: (){},
                                  child: Text('Attachments',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,letterSpacing: 2)),
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