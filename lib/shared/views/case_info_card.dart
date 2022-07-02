import 'package:avocado/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/case_model.dart';
import '../../modules/casesScreen/case_info_screen.dart';
import '../components.dart';

class CaseInfoCard extends StatelessWidget {

  CaseData caseData;
  double width;

  CaseInfoCard(
      this.caseData,{
        required this.width,
        Key? key
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){navigateTo(context, CaseInfoScreen(caseData));},
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: const EdgeInsetsDirectional.all(2.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: width,
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
                  '${LocaleKeys.openedAt.tr()} ' ' ${caseData.createdAt}'.split('T').elementAt(0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4.5,),
                Text(
                  '${caseData.clientName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  '${caseData.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                      LocaleKeys.closed.tr(),
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
}
