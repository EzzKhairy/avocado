import 'dart:async';
import 'dart:math';

import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/main.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:workmanager/workmanager.dart';

// var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// Future showNotification() async{
//   AndroidNotificationDetails androidNotificationDetails =
//        AndroidNotificationDetails(
//           '${Random().nextInt(400)}',
//           'tasks',
//         playSound: true,
//         enableVibration: true,
//         priority: Priority.high,
//       );
//   var platformChannelSpecifies = NotificationDetails(
//     android: androidNotificationDetails
//   );
//
//   await flutterLocalNotificationsPlugin.show(
//            Random().nextInt(200),
//           tasksData![0].title,
//           'fsefes',
//           platformChannelSpecifies);
//
// }
//
// Future<void> callbackDispatcher() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('@mipmap/ic_launcher');
//
//   const InitializationSettings initializationSettings
//   = InitializationSettings(android: initializationSettingsAndroid);
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings)
//       .then((value) => debugPrint('Flutter Local Notifications Initialized'));
//
//   if (tasksData!.isNotEmpty || tasksData != null) {
//     Workmanager().executeTask((task, inputData) async {
//       showNotification()
//           .then((value) => debugPrint("Notification Pushed"))
//           .catchError((onError) {
//         debugPrint('Notification Error >>>> ' '$onError');
//       }); //simpleTask will be emitted here.
//       return Future.value(true);
//     });
//   }
//   else {
//     Timer(const Duration(seconds: 10), () {
//       Workmanager().executeTask((task, inputData) async {
//         showNotification()
//             .then((value) => debugPrint("Notification Pushed"))
//             .catchError((onError) {
//           debugPrint('Notification Error after Delay >>>> ' '$onError');
//         }); //simpleTask will be emitted here.
//         return Future.value(true);
//       });
//     });
//   }
// }

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit,AvocadoStates>(
        listener: (context, state){},
        builder: (context, state){
          var cubit = AvocadoCubit.get(context);
          return Conditional.single(
            context: context,
            conditionBuilder: (context)=>
            AvocadoCubit.get(context).caseModel != null && AvocadoCubit.get(context).lawyerData != null
                && AvocadoCubit.get(context).clientsModel != null && AvocadoCubit.get(context).getCourtModel != null
            && AvocadoCubit.get(context).getTasksModel != null && AvocadoCubit.get(context).getLawyers != null,
            widgetBuilder:(context)=> Scaffold(
              backgroundColor: Colors.transparent,
              appBar: NewGradientAppBar(
                elevation: 5,
                automaticallyImplyLeading: false,
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
                      Colors.black.withOpacity(0.842),
                      Colors.black.withOpacity(0.845),
                      Colors.black.withOpacity(0.89),
                    ],
                    begin: AlignmentDirectional.topEnd,
                    end: AlignmentDirectional.bottomStart,
                    stops: const [0.20,0.17,0.40]
                ),
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
                          text: 'My Account',
                        ),
                        GButton(
                          icon: Icons.notifications,
                          text: 'Alert',
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
