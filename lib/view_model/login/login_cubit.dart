import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Data/models/LoginModel.dart';
import 'package:graduation_project/model/shaerd_prefrense/shaerd_prefrense.dart';
import 'package:graduation_project/network/dio_helper.dart';
import 'package:graduation_project/network/end_points.dart';
import 'package:meta/meta.dart';

import '../../model/login_model/login_model.dart';
import '../../view/componant/core/constant.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());
  //create an object from this cubit and to be more eisly when using this cubit
  static LoginCubit Get(context)=>BlocProvider.of(context);
  LoginModel? loginModelodel;
  bool isSecure=true;
  Widget suffixIcon= Icon(Icons.visibility_off);
  // Icon suffixIcon2=Icon(Icons.visibility_off);
  void ObSecure(){
   isSecure=!isSecure;
   isSecure
       ? suffixIcon =Icon(Icons.visibility_off)
       : suffixIcon=Icon(Icons.remove_red_eye);
   emit(ShowAndHidePassword());
  }

  void userLogin({required String email ,required String password}){
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      "email":email,
      "password":password
    }).then((value) {
      //value.statusCode
      print(value?.data);
      loginModelodel=LoginModel.fromJson(value?.data);
      CacheHelper.saveData(key: accessTokenKey, value: loginModelodel!.accessToken);
      print("//////////////////////");
      print(loginModelodel!.accessToken);
      print("//////////////////////");

      print(loginModelodel!.message);
      //print(loginModelodel!.data!.token);
      emit(LoginSucessState(loginModelodel));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }


}
