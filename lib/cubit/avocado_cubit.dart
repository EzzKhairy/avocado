import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/modules/home_screen.dart';
import 'package:avocado/modules/notification_screen.dart';
import 'package:avocado/modules/settings_screen.dart';
import 'package:avocado/modules/tasks_screen.dart';
import 'package:avocado/remoteNetwork/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AvocadoCubit extends Cubit <AvocadoStates>
{
  AvocadoCubit() : super(InitialState());

  static AvocadoCubit get(context) => BlocProvider.of(context);


  LawyersModel? lawyersList;


  void getLawyersData(){
    emit(GetLawyerDataLoading());
    DioHelper.getData(
        url: 'lawyer',
    ).then((value) {
      lawyersList = LawyersModel.fromJson(value.data);
        //print(element);
      print(lawyersList?.lawyersData[0].email);
      emit(GetLawyerDataSuccessful());
    }
    ).catchError((onError){
      emit(GetLawyerDataError());
      print(onError);
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const TasksScreen(),
    const SettingsScreen(),
    const NotificationScreen(),
  ];

  void changeBottomNav(int index)
  {
    currentIndex = index;
    emit(ChangeNavBarState());
  }

}