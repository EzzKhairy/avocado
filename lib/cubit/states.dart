import 'package:avocado/models/lawyers_model.dart';

abstract class AvocadoStates{}

//general states
class InitialState extends AvocadoStates{}
class ChangeAppThemeModeState extends AvocadoStates{}
class ChangeNavBarState extends AvocadoStates{}

class GetLawyerProfileLoading extends AvocadoStates{}
class GetLawyerProfileSuccessful extends AvocadoStates{}
class GetLawyerProfileError extends AvocadoStates{}

class LawyerRegisterLoading extends AvocadoStates{}
class LawyerRegisterSuccessful extends AvocadoStates{
  final LawyersModel model;
  LawyerRegisterSuccessful(this.model);
}
class LawyerRegisterError extends AvocadoStates{}

class LawyerLoginLoading extends AvocadoStates{}
class LawyerLoginSuccessful extends AvocadoStates{
  final LawyersModel model;
  LawyerLoginSuccessful(this.model);
}
class LawyerLoginError extends AvocadoStates{}

class ChangePasswordVisibilityState extends AvocadoStates{}
