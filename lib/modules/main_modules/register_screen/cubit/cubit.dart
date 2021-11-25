import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_away/model/user_model.dart';
import 'package:take_away/modules/main_modules/register_screen/cubit/states.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData passwordSuffixIcon = Icons.visibility;
  IconData confirmedPasswordSuffixIcon = Icons.visibility;
  bool isPassword = true;

  void changeVisibility() {
    isPassword = !isPassword;

    passwordSuffixIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterVisibilityState());
  }

  bool isConfirmPassword = true;

  void changeConfirmVisibility() {
    isConfirmPassword = !isConfirmPassword;

    confirmedPasswordSuffixIcon = isConfirmPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterVisibilityState());
  }



  Future<void> userRegister({
    required String name,
    required String phone,
    required String address,
    required String email,
    required String password,
  })async {
    emit(RegisterLoadingState());
   await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        name: name,
        email: email,
        address: address,
        uId: value.user!.uid,
        phone: phone,


      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      print('Error is ${error.toString()}');
    });
  }



  Future<void> userCreate({
    required String name,
    required String phone,
    required String address,
    required String email,
    required String uId,
  }) async{
    UserModel model = UserModel(
      name: name,
      email: email,
      address: address,
      image: '',
      phone: phone,
      uId: uId,
      admin: false,
    );
   await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState(uId,));
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
      print('Error is ${error.toString()}');
    });
  }



}
