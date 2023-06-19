part of 'login_cubit.dart';

@immutable
abstract class LoginStates {}
class LoginInitial extends LoginStates {}
class LoginLoadingState extends LoginStates{}
class LoginSucessState extends LoginStates{
   final LoginModel? loginModel;
  LoginSucessState(this.loginModel);
}
class LoginErrorState extends LoginStates{
  final String error;

  LoginErrorState(this.error);
}
class ShowAndHidePassword extends LoginStates{}
class ChangeSufexIcon extends LoginStates{}
