// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'camera_state.dart';
//
// class CameraCubit extends Cubit<CameraState> {
//   CameraCubit() : super(CameraInitial());
//   static CameraCubit Get(context)=>BlocProvider.of(context);
//   bool status=true;
//   String open="Opened";
//   String clos="Closed ";
//
//   void changeStatus(){
//     status=!status;
//     status
//         ? open
//         :clos;
//     emit(ChangeStatus());
//   }
// }
// // import 'package:bloc/bloc.dart';
// // import 'package:flutter/material.dart';
// // import 'package:graduation_project/model/shaerd_prefrense/shaerd_prefrense.dart';
// // import 'package:graduation_project/network/dio_helper.dart';
// // import 'package:graduation_project/view/camera.dart';
// // import 'package:graduation_project/view/componant/pages/lay_out/myHomePage.dart';
// // import 'package:graduation_project/view_model/bloc_observer/bloc_observer.dart';
// // import 'package:desktop_webview_window/desktop_webview_window.dart';
// //
// // //import 'network/dio_helper.dart';
// // import 'view/componant/pages/authonication/login.dart';
// //
// // void main(List<String> args) async{
// //   Bloc.observer = MyBlocObserver();
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await CacheHelper.init();
// //   if (runWebViewTitleBarWidget(args)) {
// //     return;
// //   }
// //
// //   DioHelper.init();
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //
// //       home:CacheHelper.getData(key: 'access_token')!=null? MyHomePage() : Login(),
// //     );
// //   }
// // }
//
//
//
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/model/patientmodel.dart';
import 'package:graduation_project/network/dio_helper.dart';
import 'package:graduation_project/view/componant/core/constant.dart';
import 'package:graduation_project/view_model/Camera_Scanning/camera_state.dart';

import '../../model/video_model/video_model.dart';

class PatientCubit extends Cubit<PatientStates> {
  PatientCubit() : super(PatientInitial());

  static PatientCubit get(context) => BlocProvider.of(context);

  PatientModel? patientModel;
  PatientData ? pationt;

  getPatients(){
    emit(PatientLoadingState());
    print(token);
    DioHelper.getData(url: 'http://127.0.0.1:8000/api/patients/user',
        token: token,).then((value) {
      patientModel = PatientModel.fromJson(value!.data);
      print(value.data);
      emit(PatientSuccessState(patientModel!));
}).catchError((error)
    {
      if(error is DioError)
      {
       print(error.response);
      }
  print(error.toString());
  emit(PatientErrorState(error.toString()));
});
  }



   patientDrop() {
    for (var v in patientModel!.patients!) {
      patientDropDownItemList.add({'label': v.patientName, 'value': v.id.toString()});
    }
    emit(PatientDropState());
  }

  int patientcurrentindexdrop = 0;
  List patientDropDownItemList = [
    {'label': 'None', 'value': '0'},

  ];

}