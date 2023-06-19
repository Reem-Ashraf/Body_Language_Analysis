part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}
class ShowAndHidePassword extends SignUpState{}
class ChangeSufexIcon extends SignUpState{}
class Dropdownbutton extends SignUpState{}
class SignUpLoadingState extends SignUpState{}
class SignupSuccessState extends SignUpState{
  // late final LoginModel? loginModel;
  // SignupSuccessState(this.loginModel);

}
class SignupErrorState extends SignUpState{}
