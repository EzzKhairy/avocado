import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/case_model.dart';
import 'package:avocado/models/clients_model.dart';
import 'package:avocado/models/court_model.dart';
import 'package:avocado/models/court_model.dart';
import 'package:avocado/models/court_model.dart';
import 'package:avocado/models/expert_session_model.dart';
import 'package:avocado/models/investegation_model.dart';
import 'package:avocado/models/investigation_places_model.dart';
import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/models/session_model.dart';
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

  ClientsModel? updateClientModel;
  void updateClientProfile({
    required int? clientsID,
    required int? lawyerID,
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
        'Lawyer_id' : lawyerID,
        'name' : name,
        'Client_National_Number' : clientNationalNumber,
        'address' : address,
        'phone' : phone,
      },

    ).then((value) {
      updateClientModel = ClientsModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(updateClientModel?.message);
      }
      emit(UpdateClientProfileSuccessful(updateClientModel!));
    }
    ).catchError((onError){
      emit(UpdateClientProfileError(updateClientModel!));
      if (kDebugMode) {
        print(updateClientModel?.message);
        print(onError);
      }
    });
  }

  ClientsModel? NewClientModel;
  void addNewClient({
    required String? lawyerID,
    required String? clientNationalNumber,
    required String? name,
    required String? email,
    String? address,
    String? phone,
  }){
    emit(AddNewClientLoading());
    DioHelper.postData(
      url: 'clients',
      data: {
        'email' : email,
        'Lawyer_id' : lawyerID,
        'name' : name,
        'Client_National_Number' : clientNationalNumber,
        'address' : address,
        'phone' : phone,
      },

    ).then((value) {
      NewClientModel = ClientsModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(NewClientModel?.message);
      }
      emit(AddNewClientSuccessful(NewClientModel!));
    }
    ).catchError((onError){
      emit(AddNewClientError(NewClientModel!));
      if (kDebugMode) {
        print(NewClientModel?.message);
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

  SessionModel? sessionModel;
  void getSessions(){
    emit(GetSessionsDataLoading());
    DioHelper.getData(
      url: 'sessions',
    ).then((value) {
      sessionModel = SessionModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(sessionModel?.sessionData![0].presentLawyerName);
      }
      emit(GetSessionsDataSuccessful());
    }
    ).catchError((onError){
      emit(GetSessionsDataError());
      if (kDebugMode) {
      print(sessionModel!.sessionData![0].sessionRequirements);
        print(onError.toString());
      }
    });
  }

  ExpertSessionModel? expertSessionModel;
  void getExpertSessions(){
    emit(GetExpertSessionDataLoading());
    DioHelper.getData(
      url: 'expert_sessions',
    ).then((value) {
      expertSessionModel = ExpertSessionModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(expertSessionModel?.expertSessionData![0].officeAddress);
      }
      emit(GetExpertSessionDataSuccessful());
    }
    ).catchError((onError){
      emit(GetExpertSessionDataError());
      if (kDebugMode) {
        print(expertSessionModel!.expertSessionData![0].expertName);
        print(onError.toString());
      }
    });
  }

  InvestigationModel? investigationModel;
  void getInvestigations(){
    emit(GetInvestigationsDataLoading());
    DioHelper.getData(
      url: 'investigations',
    ).then((value) {
      investigationModel = InvestigationModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(investigationModel?.investigationData![0].topic);
      }
      emit(GetInvestigationsDataSuccessful());
    }
    ).catchError((onError){
      emit(GetInvestigationsDataError());
      if (kDebugMode) {
        print(investigationModel?.investigationData![0].topic);
        print(onError.toString());
      }
    });
  }

  InvestigationPlacesModel? investigationPlacesModel;
  void getInvestigationPlaces(){
    emit(GetInvestigationsPlacesDataLoading());
    DioHelper.getData(
      url: 'investigations',
    ).then((value) {
      investigationPlacesModel = InvestigationPlacesModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(investigationPlacesModel?.data![0].name);
      }
      emit(GetInvestigationsPlacesDataSuccessful());
    }
    ).catchError((onError){
      emit(GetInvestigationsPlacesDataError());
      if (kDebugMode) {
        print(investigationPlacesModel?.data![0].name);
        print(onError.toString());
      }
    });
  }

  CourtModel? updateCourtModel;
  void updateCourtProfile({
    required int? courtID,
    required String? address,
    required String? name,
    String? longitude,
    String? latitude,
    String? phone,
  }){
    emit(UpdateCourtDataLoading());
    DioHelper.putData(
      url: 'courts/$courtID',
      data: {
        'Latitude' : latitude,
        'name' : name,
        'Longtude' : longitude,
        'address' : address,
        'phone' : phone,
      },

    ).then((value) {
      updateCourtModel = CourtModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(updateCourtModel?.message);
      }
      emit(UpdateCourtDataSuccessful(updateCourtModel!));
    }
    ).catchError((onError){
      emit(UpdateCourtDataError(updateCourtModel!));
      if (kDebugMode) {
        print(updateCourtModel?.message);
        print(onError);
      }
    });
  }

  CourtModel? AddCourtModel;
  void AddCourtProfile({
    required String? address,
    required String? name,
    String? longitude,
    String? latitude,
    required String phone,
  }){
    emit(AddCourtDataLoading());
    DioHelper.postData(
      url: 'courts',
      data: {
        'Latitude' : latitude,
        'name' : name,
        'Longtude' : longitude,
        'address' : address,
        'phone' : phone,
      },

    ).then((value) {
      AddCourtModel = CourtModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(AddCourtModel?.message);
      }
      emit(AddCourtDataSuccessful(AddCourtModel!));
    }
    ).catchError((onError){
      emit(AddCourtDataError(AddCourtModel!));
      if (kDebugMode) {
        print(AddCourtModel?.message);
        print(onError);
      }
    });
  }

  CourtModel? getCourtModel;
  void getCourts(){
    emit(GetCourtDataLoading());
    DioHelper.getData(
      url: 'courts',
    ).then((value) {
      getCourtModel = CourtModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(getCourtModel?.message);
      }
      emit(GetCourtDataSuccessful(getCourtModel!));
    }
    ).catchError((onError){
      emit(GetCourtDataError(getCourtModel!));
      if (kDebugMode) {
        print(getCourtModel?.message);
        print(onError);
      }
    });
  }

  void checkSession(){

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