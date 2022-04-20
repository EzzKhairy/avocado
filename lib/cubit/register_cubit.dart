import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/lawyers_model.dart';
import 'package:avocado/remoteNetwork/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<AvocadoStates> {
  RegisterCubit() : super (InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  Lawyers? lawyer;
  void lawyerRegister({
    required String lawyerNationalNumber,
    required String name,
    required String email,
    required String password
  }){
    emit(LawyerRegisterLoading());
    DioHelper.postData(
        url: 'lawyer',
        query: {
          'Lawyer_National_Number' : lawyerNationalNumber,
          'name':name,
          'email':email,
          'password':password
        }
    ).then((value) {
      //print(element);
      print(value.statusMessage);
      emit(LawyerRegisterSuccessful(value.statusMessage));
    }
    ).catchError((onError){
      emit(LawyerRegisterError());
      print(onError);
    });
  }

}