import 'package:avocado/models/clients_model.dart';
import 'package:avocado/models/court_model.dart';
import 'package:avocado/models/court_model.dart';
import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/models/legislation_model.dart';
import 'package:avocado/models/login_model.dart';
import 'package:avocado/models/models_model.dart';
import 'package:avocado/models/records_model.dart';
import 'package:avocado/models/tasks_model.dart';

abstract class AvocadoStates{}

//general states
class InitialState extends AvocadoStates{}
class ChangeAppThemeModeState extends AvocadoStates{}
class ChangeNavBarState extends AvocadoStates{}

class GetLawyerProfileLoading extends AvocadoStates{}
class GetLawyerProfileSuccessful extends AvocadoStates{}
class GetLawyerProfileError extends AvocadoStates{}

class GetClientsLoading extends AvocadoStates{}
class GetClientsSuccessful extends AvocadoStates{}
class GetClientsError extends AvocadoStates{}

class SearchClientsLoading extends AvocadoStates{}
class SearchClientsSuccessful extends AvocadoStates{}
class SearchClientsError extends AvocadoStates{}

class UpdateClientProfileLoading extends AvocadoStates{}
class UpdateClientProfileSuccessful extends AvocadoStates{
  final ClientsModel model;
  UpdateClientProfileSuccessful(this.model);
}
class UpdateClientProfileError extends AvocadoStates{
  final ClientsModel model;
  UpdateClientProfileError(this.model);
}

class AddNewClientLoading extends AvocadoStates{}
class AddNewClientSuccessful extends AvocadoStates{
  final ClientsModel model;
  AddNewClientSuccessful(this.model);
}
class AddNewClientError extends AvocadoStates{
  final ClientsModel model;
  AddNewClientError(this.model);
}

class UpdateLawyerProfileLoading extends AvocadoStates{}
class UpdateLawyerProfileSuccessful extends AvocadoStates{
  final LawyersModel model;
  UpdateLawyerProfileSuccessful(this.model);
}
class UpdateLawyerProfileError extends AvocadoStates{
  final LawyersModel model;
  UpdateLawyerProfileError(this.model);
}

class UpdateLawyerProfilePhotoLoading extends AvocadoStates{}
class UpdateLawyerProfilePhotoSuccessful extends AvocadoStates{
  final LawyersModel model;
  UpdateLawyerProfilePhotoSuccessful(this.model);
}
class UpdateLawyerProfilePhotoError extends AvocadoStates{
  final LawyersModel model;
  UpdateLawyerProfilePhotoError(this.model);
}

class LawyerRegisterLoading extends AvocadoStates{}
class LawyerRegisterSuccessful extends AvocadoStates{
  final LoginModel model;
  LawyerRegisterSuccessful(this.model);
}
class LawyerRegisterError extends AvocadoStates{}

class LawyerLoginLoading extends AvocadoStates{}
class LawyerLoginSuccessful extends AvocadoStates{
  final LoginModel model;
  LawyerLoginSuccessful(this.model);
}
class LawyerLoginError extends AvocadoStates{}

class ChangePasswordVisibilityState extends AvocadoStates{}

class EditPressedState extends AvocadoStates{}

class GetCasesDataLoading extends AvocadoStates{}
class GetCasesDataSuccessful extends AvocadoStates{}
class GetCasesDataError extends AvocadoStates{}

class SearchCasesDataLoading extends AvocadoStates{}
class SearchCasesDataSuccessful extends AvocadoStates{}
class SearchCasesDataError extends AvocadoStates{}

class GetSessionsDataLoading extends AvocadoStates{}
class GetSessionsDataSuccessful extends AvocadoStates{}
class GetSessionsDataError extends AvocadoStates{}
class RestSessionsDataSuccesful extends AvocadoStates{}

class GetExpertSessionDataLoading extends AvocadoStates{}
class GetExpertSessionDataSuccessful extends AvocadoStates{}
class GetExpertSessionDataError extends AvocadoStates{}

class GetInvestigationsDataLoading extends AvocadoStates{}
class GetInvestigationsDataSuccessful extends AvocadoStates{}
class GetInvestigationsDataError extends AvocadoStates{}

