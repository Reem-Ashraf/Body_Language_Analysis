import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/network/dio_helper.dart';
import 'package:graduation_project/view/componant/core/constant.dart';
import 'package:meta/meta.dart';

import '../../model/User_Model.dart';

part 'user_model_state.dart';

class UserModelCubit extends Cubit<UserModelState> {
  UserModelCubit() : super(UserModelInitial());
  static UserModelCubit get(context)=>BlocProvider.of(context);
  UserModel? userModel;
  void profile()
  {
    DioHelper.getData(url: 'http://127.0.0.1:8000/api/me',token: token).
    then((value) {
      userModel = UserModel.fromJson(value!.data);

      print("profile data:");
      print(value.data);
      emit(UserModelSuccessState());
      print("Success");


    }).catchError((error) {
      emit(UserModelErrorState());
      print("Error");
    });

  }

}
