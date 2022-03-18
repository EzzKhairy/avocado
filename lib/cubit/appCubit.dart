import 'package:avocado/cubit/states.dart';
import 'package:avocado/remoteNetwork/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppCubit extends Cubit<AvocadoStates>
{
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  ThemeMode appMode = ThemeMode.light;
  bool isDark = false;
  void changeAppThemeMode({bool ?fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared;
      emit(ChangeAppThemeModeState());
    }
    else {
      isDark =! isDark;
    }
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
    {
      if(isDark)
      {
        appMode = ThemeMode.dark;
      }
      else
        {
          appMode = ThemeMode.light;
        }
      emit(ChangeAppThemeModeState());
    });
  }
}