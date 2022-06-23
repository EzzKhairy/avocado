import 'dart:convert';
import 'dart:math';

import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/case_model.dart';
import 'package:avocado/models/clients_model.dart';
import 'package:avocado/models/court_model.dart';
import 'package:avocado/models/expenses_model.dart';
import 'package:avocado/models/expert_session_model.dart';
import 'package:avocado/models/investegation_model.dart';
import 'package:avocado/models/investigation_places_model.dart';
import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/models/payments_model.dart';
import 'package:avocado/models/records_model.dart';
import 'package:avocado/models/session_model.dart';
import 'package:avocado/models/tasks_model.dart';
import 'package:avocado/modules/lawyerProfile/Lawyer_profile_new.dart';
import 'package:avocado/modules/home_screen.dart';
import 'package:avocado/modules/profile_screen.dart';
import 'package:avocado/modules/settings_screen.dart';
import 'package:avocado/modules/TaskScreens/tasks_screen.dart';
import 'package:avocado/remoteNetwork/dio_helper.dart';
import 'package:avocado/shared/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


class AvocadoCubit extends Cubit <AvocadoStates>
{
  AvocadoCubit() : super(InitialState());

  static AvocadoCubit get(context) => BlocProvider.of(context);

  static var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    Future ScheduleNotification({
      required DateTime taskDate,
      required String body,
      required String title
    }) async{
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      '${Random().nextInt(400)}',
      'tasks',
      playSound: true,
      enableVibration: true,
      priority: Priority.high,
    );
    var platformChannelSpecifies = NotificationDetails(
        android: androidNotificationDetails
    );
      await flutterLocalNotificationsPlugin.zonedSchedule(
          Random().nextInt(200),
          title.toString(),
          body,
          tz.TZDateTime.from(taskDate,tz.local),
          platformChannelSpecifies,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
      );
  }



 LawyersModel? getLawyerModel;
  void getLawyerById(int? lawyerID){
    emit(GetLawyerProfileLoading());
    DioHelper.getData(
      url: 'lawyers/$lawyerID',
    ).then((value) {
      getLawyerModel = LawyersModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(getLawyerModel?.data![0].email);
      }
      emit(GetLawyerProfileSuccessful());
    }
    ).catchError((onError){
      emit(GetLawyerProfileError());
      if (kDebugMode) {
        print(getLawyerModel?.data![0].email);
        print(onError);
      }
    });
  }


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

  bool isAdmin = false;
  void checkAuthorization (lawyerId){
    if(lawyerData?.data![0].role == 'Admin'){
      isAdmin = true;
      emit(CheckAuthorizationState());
    }
    else {
      isAdmin = false;
      emit(CheckAuthorizationState());

    }
  }

  LawyersModel? lawyerUpdated;
  void updateLawyerProfile({
    required int? lawyerID,
    required String? name,
    required String? email,
    required String? address,
    required String? role,
    required String? lawyerNationalNumber,
    String? phoneNumber,
    String? dateOfBirth,
    String ? gender,
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
        'phone' : phoneNumber,
        'DOB': dateOfBirth,
        'Gender' : gender,
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

  LawyersModel? lawyerPhotoUpdatedModel;
  void updateLawyerProfilePhoto({
    required int? lawyerID,
    required String? name,
    required String? email,
    required String? address,
    required String? role,
    required String? lawyerNationalNumber,
    String? profilePhoto,
  }){
    emit(UpdateLawyerProfilePhotoLoading());
    DioHelper.putData(
      url: 'lawyers/$lawyerID',
      data: {
        'email' : email,
        'name' : name,
        'Lawyer_National_Number' : lawyerNationalNumber,
        'profile_photo_path' : profilePhoto
      },

    ).then((value) {
      lawyerPhotoUpdatedModel = LawyersModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(lawyerPhotoUpdatedModel?.message);
      }
      getLawyerProfile(lawyerId);
      emit(UpdateLawyerProfilePhotoSuccessful(lawyerPhotoUpdatedModel!));
    }
    ).catchError((onError){
      emit(UpdateLawyerProfilePhotoError(lawyerPhotoUpdatedModel!));
      if (kDebugMode) {
        print(lawyerPhotoUpdatedModel?.message);
        print(onError);
      }
    });
  }


  ClientsModel? searchClientsModel;
  void searchClients(String keyWord){
    emit(SearchClientsLoading());
    DioHelper.getData(
      url: 'clients_search/$keyWord',
    ).then((value) {
      searchClientsModel = ClientsModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print( 'Searched >> ' '${searchClientsModel?.clientsData![0].email}');
      }
      emit(SearchClientsSuccessful());
    }
    ).catchError((onError){
      emit(SearchClientsError());
      if (kDebugMode) {
        print(lawyerData?.data![0].email);
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
    if(isAdmin){
    DioHelper.getData(
      url: 'cases',
    ).then((value) {
      caseModel = CaseModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(caseModel?.casesData![0].caseID);
      }
      emit(GetCasesDataSuccessful());
    }).catchError((onError){
      emit(GetCasesDataError());
      if (kDebugMode) {
        print(caseModel?.casesData![0].courtNumber);
        print(onError.toString());
      }
    });
    }
    else {
      emit(GetCasesByLawyerIdDataLoading());
      DioHelper.getData(
        url: 'cases_foriegn/$lawyerId',
      ).then((value) {
        caseModel = CaseModel.fromJson(value.data);
        //print(element);
        if (kDebugMode) {
          print(caseModel?.casesData![0].caseID);
        }
        emit(GetCasesByLawyerIdDataSuccessful());
      }).catchError((onError){
        emit(GetCasesByLawyerIdDataError());
        if (kDebugMode) {
          print(caseModel?.casesData![0].courtNumber);
          print(onError.toString());
        }
      });
    }
  }

  CaseModel? searchCaseModel;
  void searchCases({required String keyword}){
    emit(SearchCasesDataLoading());
    DioHelper.getData(
      url: 'cases_search/$keyword',
    ).then((value) {
      searchCaseModel = CaseModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(searchCaseModel?.casesData![0].caseID);
      }
      emit(SearchCasesDataSuccessful());
    }).catchError((onError){
      emit(SearchCasesDataError());
      if (kDebugMode) {
        print(searchCaseModel?.casesData![0].courtNumber);
        print(onError.toString());
      }
    });
  }

  LawyersModel? getLawyers;
  void getEveryLawyer(){
    emit(GetLawyersDataLoading());
    DioHelper.getData(
      url: 'lawyers',
    ).then((value) {
      getLawyers = LawyersModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(getLawyerModel?.data![0].email);
      }
      emit(GetLawyersDataSuccessful());
    }
    ).catchError((onError){
      emit(GetLawyersDataError());
      if (kDebugMode) {
        print(getLawyerModel?.data![0].email);
        print(onError);
      }
    });
  }

  LawyersModel? searchLawyersModel;
  void searchLawyers({required String? keyword}){
    emit(SearchLawyersDataLoading());
    DioHelper.getData(
      url: 'lawyers_search/$keyword',
    ).then((value) {
      searchLawyersModel = LawyersModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(searchLawyersModel?.data![0].email);
      }
      emit(SearchLawyersDataSuccessful());
    }
    ).catchError((onError){
      emit(SearchLawyersDataError());
      if (kDebugMode) {
        print(searchLawyersModel?.data![0].email);
        print(onError);
      }
    });
  }

  CaseModel? getLawyerCases;
  void getCasesByLawyerId({required int? lawyerId}){
    emit(GetCasesByLawyerIdDataLoading());
    DioHelper.getData(
      url: 'cases_foriegn/$lawyerId',
    ).then((value) {
      getLawyerCases = CaseModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(caseModel?.casesData![0].caseID);
      }
      emit(GetCasesByLawyerIdDataSuccessful());
    }).catchError((onError){
      emit(GetCasesByLawyerIdDataError());
      if (kDebugMode) {
        print(caseModel?.casesData![0].courtNumber);
        print(onError.toString());
      }
    });
  }

  SessionModel? sessionModel;
  void getSessions({required int ?caseId}){
    emit(GetSessionsDataLoading());
    DioHelper.getData(
      url: 'sessions_foriegn/$caseId',
    ).then((value) {
      sessionModel = SessionModel.fromJson(value.data);
      //print(element);
      emit(GetSessionsDataSuccessful());
    }
    ).catchError((onError){
      emit(GetSessionsDataError());
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }
  void resetSession(){
    sessionModel = null;
    emit(RestSessionsDataSuccesful());
  }

  RecordsModel? recordsModel;
  void getRecords({required int? caseId}){
    emit(GetRecordsDataLoading());
    DioHelper.getData(
      url: 'records_foriegn/$caseId',
    ).then((value) {
      recordsModel = RecordsModel.fromJson(value.data);
      //print(element);
      emit(GetRecordsDataSuccessful());
      print(recordsModel!.recordsData![0].clientName);
    }
    ).catchError((onError){
      emit(GetRecordsDataError());
      if (kDebugMode) {
        print(onError.toString());
      }
    });
  }

  ExpensesModel? expensesModel;
  void getExpenses({required int? caseId}){
    emit(GetExpensesDataLoading());
    DioHelper.getData(
      url: 'expenses_foriegn/$caseId',
    ).then((value) {
      expensesModel = ExpensesModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(expensesModel?.expensesData![0].amount);
      }
      emit(GetExpensesDataSuccessful());
    }
    ).catchError((onError){
      emit(GetExpensesDataError());
      if (kDebugMode) {
        print(expensesModel?.message);
        print(onError.toString());
      }
    });
  }

  PaymentsModel? paymentsModel;
  void getPayments({required int? caseId}){
    emit(GetPaymentsDataLoading());
    DioHelper.getData(
      url: 'payments_foriegn/$caseId',
    ).then((value) {
      paymentsModel = PaymentsModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(paymentsModel?.paymentsData![0].amount);
      }
      emit(GetPaymentsDataSuccessful());
    }
    ).catchError((onError){
      emit(GetPaymentsDataError());
      if (kDebugMode) {
        print(paymentsModel?.message);
        print(onError.toString());
      }
    });
  }

  ExpertSessionModel? expertSessionModel;
  void getExpertSessions({required int? caseId}){
    emit(GetExpertSessionDataLoading());
    DioHelper.getData(
      url: 'expert_sessions_foriegn/$caseId',
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
        print(onError.toString());
      }
    });
  }

  InvestigationModel? investigationModel;
  void getInvestigations({required int? caseId}){
    emit(GetInvestigationsDataLoading());
    DioHelper.getData(
      url: 'investigations_foriegn/$caseId',
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

  CourtModel? addCourtModel;
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
      addCourtModel = CourtModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(addCourtModel?.message);
      }
      emit(AddCourtDataSuccessful(addCourtModel!));
    }
    ).catchError((onError){
      emit(AddCourtDataError(addCourtModel!));
      if (kDebugMode) {
        print(addCourtModel?.message);
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

  CourtModel? getCourtByIdModel;
  void getCourtById(courtId){
    emit(GetCourtDataLoading());
    DioHelper.getData(
      url: 'courts/$courtId',
    ).then((value) {
      getCourtByIdModel = CourtModel.fromJson(value.data);
      //print(element);
      if (kDebugMode) {
        print(getCourtByIdModel?.message);
      }
      emit(GetCourtDataSuccessful(getCourtByIdModel!));
    }
    ).catchError((onError){
      emit(GetCourtDataError(getCourtByIdModel!));
      if (kDebugMode) {
        print(getCourtByIdModel?.message);
        print(onError);
      }
    });
  }

  TasksModel? AddTasksModel;
  void addNewTask({
  required String title,
  required String date,
  required String startTime,
    String? endTime,
    String? description,
  }){
    emit(AddNewTaskLoading());
    DioHelper.postData(
        url: 'tasks',
        data: {
          'Title' : title,
          'Date':date,
          'StartTime' : startTime,
          'EndTime':endTime,
          'Description':description
        }).then((value) {
          AddTasksModel = TasksModel.fromJson(value.data);
          print(AddTasksModel!.message);
          emit(AddNewTaskSuccessful(AddTasksModel!));
    }).catchError((error){
      emit(AddNewTaskError(AddTasksModel!));
      print(AddTasksModel!.message);
      print(error.toString());
    });
  }

   TasksModel? getTasksModel;
   void getTodayTasks(String? date){
    emit(GetTasksLoading());
    DioHelper.getData(
        url: 'tasks_search/$date',
       ).then((value) {
      getTasksModel = TasksModel.fromJson(value.data);
      debugPrint('getTodayTasks >>> '  '${getTasksModel!.message}');
      emit(GetTasksSuccessful(getTasksModel!));
    }).catchError((error){
      emit(GetTasksError(getTasksModel!));
      debugPrint(getTasksModel!.message);
      debugPrint(error.toString());
    });
   }

  static TasksModel? getNotifyTasksModel;
    static Future<TasksModel?> getNotifyTasks(String? date) async {
    DioHelper.getData(
      url: 'tasks_search/$date',
    ).then((value) {
      getNotifyTasksModel = TasksModel.fromJson(value.data);
      return getNotifyTasksModel;
      debugPrint('Notify Success >>> '  '${getNotifyTasksModel!.message}');
    }).catchError((error){
      debugPrint('Notify Error >>> '  '${getNotifyTasksModel!.message}');
      return null;
      debugPrint(error.toString());
      });
    return getNotifyTasksModel;
  }


  void changeLocalToAr (BuildContext context)async {
    await context.setLocale(Locale('ar'));
    emit(ChangeLocalToArState());
  }
  void changeLocalToEn (BuildContext context) async {
    await context.setLocale(Locale('en'));
    emit(ChangeLocalToEnState());
  }

    final ImagePicker _picker = ImagePicker();
    String? base64;
    void pickImage({
      required int? lawyerID,
      required String? name,
      required String? email,
      required String? address,
      required String? role,
      required String? lawyerNationalNumber,
}) async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      var imageBytes = await image?.readAsBytes();
      base64 = const Base64Codec().encode(imageBytes!);
      updateLawyerProfilePhoto(
          lawyerID: lawyerID,
          name: name,
          email: email,
          address: address,
          role: role,
          lawyerNationalNumber: lawyerNationalNumber,
          profilePhoto: '$base64'
      );
      debugPrint(base64);
    }

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const TasksScreen(),
    LawyerProfileScreen(),
    const SettingsScreen(),
  ];

  String? gender;

  changeGenderValue(value) {
    gender = value;
    emit(ChangeGenderState());
  }

  String? role;

  changeRoleValue(value) {
    role = value;
    emit(ChangeGenderState());
  }


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