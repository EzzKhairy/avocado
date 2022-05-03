import 'package:avocado/models/clients_model.dart';
import 'package:avocado/models/court_model.dart';
import 'package:avocado/models/court_model.dart';
import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/models/login_model.dart';

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

class GetSessionsDataLoading extends AvocadoStates{}
class GetSessionsDataSuccessful extends AvocadoStates{}
class GetSessionsDataError extends AvocadoStates{}

class GetExpertSessionDataLoading extends AvocadoStates{}
class GetExpertSessionDataSuccessful extends AvocadoStates{}
class GetExpertSessionDataError extends AvocadoStates{}

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

class GetExpensesDataLoading extends AvocadoStates{}
class GetExpensesDataSuccessful extends AvocadoStates{}
class GetExpensesDataError extends AvocadoStates{}