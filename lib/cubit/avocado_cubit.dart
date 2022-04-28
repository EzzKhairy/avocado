import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/case_model.dart';
import 'package:avocado/models/clients_model.dart';
import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/modules/home_screen.dart';
import 'package:avocado/modules/notification_screen.dart';
import 'package:avocado/modules/settings_screen.dart';
import 'package:avocado/modules/tasks_screen.dart';
import 'package:avocado/remoteNetwork/dio_helper.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AvocadoCubit extends Cubit <AvocadoStates>
{
  AvocadoCubit() : super(InitialState());

  static AvocadoCubit get(context) => BlocProvider.of(context);


  LawyersModel? lawyerData;


  void getLawyerProfile(int? lawyerID){
    emit(GetLawyerProfileLoading());
    DioHelper.getData(
        url: 'lawyers/$lawyerID',
    ).then((value) {
      lawyerData = LawyersModel.fromJson(value.data);
        //print(element);
      if (kDebugMode) {
        print(lawyerData?.data![0].email);
      }
      emit(GetLawyerProfileSuccessful());
    }
    ).catchError((onError){
      emit(GetLawyerProfileError());
      if (kDebugMode) {
        print(lawyerData?.data![0].email);
        print(onError);
      }
    });
  }

  LawyersModel? lawyerUpdated;
  void updateLawyerProfile({
    required int? lawyerID,
    required String? name,
    required String? email,
    required String? address,
    required String? role,
    required String? lawyerNationalNumber,
  }){
    emit(UpdateLawyerProfileLoading());
    DioHelper.putData(
      url: 'lawyers/$lawyerID',
      data: {
        'email' : email,
        'name' : name,
        'Lawyer_National_Number' : lawyerNationalNumber,
        'address' : address,
        'Role': role,
      },

    ).then((value) {
      lawyerUpdated = LawyersModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(lawyerUpdated?.message);
      }
      getLawyerProfile(lawyerId);
      emit(UpdateLawyerProfileSuccessful(lawyerUpdated!));
    }
    ).catchError((onError){
      emit(UpdateLawyerProfileError(lawyerUpdated!));
      if (kDebugMode) {
        print(lawyerUpdated?.message);
        print(onError);
      }
    });
  }

  ClientsModel? clientsModel;
  void getClients(){
    emit(GetClientsLoading());
    DioHelper.getData(
      url: 'clients',
    ).then((value) {
      clientsModel = ClientsModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(clientsModel?.clientsData![0].email);
      }
      emit(GetClientsSuccessful());
    }
    ).catchError((onError){
      emit(GetClientsError());
      if (kDebugMode) {
        print(lawyerData?.data![0].email);
        print(onError);
      }
    });
  }

  ClientsModel? clientUpdateModel;
  void updateClientProfile({
    required int? clientsID,
    required String? lawyerID,
    required String? clientNationalNumber,
    required String? name,
    required String? email,
    String? address,
    String? phone,
  }){
    emit(UpdateClientProfileLoading());
    DioHelper.putData(
      url: 'clients/$clientsID',
      data: {
        'email' : email,
        'lawyer_id' : lawyerID,
        'name' : name,
        'Client_National_Number' : clientNationalNumber,
        'address' : address,
        'phone' : phone,
      },

    ).then((value) {
      clientUpdateModel = ClientsModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(clientUpdateModel?.message);
      }
      emit(UpdateClientProfileSuccessful(clientUpdateModel!));
    }
    ).catchError((onError){
      emit(UpdateClientProfileError(clientUpdateModel!));
      if (kDebugMode) {
        print(clientUpdateModel?.message);
        print(onError);
      }
    });
  }

  bool isEdit = false;
  String editText = 'EDIT';
  void editPressed({
    required int? lawyerID,
    required String? email,
    required String? lawyerNationalNumber,
    required String? address,
    required String? name,
     role,
  }){
    isEdit = !isEdit;
    if (isEdit) {
      editText = 'SAVE';
      emit(EditPressedState());
    } else {
      editText = 'EDIT';
      updateLawyerProfile(
          lawyerID: lawyerID,
          email: email,
          lawyerNationalNumber: lawyerNationalNumber,
          name: name,
          address: address,
          role: role
      );
    }
  }

  CaseModel? caseModel;
  void getCases(){
    emit(GetCasesDataLoading());
    DioHelper.getData(
      url: 'cases',
    ).then((value) {
      caseModel = CaseModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(caseModel?.casesData![0].caseID);
      }
      emit(GetCasesDataSuccessful());
    }
    ).catchError((onError){
      emit(GetCasesDataError());
      if (kDebugMode) {
        print(caseModel?.casesData![0].courtNumber);
        print(onError.toString());
      }
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

  bool isChanged = false;
  void toggleIsChanged(){
    isChanged = true;
    emit(ChangeNavBarState());
  }

}