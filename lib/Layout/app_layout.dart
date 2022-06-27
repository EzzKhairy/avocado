import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:avocado/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';



class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);
  @override
  State<AppLayout> createState() => _AppLayoutState();
}


class _AppLayoutState extends State<AppLayout> {

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
        listener: (context, state){},
        builder: (context, state){
          var cubit = AvocadoCubit.get(context);
          return Conditional.single(
            context: context,
            conditionBuilder: (context)=>
            (AvocadoCubit.get(context).caseModel != null) && AvocadoCubit.get(context).lawyerData != null
                && AvocadoCubit.get(context).clientsModel != null && AvocadoCubit.get(context).getCourtModel != null
            && AvocadoCubit.get(context).getTasksModel != null && AvocadoCubit.get(context).getLawyers != null,
            widgetBuilder:(context)=> ScaffoldGradientBackground(
              gradient:LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.842),
                    Colors.black.withOpacity(0.845),
                    Colors.black.withOpacity(0.89),
                  ],
                  begin: AlignmentDirectional.topEnd,
                  end: AlignmentDirectional.bottomStart,
                  stops: const [0.20, 0.17, 0.40]),
              appBar: AppBar(
                automaticallyImplyLeading:false,
                titleTextStyle: TextStyle(letterSpacing: 2),
                title:  Text(
                        'AVOCADO',
                        style: TextStyle(
                        fontFamily: 'Nedian',
                        fontSize: 25.0,
                        color: gold,
                        )),
                backgroundColor: Colors.transparent,
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar:
                  GNav(
                    activeColor: gold,
                    tabBackgroundColor: Colors.black,
                    color: HexColor('ADADAD'),
                    gap: 5,
                    selectedIndex: AvocadoCubit.get(context).currentIndex,
                    onTabChange: (index){
                      AvocadoCubit.get(context).changeBottomNav(index);
                    },
                    backgroundColor: HexColor('ECECEC'),
                      padding: const EdgeInsetsDirectional.all(13),
                      tabs:  [
                        GButton(
                          icon: Icons.home,
                          text: LocaleKeys.home.tr(),
                        ),
                        GButton(
                          icon: Icons.checklist_outlined,
                          text: LocaleKeys.tasks.tr(),
                        ),
                        GButton(
                          icon: Icons.person,
                          text: LocaleKeys.profile.tr(),
                        ),
                        GButton(
                          icon: Icons.menu,
                          text: 'More',
                        )
                      ]
                  ),
              ),
            fallbackBuilder: (context) => scaleProgressIndicator(context)
          );
        },
      );
  }
}
