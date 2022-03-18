import 'package:avocado/Layout/app_layout.dart';
import 'package:avocado/cubit/avocadoCubit.dart';
import 'package:avocado/modules/login_screen.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/appCubit.dart';
import 'cubit/states.dart';
import 'remoteNetwork/cache_helper.dart';
import 'remoteNetwork/dio_helper.dart';
import 'shared/styles/themes.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();

  //Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  bool? showOnBoarding = CacheHelper.getData(key : 'ShowOnBoarding');
  token = CacheHelper.getData(key : 'token');


  if(token != null)
    {
      widget = AppLayout();
    }
  else
    {
      widget = LoginScreen();
    }


  runApp(MyApp(
    isDark: isDark,
    startWidget: widget ,
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
        BlocProvider(create: (context)=> AvocadoCubit()),
      ],
      child: BlocConsumer<AppCubit, AvocadoStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            //themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            themeMode: AppCubit.get(context).appMode,
            debugShowCheckedModeBanner: false,
            home : AppLayout(),
          );
        },
      ),
    );
  }
}
