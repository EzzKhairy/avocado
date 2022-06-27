import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/case_model.dart';
import 'package:avocado/modules/casesScreen/case_info_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../translation/locale_keys.g.dart';

class LawyerCasesScreen extends StatelessWidget {
  final int? lawyerId;
  const LawyerCasesScreen(this.lawyerId,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AvocadoCubit.get(context).getCasesByLawyerId(lawyerId: lawyerId);
        return BlocConsumer<AvocadoCubit, AvocadoStates>(
          listener: (context, state) {},
          builder: (context, state) {
            List<CaseData>? casesData = AvocadoCubit.get(context).getLawyerCases?.casesData;
            return Conditional.single(
              context: context,
              conditionBuilder:(context) => state is GetCasesByLawyerIdDataSuccessful,
              widgetBuilder: (context) =>  Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    LocaleKeys.totalCases.tr(),
                    style: TextStyle(
                      fontFamily: 'Nedian',
                      fontSize: 20.0,
                      color: gold,
                    ),
                  ),
                  backgroundColor: Colors.black,
                ),
                body: Conditional.single(
                    conditionBuilder: (context) => casesData?.length != null,
                    widgetBuilder:(context)=> SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            searchBar(),
                            const SizedBox(height: 20,),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => buildLawyerCasesItem(casesData![index],context),
                              separatorBuilder: (context, index) => const SizedBox(height: 10,),
                              itemCount: casesData!.length,
                            ),
                          ],
                        ),
                      ),
                    ),
                    context: context,
                    fallbackBuilder: (context) => scaleProgressIndicator(context)
                ),
              ),
              fallbackBuilder: (context) => scaleProgressIndicator(context),
            );
          },
        );
      }
    );
  }

  Widget buildLawyerCasesItem(CaseData caseData, context)
  => GestureDetector(
    onTap: (){navigateTo(context, CaseInfoScreen(caseData));},
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsetsDirectional.all(2.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 160,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${caseData.caseID}'.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: horizontalDivider(height: 1.5,hColor: Colors.grey),
              ),
              Text(
                '${LocaleKeys.openedAt.tr()} ${caseData.createdAt}'.split('T').elementAt(0),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                '${caseData.clientName}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                '${caseData.caseType}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Spacer(),
                  caseData.status == 'open'?
                  Text(
                    LocaleKeys.inProgress.tr(),
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ):Text(
                    LocaleKeys.inProgress.tr(),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
