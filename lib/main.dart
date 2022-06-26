import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:avocado/Layout/app_layout.dart';
import 'package:avocado/cubit/app_cubit.dart';
import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/models/tasks_model.dart';
import 'package:avocado/modules/login_screen.dart';
import 'package:avocado/modules/session_info_screen.dart';
import 'package:avocado/shared/bloc_observer.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'cubit/states.dart';
import 'remoteNetwork/cache_helper.dart';
import 'remoteNetwork/dio_helper.dart';
import 'shared/styles/themes.dart';

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
//   Workmanager().executeTask((task, inputData) async {
//     TasksModel? tasksModel = await AvocadoCubit.getNotifyTasks("2022-05-14");
//     await AvocadoCubit.showNotification(tasksModel)
//         .then((value) {
//       print('executeTask' '${tasksModel?.tasksData![0].title}');
//       debugPrint("Notification Pushed");
//         })
//         .catchError((onError) {
//       debugPrint('Notification Error >>>> ' '$onError');
//     }); //simpleTask will be emitted here.
//     return Future.value(true);
//   });
// }

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer =MyBlocObserver();
  HttpOverrides.global = MyHttpOverrides();


  Widget widget;

  bool? isDark = CacheHelper.getData(key: 'isDark');

  //bool? showOnBoarding = CacheHelper.getData(key : 'ShowOnBoarding');
  token = CacheHelper.getData(key : 'token');
  lawyerId = CacheHelper.getData(key : 'id');
  print(token);
  print(lawyerId);


  if(token != null)
    {
      widget = const AppLayout();
    }
  else
    {
      widget = LoginScreen();
    }
  //
  // Timer(Duration(seconds: 5), (){
  //   Workmanager().initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode: true, // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  //   );
  // });
  //
  // Workmanager().registerPeriodicTask(
  //     '${Random().nextInt(200)}',
  //     'Every 15 Mins',
  //     frequency: const Duration(minutes: 15),
  //     initialDelay: Duration(seconds: 5)
  // ).then((value) => debugPrint('Periodic Task Registered')).catchError((onError){"Periodic Task Error >>>> $onError";});

  runApp(
      EasyLocalization(
        path: 'assets/translation',
        supportedLocales: const [
          Locale('en'),
          Locale('ar')
        ],
        fallbackLocale: Locale('en'),
        child: MyApp(
          isDark: isDark,
          startWidget: widget ,
  ),
      ));
}

class MyApp extends StatelessWidget
{
  final bool? isDark;
  final Widget startWidget;

   MyApp({
    this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> AppCubit()),
        BlocProvider(
          create: (context) => AvocadoCubit()
            ..getLawyerProfile(lawyerId)
            ..getClients()
            ..checkAuthorization(lawyerId)
            ..getCases()
            ..getCourts()
            ..getTodayTasks("2022-05-14")
            ..getEveryLawyer()


        ),
      ],
      child: BlocConsumer<AppCubit, AvocadoStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            locale:context.locale ,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            home : startWidget,
          );
        },
      ),
    );
  }
}
