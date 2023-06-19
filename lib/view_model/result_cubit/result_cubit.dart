import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import '../../model/Result_model;/get_result_model.dart';
import '../../model/video_model/video_model.dart';
import '../../network/dio_helper.dart';
import '../../view/componant/core/constant.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultInitial());
static ResultCubit get(context)=> BlocProvider.of<ResultCubit>(context);

  VideoModel ? videoModel;
  ResultModel? resultModel;
  getPatientsVideoInfo(String id) async{
    emit(PatientLoadingState());
    print(token);
   await  DioHelper.getData(url: 'http://127.0.0.1:8000/api/patients/$id',
        token: token).then((value)
    {
      videoModel = VideoModel.fromJson(value!.data);
      print(value.data);
      emit(PatientSuccessState());
    }).catchError((error)
    {
      if(error is DioError)
      {
        print(error.response);
      }
      print(error.toString());
      emit(PatientErrorState());
    });
  }
  Future<void>getPatientsResultInfo(String id) async{
    emit(PatientLoadingState());
    print(token);
    await  DioHelper.getData(url: 'http://127.0.0.1:8000/api/results/$id',
        token: token).then((value)
    {
      resultModel = ResultModel.fromJson(value!.data);
      print(value.data);
      emit(PatientSuccessState());
    }).catchError((error)
    {
      if(error is DioError)
      {
        print(error.response);
      }
      print(error.toString());
      emit(PatientErrorState());
    });
  }
  getPatientsDanloadVideo(String fileName) async{
    emit(DownloadLoading());
    Dio dio = Dio();
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      String filePath = '$appDocPath/$fileName';
      print(filePath);
      await dio.download("http://localhost:8000/get_video/$fileName", filePath);
      print('Download complete');
      emit(DownloadSuccessfully());

    } catch (e) {
      print(e);
    }
  }

}
