import 'package:avocado/cubit/avocadoCubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/modules/search_screen.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                color: defaultColor,
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
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: false,
            backgroundColor: Colors.black,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: const[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.toc),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notification',
              ),
            ],
          ),
        );
      },
    );
  }
}
