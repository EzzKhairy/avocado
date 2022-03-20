import 'package:avocado/cubit/avocadoCubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = AvocadoCubit.get(context);
        return Scaffold(
          appBar: NewGradientAppBar(
            title: Text(
              'AVOCADO',
              style: TextStyle(
                fontFamily: 'Nedian',
                fontSize: 25.0,
                color: gold,
              ),
            ),
            gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.70),
                  Colors.black.withOpacity(0.75),
                  Colors.black.withOpacity(0.60),
                  Colors.black.withOpacity(0.65),
                  Colors.black.withOpacity(0.70),
                  Colors.black.withOpacity(0.95),
                ],
                begin: AlignmentDirectional.topEnd,
                end: AlignmentDirectional.bottomStart,
                stops: const [0.15,0.15,0.15,0.15,0.15,0.60]
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar:
              GNav(
                activeColor: gold,
                tabBackgroundColor: Colors.black,
                color: HexColor("ADADAD"),
                gap: 5,
                selectedIndex: AvocadoCubit.get(context).currentIndex,
                onTabChange: (index){
                  AvocadoCubit.get(context).changeBottomNav(index);
                },
                backgroundColor: HexColor("ECECEC"),
                  padding: const EdgeInsetsDirectional.all(13),
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.toc,
                      text: 'Tasks',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                    ),
                    GButton(
                      icon: Icons.notifications,
                      text: 'Alert',
                    )
                  ]
              ),
          );
      },
    );
  }
}
