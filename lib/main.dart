import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/model/shaerd_prefrense/shaerd_prefrense.dart';
import 'package:graduation_project/network/dio_helper.dart';
import 'package:graduation_project/view/camera.dart';
import 'package:graduation_project/view/componant/core/constant.dart';
import 'package:graduation_project/view/componant/pages/lay_out/HomeLayOut.dart';
import 'package:graduation_project/view/componant/pages/lay_out/myHomePage.dart';
import 'package:graduation_project/view/componant/pages/screens%20in%20Home%20Page/camera_detection.dart';
import 'package:graduation_project/view_model/Camera_Scanning/camera_cubit.dart';
import 'package:graduation_project/view_model/History/history_cubit.dart';
import 'package:graduation_project/view_model/bloc_observer/bloc_observer.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:graduation_project/view_model/result_cubit/result_cubit.dart';
import 'package:window_size/window_size.dart';
//import 'package:window_size/window_size.dart';
//import 'package:window_size/window_size.dart';

//import 'network/dio_helper.dart';
import 'view/componant/pages/authonication/login.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    setWindowMinSize( Size(400, 300));
    setWindowMaxSize(Size.infinite);
  }


  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  if (runWebViewTitleBarWidget(args)) {
    return;
  }

  DioHelper.init();
  print(token);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => HistoryCubit()),

      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,

          home: CacheHelper.getData(key: 'access_token') != null
              ? HomeLayOut()
              : Login(),

      ),
    );
  }
}


