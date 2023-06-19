import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/view/componant/pages/screens%20in%20Home%20Page/camera.dart';
import 'package:graduation_project/view/componant/pages/student_screens/student_history.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  static LayoutCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget> Screen=[
    //CameraScreen(),
   // StudentHistory()
  ];
  void ChangeIndex(int index){
    currentIndex=index;
    emit(ChangeIndexState());
  }
}
