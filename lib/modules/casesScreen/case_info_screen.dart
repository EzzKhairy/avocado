import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/case_model.dart';
import 'package:avocado/models/session_model.dart';
import 'package:avocado/modules/expert_session_screen.dart';
import 'package:avocado/modules/investigations_screen.dart';
import 'package:avocado/modules/payments_screen.dart';
import 'package:avocado/modules/records_screen.dart';
import 'package:avocado/modules/session_info_screen.dart';
import 'package:avocado/modules/sessions_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'dart:math' as math;

import '../../translation/locale_keys.g.dart';
import '../attachments_screen.dart';
import '../expenses_screen.dart';


class CaseInfoScreen extends StatelessWidget {
  CaseData caseData;
  CaseInfoScreen(this.caseData,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
          String? lawyerName;
          String? courtName;
          AvocadoCubit.get(context).getLawyerById(caseData.lawyerID);
          AvocadoCubit.get(context).getCourtById(caseData.courtNumber);
        return BlocConsumer<AvocadoCubit, AvocadoStates>(
          listener: (context, state) {},
          builder: (context, state) {
           lawyerName = AvocadoCubit.get(context).getLawyerModel?.data![0].name ?? 'Not Found';
           courtName = AvocadoCubit.get(context).getCourtByIdModel?.courtData![0].name ?? 'Not Found';
            return Conditional.single(
                context: context,
                conditionBuilder: (context) => state is GetLawyerProfileSuccessful || state is GetCourtDataSuccessful,
                widgetBuilder:(context) => Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: Text(
                        LocaleKeys.caseSummary.tr(),
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
                                  LocaleKeys.cases.tr()+ ': ' + '${caseData.caseID?.toUpperCase()}',
                                    style: const TextStyle(
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                         TextSpan(
                                            text: LocaleKeys.status.tr() + ': ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black)),
                                        caseData.status == 'open'?
                                        TextSpan(
                                            text: LocaleKeys.inProgress.tr(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.green)) :
                                        TextSpan(
                                            text: LocaleKeys.closed.tr(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.red)),
                                      ])),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            buildCaseInfoScreenItem(
                                context: context,
                                title: LocaleKeys.title.tr(),
                                info: '${caseData.title}'),
                            const SizedBox(
                              height: 10,
                            ),
                            buildCaseInfoScreenItem(
                                context: context, title: LocaleKeys.caseType.tr(), info: '${caseData.caseType}'),
                            const SizedBox(
                              height: 10,
                            ),
                            buildCaseInfoScreenItem(
                                context: context, title:LocaleKeys.courts.tr(), info: '${courtName}'),
                            const SizedBox(
                              height: 10,
                            ),
                            buildCaseInfoScreenItem(
                                context: context, title: LocaleKeys.lawyer.tr(), info: '${lawyerName}'),
                            const SizedBox(
                              height: 10,
                            ),
                            innerWidget(context),
                            const SizedBox(
                              height: 10,
                            ),

                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () async
                                  {
                                    print(caseData.attachments);
                                    if(caseData.attachments!.contains('pdf')) {
                                      navigateTo(context,  PDFViewerScreen(doc: '${caseData.attachments}'));
                                    }
                                    else{
                                      imagePreview(caseData.attachments);
                                    }
                                  },
                                  child: Text(LocaleKeys.attachments.tr(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,letterSpacing: 2)),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: (){
                                        navigateTo(context, SessionsScreen(caseData.id));
                                      },
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),

                                      child:  Text(LocaleKeys.sessions.tr(),style: const TextStyle(color: Colors.white))
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: (){
                                        navigateTo(context, ExpertSessionScreen(caseData.id));
                                      },
                                      child:  Text(LocaleKeys.e_session.tr())
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: (){
                                        navigateTo(context, RecordsScreen(caseData.id));
                                      },
                                      child:  Text(LocaleKeys.records.tr())
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: (){
                                        navigateTo(context, InvestigationsScreen(caseData.id));
                                      },
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),

                                      child:  Text(LocaleKeys.investigation.tr(),style: const TextStyle(color: Colors.white),)
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: (){
                                        navigateTo(context, ExpensesScreen(caseData.id));
                                      },
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                                      child: Text(LocaleKeys.expenses.tr(),style: const TextStyle(color: Colors.white),)
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: (){
                                        navigateTo(context, PaymentsScreen(caseData.id));
                                      },
                                      child: Text(LocaleKeys.expenses.tr())
                                  ),
                                ),
                              ],
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



  Widget buildCaseInfoScreenItem({
    required context,
    required String? title,
    required String? info,
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
                ],
              ),
            ),
          ));

  Widget innerWidget(context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.description.tr(),
                style: TextStyle(
                  color: gold,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${caseData.content}',
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
