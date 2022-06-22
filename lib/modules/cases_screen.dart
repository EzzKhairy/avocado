import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/case_model.dart';
import 'package:avocado/modules/home_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/views/case_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class CasesScreen extends StatelessWidget {
  CasesScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit, AvocadoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<CaseData>? casesData = AvocadoCubit.get(context).caseModel?.casesData;
        List<CaseData>? searchcasesData = AvocadoCubit.get(context).searchCaseModel?.casesData ?? [];
        return Scaffold(
          appBar: NewGradientAppBar(
            centerTitle: true,
            title: Text(
              'Cases',
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
            conditionBuilder: (context) => casesData?.length != null,
            widgetBuilder:(context)=> SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchBar(
                        controller: searchController,
                        onChange: (value){
                          if(value.isNotEmpty) {
                            AvocadoCubit.get(context).searchCases(keyword: value);
                          }
                          else{
                            AvocadoCubit.get(context).getCases();
                          }
                        }
                    ),
                    const SizedBox(height: 20,),
                    searchcasesData.isEmpty ?
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                          return CaseInfoCard(casesData![index],width: double.infinity);},
                      separatorBuilder: (context, index) => const SizedBox(height: 10,),
                      itemCount: casesData!.length,
                    ):
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CaseInfoCard(searchcasesData[index],width: double.infinity);},
                      separatorBuilder: (context, index) => const SizedBox(height: 10,),
                      itemCount: searchcasesData.length,)
                  ],
                ),
              ),
            ),
            context: context,
            fallbackBuilder: (context) => scaleProgressIndicator(context)
          ),
        );
      },
    );
  }
}
