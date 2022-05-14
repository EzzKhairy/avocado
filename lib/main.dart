import 'dart:math';

import 'package:avocado/Layout/app_layout.dart';
import 'package:avocado/cubit/app_cubit.dart';
import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/modules/login_screen.dart';
import 'package:avocado/modules/session_info_screen.dart';
import 'package:avocado/shared/bloc_observer.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';
import 'cubit/states.dart';
import 'remoteNetwork/cache_helper.dart';
import 'remoteNetwork/dio_helper.dart';
import 'shared/styles/themes.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();

  EasyLocalization.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer =MyBlocObserver();
  Widget widget;

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

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



  // Workmanager().registerPeriodicTask(
  //     '${Random().nextInt(200)}',
  //     'Every 15 Mins',
  //     frequency: const Duration(minutes: 15),
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
            ..getCases()
            ..getCourts()
              ..getTodayTasks("2022-05-11")
              ..getEveryLawyer()

        ),
      ],
      child: BlocConsumer<AppCubit, AvocadoStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          //AvocadoCubit.getNotifyTasks("2022-05-11");
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
