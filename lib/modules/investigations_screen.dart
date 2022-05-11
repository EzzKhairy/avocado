import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/case_model.dart';
import 'package:avocado/models/investegation_model.dart';
import 'package:avocado/models/investegation_model.dart';
import 'package:avocado/models/records_model.dart';
import 'package:avocado/modules/home_screen.dart';
import 'package:avocado/modules/investigation_info_screen.dart';
import 'package:avocado/modules/record_info_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class InvestigationsScreen extends StatelessWidget {
  int? caseID;
  InvestigationsScreen(this.caseID,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AvocadoCubit.get(context).getInvestigations();
        return BlocConsumer<AvocadoCubit, AvocadoStates>(
          listener: (context, state) {},
          builder: (context, state) {
            List<InvestigationData>? recordsData = AvocadoCubit.get(context).investigationModel?.investigationData;
            return Scaffold(
              appBar: NewGradientAppBar(
                centerTitle: true,
                title: Text(
                  'Investigations',
                  style: TextStyle(
                    fontFamily: 'Nedian',
                    fontSize: 25.0,
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
              body: Conditional.single(
                conditionBuilder: (context) => recordsData?.length != null,
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
                          itemBuilder: (context, index) => buildRecordItem(recordsData![index],context),
                          separatorBuilder: (context, index) => const SizedBox(height: 10,),
                          itemCount: recordsData!.length,
                        ),
                      ],
                    ),
                  ),
                ),
                context: context,
                fallbackBuilder: (context) => scaleProgressIndicator(context),
              ),
            );
          },
        );
      }
    );
  }


  Widget buildRecordItem(InvestigationData investigationData, context,)
  => GestureDetector(
    onTap: (){navigateTo(context, InvestigationInfoScreen(investigationData));},
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
                '${investigationData.investigationId}'.toUpperCase(),
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
                'Opened ${investigationData.createdAt}'.split('T').elementAt(0),
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
                '${investigationData.topic}',
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
