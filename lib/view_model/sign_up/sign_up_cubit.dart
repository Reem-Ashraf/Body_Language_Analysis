import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/model/login_model/login_model.dart';
import 'package:graduation_project/model/signup_model/signup_model.dart';
import 'package:graduation_project/network/end_points.dart';
import 'package:meta/meta.dart';

import '../../model/signup_model/signup_model.dart';
import '../../model/signup_model/signup_model.dart';
import '../../network/dio_helper.dart';
import '../../view/componant/pages/authonication/login.dart';
import '../../view/componant/pages/lay_out/myHomePage.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  static SignUpCubit Get(context)=>BlocProvider.of(context);
  bool isSecure=true;
  Widget suffixIcon= Icon(Icons.visibility_off);
  Widget suffixIcon2=Icon(Icons.visibility_off);
  void ObSecure(){
    isSecure=!isSecure;
    isSecure
        ? suffixIcon =Icon(Icons.visibility_off)
        : suffixIcon=Icon(Icons.remove_red_eye);
    emit(ChangeSufexIcon());
  }
  bool secure=true;
  void Secure(){
    secure=!secure;
    secure
        ? suffixIcon2 =Icon(Icons.visibility_off)
        : suffixIcon2=Icon(Icons.remove_red_eye);
    emit(ShowAndHidePassword());
  }

  List<String> items=["Student","Doctor"];
  //initialization
   String? drobdownValue;
  void drobdownChoice(String?Iteam){
    drobdownValue=Iteam!;
    emit(Dropdownbutton());

  }

  //use for signup
  Future postSignup(context , String name, String email,String password, String confirmPassword) async {
    var json = {
      "name": name,
      "email": email,
      "password": password,
      "confirm_password": confirmPassword
      // "phoneNumber": phoneNumberController.text.toString(),
      // "gender" : gender == "Male" ? 'm' : 'f',
      // 'roleId' : 2,
      // 'universityId' : universityModel!.List_UniversityData[int.parse(university)].id,
      // 'gradeId': int.parse(grade.split(" ")[1])
    };
    DioHelper.postData(url: SIGNUP, data: json).then((value)
    {
       print("hii");
      emit(SignupSuccessState());
    }).catchError((error) {
      print(error);

      print("error");
      emit(SignupErrorState());
      throw error;
    });
  }


}
