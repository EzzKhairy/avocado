import 'package:avocado/models/expert_session_model.dart';
import 'package:avocado/models/session_model.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ExpertSessionInfoScreen extends StatelessWidget {
  ExpertSessionData expertSessionData;
  ExpertSessionInfoScreen(this.expertSessionData,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text(
          'Expert Session'.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Nedian',
            fontSize: 23.0,
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
        padding: const EdgeInsets.all(8.0),
        child : Column(
          children : [
            buildSessionInfoScreenItem(context: context, title: 'Expert Name', info: '${expertSessionData.expertName}'),
            const SizedBox(height: 10),
            buildSessionInfoScreenItem(context: context, title: 'Expert Office Address', info: '${expertSessionData.officeAddress}'),
            const SizedBox(height: 10),
            buildSessionInfoScreenItem(context: context, title: 'Session Date', info: '${expertSessionData.sessionDate}'),
            const SizedBox(height: 10),
            buildSessionInfoScreenItem(context: context, title: 'Session Reason', info: '${expertSessionData.sessionReason}'),
            const SizedBox(height: 10),
            buildSessionInfoScreenItem(context: context, title: 'Lawyer Name', info: '${expertSessionData.presentLawyerName}'),
            const SizedBox(height: 10),
            buildSessionInfoScreenItem(context: context, title: 'Decision', info: '${expertSessionData.decision}'),
            const SizedBox(height: 10),
            buildSessionInfoScreenItem(context: context, title: 'Next Date', info: '${expertSessionData.nextDate}')
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
