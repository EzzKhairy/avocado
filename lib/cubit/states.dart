abstract class AvocadoStates{}

//general states
class InitialState extends AvocadoStates{}
class ChangeAppThemeModeState extends AvocadoStates{}
class ChangeNavBarState extends AvocadoStates{}

class GetLawyerDataLoading extends AvocadoStates{}
class GetLawyerDataSuccessful extends AvocadoStates{}
class GetLawyerDataError extends AvocadoStates{}

class LawyerRegisterLoading extends AvocadoStates{}
class LawyerRegisterSuccessful extends AvocadoStates{
  final String? statusMessage;
  LawyerRegisterSuccessful(this.statusMessage);
}
class LawyerRegisterError extends AvocadoStates{}

class ChangePasswordVisibilityState extends AvocadoStates{}
