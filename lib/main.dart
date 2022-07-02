import 'dart:io';
import 'package:avocado/Layout/app_layout.dart';
import 'package:avocado/cubit/app_cubit.dart';
import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/modules/login_screen.dart';
import 'package:avocado/shared/bloc_observer.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/states.dart';
import 'remoteNetwork/cache_helper.dart';
import 'remoteNetwork/dio_helper.dart';
import 'shared/styles/themes.dart';


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

  token = CacheHelper.getData(key : 'token');
  lawyerId = CacheHelper.getData(key : 'id');
  print(token);
  print('constant Id: ' + lawyerId.toString());


  if(token != null)
    {
      widget = AppLayout(index: 0,);
    }
  else
    {
      widget = LoginScreen();
    }

  runApp(
      EasyLocalization(
        path: 'assets/translation',
        supportedLocales: const [
          Locale('en'),
          Locale('ar')
        ],
        fallbackLocale: const Locale('ar'),
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
        BlocProvider(create: (context) => AvocadoCubit()..init()),
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
