import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/login_model.dart';
import 'package:avocado/remoteNetwork/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<AvocadoStates> {
  RegisterCubit() : super (InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  LoginModel? lawyer;
  void lawyerRegister({
    required String lawyerNationalNumber,
    required String name,
    required String email,
    required String password,
    required String confirmPassword

  }){
    emit(LawyerRegisterLoading());
    DioHelper.postData(
        url: 'auth/signup',
        data: {
          'Lawyer_National_Number' : lawyerNationalNumber,
          'name':name,
          'email':email,
          'password':password,
          'password_confirmation':confirmPassword
        }
    ).then((value) {
      lawyer = LoginModel.fromJson(value.data);
      print(lawyer?.status);
      emit(LawyerRegisterSuccessful(lawyer!));
    }
    ).catchError((onError){
      emit(LawyerRegisterError());
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


  IconData confirmSuffix = Icons.visibility_outlined;
  bool isConfirmPassword = true;

  void changeConfirmPasswordVisibility(){
    isConfirmPassword = !isConfirmPassword;
    confirmSuffix = !isConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }


}