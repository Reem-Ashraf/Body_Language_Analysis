part of 'user_model_cubit.dart';

@immutable
abstract class UserModelState {}

class UserModelInitial extends UserModelState {}
class UserModelLoadingState extends UserModelState{}
class UserModelSuccessState extends UserModelState{}
class UserModelErrorState extends UserModelState{}
