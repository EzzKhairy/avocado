import 'package:avocado/models/expert_session_model.dart';
import 'package:avocado/models/session_model.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../translation/locale_keys.g.dart';

class ExpertSessionInfoScreen extends StatelessWidget {
  ExpertSessionData expertSessionData;
  ExpertSessionInfoScreen(this.expertSessionData,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.e_session.tr(),
          style: TextStyle(
            fontFamily: 'Nedian',
            fontSize: 20.0,
            color: gold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child : Column(
          children : [
            buildSessionInfoScreenItem(context: context, title: LocaleKeys.e_name.tr(), info: '${expertSessionData.expertName}'),
            const SizedBox(height: 10),
            buildSessionInfoScreenItem(context: context, title:LocaleKeys.e_office_address.tr(), info: '${expertSessionData.officeAddress}'),
            const SizedBox(height: 10),
            buildSessionInfoScreenItem(context: context, title: LocaleKeys.sessionDate.tr(), info: '${expertSessionData.sessionDate}'),
            const SizedBox(height: 10),
            buildSessionInfoScreenItem(context: context, title:LocaleKeys.sessionReason.tr(), info: '${expertSessionData.sessionReason}'),
            const SizedBox(height: 10),
            buildSessionInfoScreenItem(context: context, title: LocaleKeys.lawyer.tr(), info: '${expertSessionData.presentLawyerName}'),
            const SizedBox(height: 10),
            buildSessionInfoScreenItem(context: context, title: LocaleKeys.decision.tr(), info: '${expertSessionData.decision}'),
            const SizedBox(height: 10),
            buildSessionInfoScreenItem(context: context, title: LocaleKeys.nextDate.tr(), info: '${expertSessionData.nextDate}')
          ],
        ),
      ),
    );
  }

  Widget buildSessionInfoScreenItem({
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
