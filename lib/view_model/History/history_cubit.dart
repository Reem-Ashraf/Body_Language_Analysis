import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/model/History.dart';
import 'package:graduation_project/view_model/Camera_Scanning/camera_cubit.dart';
import 'package:meta/meta.dart';

import '../../model/patientmodel.dart';
import '../../network/dio_helper.dart';
import '../../view/componant/core/constant.dart';
import 'package:http/http.dart' as http;
import '../Camera_Scanning/camera_cubit.dart';
import '../Camera_Scanning/camera_cubit.dart';
import '../Camera_Scanning/camera_cubit.dart';
import '../layout_cubit/layout_cubit.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  get error => null;
  static HistoryCubit get(context)=>BlocProvider.of(context);
  HistoryModel? historypatientModel;
  PatientData ? pationt;
 // List<HistoryModel>?data;
  getPatientsHistory(String id){
    emit(HistoryLoadingState());
    print(token);
     DioHelper.getData(url: 'http://127.0.0.1:8000/api/patients/$id',
        token: token).then((value) {
      historypatientModel = HistoryModel.fromJson(value!.data);
      //jasonList=Response.result['']as List;
      //historypatientModel.patient!.length;
      print(value.data);
      emit(HistorySuccesState(historypatientModel!));
    }).catchError((error)
    {
      if(error is DioError)
      {
        print(error.response);
      }
      print(error.toString());
      emit(HistoryErrorState(error.toString()));
    });
  }
  Future<void> deletePatient(int index, String? token) async {
    try {
      final headers = {'Authorization': 'Bearer ${token ?? ''}'};
      final url = Uri.parse(
          'http://127.0.0.1:8000/api/patient/delete/${index}');
      final request = http.Request('DELETE', url);

      request.headers.addAll(headers);
      final response = await http.Client().send(request);

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        emit(HistorySuccesState(historypatientModel!));
      } else {
        print(response.reasonPhrase);
        emit(HistoryErrorState(error.toString()));
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text(
            'A dialog is a type of modal window that\n'
                'appears in front of app content to\n'
                'provide critical information, or prompt\n'
                'for a decision to be made.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}



