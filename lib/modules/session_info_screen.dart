import 'package:avocado/models/session_model.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../translation/locale_keys.g.dart';

class SessionInfoScreen extends StatelessWidget {
  SessionData? sessionData;
  SessionInfoScreen(this.sessionData,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.sessions.tr(),
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
                buildSessionInfoScreenItem(context: context, title: 'Role Number', info: '${sessionData?.roleNumber}'),
                const SizedBox(height: 10),
                buildSessionInfoScreenItem(context: context, title: 'Session Date', info: '${sessionData?.sessionDate}'),
                const SizedBox(height: 10),
                buildSessionInfoScreenItem(context: context, title: 'Lawyer Name', info: '${sessionData?.presentLawyerName}'),
                const SizedBox(height: 10),
                buildSessionInfoScreenItem(context: context, title: 'Session Reason', info: '${sessionData?.sessionReason}'),
                const SizedBox(height: 10),
                buildSessionInfoScreenItem(context: context, title: 'Requirements', info: '${sessionData?.sessionRequirements}'),
                const SizedBox(height: 10),
                buildSessionInfoScreenItem(context: context, title: 'Decision', info: '${sessionData?.decision}'),
                const SizedBox(height: 10),
                buildSessionInfoScreenItem(context: context, title: 'Next Date', info: '${sessionData?.nextDate}'),
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
