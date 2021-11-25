import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_away/modules/main_modules/login_screen/cubit/states.dart';
import 'package:take_away/shared/components/constance.dart';



class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  IconData suffixIcon = Icons.visibility;
  bool isPassword = true;

  void changeVisibility() {
    isPassword = !isPassword;

    suffixIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(LoginVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value){

      emit(LoginSuccessState(value.user!.uid));
    })
        .catchError((error){
      emit(LoginErrorState(error.toString()));
          print('Error is ${error.toString()}');
        });
  }

}
