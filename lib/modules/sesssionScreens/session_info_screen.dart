import 'package:avocado/models/session_model.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../translation/locale_keys.g.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
              child : Column(
                children : [
                  Text(
                    LocaleKeys.roleNumber.tr()+ ': ' + '${sessionData?.roleNumber?.toUpperCase()}',
                    style: const TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  buildSessionInfoScreenItem(context: context, title: LocaleKeys.sessionDate.tr(), info: '${sessionData?.sessionDate}'),
                  const SizedBox(height: 10),
                  buildSessionInfoScreenItem(context: context, title: LocaleKeys.lawyer.tr(), info: '${sessionData?.presentLawyerName}'),
                  const SizedBox(height: 10),
                  buildSessionInfoScreenItem(context: context, title: LocaleKeys.sessionReason.tr(), info: '${sessionData?.sessionReason}'),
                  const SizedBox(height: 10),
                  buildSessionInfoScreenItem(context: context, title: LocaleKeys.requirements.tr(), info: '${sessionData?.sessionRequirements}'),
                  const SizedBox(height: 10),
                  buildSessionInfoScreenItem(context: context, title: LocaleKeys.decision.tr(), info: '${sessionData?.decision}'),
                  const SizedBox(height: 10),
                  buildSessionInfoScreenItem(context: context, title: LocaleKeys.nextDate.tr(), info: '${sessionData?.nextDate}'),
                ],
              ),
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
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(title!,style: TextStyle(color: Colors.grey.shade600
                ),textAlign: TextAlign.left,),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const SizedBox(width: 15,),
                    Expanded(child: Text(info!,style: const TextStyle(fontSize: 18),maxLines: 3,)),
                  ],
                )
              ],
              )
          )
          ));
}
