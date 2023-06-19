part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}
class HistoryLoadingState extends HistoryState{}
class HistorySuccesState extends HistoryState{
  late HistoryModel historyModel;
  HistorySuccesState(this.historyModel);
}
class HistoryErrorState extends HistoryState{

  final String error;

  HistoryErrorState(this.error);
}

