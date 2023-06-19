part of 'result_cubit.dart';

@immutable
abstract class ResultState {}

class ResultInitial extends ResultState {}
class PatientLoadingState extends ResultState {}
class PatientSuccessState  extends ResultState {}
class PatientErrorState  extends ResultState {}
class DownloadLoading  extends ResultState {}
class DownloadSuccessfully  extends ResultState {}
class DownloadError extends ResultState {}