class GetInvestigationsPlacesDataLoading extends AvocadoStates{}
class GetInvestigationsPlacesDataSuccessful extends AvocadoStates{}
class GetInvestigationsPlacesDataError extends AvocadoStates{}

class UpdateCourtDataLoading extends AvocadoStates{}
class UpdateCourtDataSuccessful extends AvocadoStates{
  final CourtModel model;
  UpdateCourtDataSuccessful(this.model);
}
class UpdateCourtDataError extends AvocadoStates{
  final CourtModel model;
  UpdateCourtDataError(this.model);
}

class AddCourtDataLoading extends AvocadoStates{}
class AddCourtDataSuccessful extends AvocadoStates{
  final CourtModel model;
  AddCourtDataSuccessful(this.model);
}
class AddCourtDataError extends AvocadoStates{
  final CourtModel model;
  AddCourtDataError(this.model);
}

class GetCourtDataLoading extends AvocadoStates{}
class GetCourtDataSuccessful extends AvocadoStates{
  final CourtModel model;
  GetCourtDataSuccessful(this.model);
}
class GetCourtDataError extends AvocadoStates{
  final CourtModel model;
  GetCourtDataError(this.model);
}

class GetLegislationsLoading extends AvocadoStates{}
class GetLegislationsSuccessful extends AvocadoStates{
  final LegislationModel model;
  GetLegislationsSuccessful(this.model);
}
class GetLegislationsError extends AvocadoStates{
  final LegislationModel model;
  GetLegislationsError(this.model);
}

class GetModelsLoading extends AvocadoStates{}
class GetModelsSuccessful extends AvocadoStates{
  final ModelsModel model;
  GetModelsSuccessful(this.model);
}
class GetModelsError extends AvocadoStates{
  final ModelsModel model;
  GetModelsError(this.model);
}

class SearchCourtsLoading extends AvocadoStates{}
class SearchCourtsSuccessful extends AvocadoStates{}
class SearchCourtError extends AvocadoStates{}

class GetExpensesDataLoading extends AvocadoStates{}
class GetExpensesDataSuccessful extends AvocadoStates{}
class GetExpensesDataError extends AvocadoStates{}

class GetPaymentsDataLoading extends AvocadoStates{}
class GetPaymentsDataSuccessful extends AvocadoStates{}
class GetPaymentsDataError extends AvocadoStates{}

class AddNewTaskLoading extends AvocadoStates{}
class AddNewTaskSuccessful extends AvocadoStates{
  final TasksModel model;
  AddNewTaskSuccessful(this.model);
}
class AddNewTaskError extends AvocadoStates{
  final TasksModel model;
  AddNewTaskError(this.model);
}

class GetTasksLoading extends AvocadoStates{}
class GetTasksSuccessful extends AvocadoStates{
  final TasksModel model;
  GetTasksSuccessful(this.model);
}
class GetTasksError extends AvocadoStates{
  final TasksModel model;
  GetTasksError(this.model);
}


class GetRecordsDataLoading extends AvocadoStates{}
class GetRecordsDataSuccessful extends AvocadoStates{}
class GetRecordsDataError extends AvocadoStates{}

class ChangeLocalToArState extends AvocadoStates{}
class ChangeLocalToEnState extends AvocadoStates{}


class GetCasesByLawyerIdDataLoading extends AvocadoStates{}
class GetCasesByLawyerIdDataSuccessful extends AvocadoStates{}
class GetCasesByLawyerIdDataError extends AvocadoStates{}

class GetLawyersDataLoading extends AvocadoStates{}
class GetLawyersDataSuccessful extends AvocadoStates{}
class GetLawyersDataError extends AvocadoStates{}

class SearchLawyersDataLoading extends AvocadoStates{}
class SearchLawyersDataSuccessful extends AvocadoStates{}
class SearchLawyersDataError extends AvocadoStates{}

class PdfLoading extends AvocadoStates{}
class PdfSuccessful extends AvocadoStates{}
class PdfError extends AvocadoStates{}


class ChangeGenderState extends AvocadoStates{}
class ChangeRoleState extends AvocadoStates{}
class CheckAuthorizationState extends AvocadoStates{}
class ProfileImagePickedSuccessful extends AvocadoStates{}
class ProfileImagePickedError extends AvocadoStates{}

