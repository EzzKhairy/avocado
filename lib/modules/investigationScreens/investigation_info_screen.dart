import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/investegation_model.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../translation/locale_keys.g.dart';


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
           lawyerName = AvocadoCubit.get(context).getLawyerModel?.data![0].name ?? LocaleKeys.notFound.tr();
            return Conditional.single(
                context: context,
                conditionBuilder: (context) => state is GetLawyerProfileSuccessful || state is GetInvestigationsDataSuccessful,
                widgetBuilder:(context) => Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: Text(
                        LocaleKeys.investigation.tr(),
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
                                    '${investigationData.investigationId?.toUpperCase()}',
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
                                title: LocaleKeys.title.tr(),
                                info: '${investigationData.topic}'),
                            const SizedBox(
                              height: 10,
                            ),
                            buildRecordInfoScreenItem(
                                context: context, title: LocaleKeys.client.tr(), info: '${investigationData.client}'),
                            const SizedBox(
                              height: 10,
                            ),
                            buildRecordInfoScreenItem(
                                context: context, title: LocaleKeys.lawyer.tr(), info: '${lawyerName}'),
                            const SizedBox(
                              height: 10,
                            ),
                            buildRecordInfoScreenItem(
                                context: context, title: LocaleKeys.contender.tr(), info: '${investigationData.contender}'),
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
                                      LocaleKeys.note.tr().toUpperCase(),
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



  Widget buildRecordInfoScreenItem({
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


}
