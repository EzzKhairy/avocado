import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/records_model.dart';
import 'package:avocado/modules/recordsScreens/record_info_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../translation/locale_keys.g.dart';

class RecordsScreen extends StatelessWidget {
  final int? caseID;
  const RecordsScreen(this.caseID,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AvocadoCubit.get(context).getRecords(caseId: caseID);
        return BlocConsumer<AvocadoCubit, AvocadoStates>(
          listener: (context, state) {},
          builder: (context, state) {
            List<RecordsData>? recordsData = AvocadoCubit.get(context).recordsModel?.recordsData;
            return Conditional.single(
              context: context,
              conditionBuilder: (context) => state is GetRecordsDataSuccessful,
              widgetBuilder: (context) => Scaffold(
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
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        searchBar(),
                        const SizedBox(height: 20,),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) => recordsData!.isNotEmpty,
                          widgetBuilder: (context) => ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => buildRecordItem(recordsData![index],context),
                            separatorBuilder: (context, index) => const SizedBox(height: 10,),
                            itemCount: recordsData!.length,
                          ),
                          fallbackBuilder: (context) => const Center(child: Text(
                            'No records included',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              fallbackBuilder: (context) => scaleProgressIndicator(context),
            );
          },
        );
      }
    );
  }


  Widget buildRecordItem(RecordsData recordsData, context,)
  => GestureDetector(
    onTap: (){navigateTo(context, RecordInfoScreen(recordsData));},
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
                '${recordsData.recordId}'.toUpperCase(),
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
                '${LocaleKeys.openedAt} ${recordsData.createdAt}'.split('T').elementAt(0),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                'Mohamed Ahmed',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                '${recordsData.topic}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    ),
  );
}
