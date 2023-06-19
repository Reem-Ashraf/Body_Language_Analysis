

import 'package:graduation_project/model/patientmodel.dart';

abstract class PatientStates {}

class PatientInitial extends PatientStates {}
class ChangeStatus extends PatientStates {}
class PatientLoadingState extends PatientStates{}
class PatientSuccessState extends PatientStates{
  PatientModel patientModel;
  PatientSuccessState(this.patientModel);
}
class PatientErrorState extends PatientStates{
  final String error;
  PatientErrorState(this.error);
}
class PatientDropState extends PatientStates {}

class GetHistoryLoading extends PatientStates {}

class GetHistorySuccessfully extends PatientStates{}
class GetHistoryError extends PatientStates{}