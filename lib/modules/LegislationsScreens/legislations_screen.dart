import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/session_model.dart';
import 'package:avocado/modules/LegislationsScreens/legislations_info_screen.dart';
import 'package:avocado/modules/sesssionScreens/session_info_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../models/legislation_model.dart';
import '../../translation/locale_keys.g.dart';

class LegislationsScreen extends StatelessWidget {
  const LegislationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AvocadoCubit.get(context).getLegislations();
        return BlocConsumer<AvocadoCubit,AvocadoStates>(
          listener: (context,state){},
          builder: (context,state) {
            List<LegislationsData>? legislationData = AvocadoCubit.get(context).legislationModel?.data;
            return Conditional.single(
              context: context,
              conditionBuilder: (context) => state is GetLegislationsSuccessful,
              widgetBuilder:(context) => Scaffold(
                appBar:AppBar(
                  centerTitle: true,
                  title: Text(
                    LocaleKeys.legistilation.tr(),
                    style: TextStyle(
                      fontFamily: 'Nedian',
                      fontSize: 23.0,
                      color: gold,
                    ),
                  ),
                  backgroundColor: Colors.black,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        searchBar(controller: null),
                        const SizedBox(height: 15,),
                        Conditional.single(
                        context: context,
                        conditionBuilder: (context)=> legislationData!.isNotEmpty,
                        widgetBuilder:(context) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildSessionItem(legislationData![index],context),
                          separatorBuilder: (context, index) => const SizedBox(height: 10,),
                          itemCount: legislationData!.length,
                        ),
                        fallbackBuilder: (context) => Center(child: Text(
                          LocaleKeys.noLegislations.tr(),
                          style: const TextStyle(
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
              fallbackBuilder: (context) => scaleProgressIndicator(context)
            );
          },
        );
      }
    );
  }


  Widget buildSessionItem(LegislationsData? legislationsData,context)=> GestureDetector(
    onTap: (){navigateTo(context, LegislationsInfoScreen(legislationsData?.attachment));},
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsetsDirectional.all(2.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${legislationsData?.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 3,
                ),
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(vertical: 5.0),
                child: horizontalDivider(height: 1.5,hColor: Colors.grey),
              ),
              Text(
                '${LocaleKeys.created.tr()} ''${legislationsData?.createdAt}'.split('T').elementAt(0),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

}
