import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/login_model.dart';
import 'package:avocado/remoteNetwork/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvocadoLoginCubit extends Cubit<AvocadoStates>
{
  AvocadoLoginCubit() : super (InitialState());

  static AvocadoLoginCubit get(context) => BlocProvider.of(context);

  LoginModel? lawyer;
  void lawyerLogin({
    required String email,
    required String password,

  }){
    emit(LawyerLoginLoading());
    DioHelper.postData(
        url: 'auth/login',
        data: {
          'email':email,
          'password':password,
        }
    ).then((value) {
      lawyer = LoginModel.fromJson(value.data);
      print(lawyer?.status);
      emit(LawyerLoginSuccessful(lawyer!));
    }
    ).catchError((onError){
      emit(LawyerLoginError());
      print(lawyer?.message);
      print(onError);
    });
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = !isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

}
