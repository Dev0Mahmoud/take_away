import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:take_away/layout/admin_cubit/states.dart';
import 'package:take_away/model/user_model.dart';
import 'package:take_away/modules/admin_modules/deinks_menu/cold_drinks_admin_screen.dart';
import 'package:take_away/modules/admin_modules/deinks_menu/hot_drinks_admin_screen.dart';
import 'package:take_away/modules/admin_modules/done_orders.dart';
import 'package:take_away/modules/admin_modules/new_orders.dart';
import 'package:take_away/shared/components/constance.dart';
import 'package:take_away/shared/network/local/cache_helper.dart';
import 'dart:io';





class AdminCubit extends Cubit <AdminStates> {
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);


  UserModel?
  userModel; // ==> my json model that i use to receive data from Firestore

  void getUserData() async {
    uId = CacheHelper.getData(key: 'uId') ?? CacheHelper.getData(key: 'uId');
    emit(LoadingGetUserDataState());
    await FirebaseFirestore.instance
        .collection('users') // ==> my Firestore collection
        .doc(uId)
        .get()
        .then((value) async {
      userModel = UserModel.fromJson(value.data()!);

      emit(SuccessGetUserDataState());
    }).catchError((error) {
      print('Error is ${error.toString()}');
      emit(ErrorGetUserDataState());
    });
  }


  int mainCurrentIndex = 0;

  void mainChangeIndex(int index) {
    mainCurrentIndex = index;

    emit(AdminChangeBottomNavState());
  }

  List<Widget> mainBottomScreen = const[
    NewOrders(),
    DoneOrders(),
  ];

  List<String> mainBottomScreenTitle = [
    'أوردرات جديدة',
    'أوردرات إتسلمت',
  ];


  int menuCurrentIndex = 0;

  void menuChangeIndex(int index) {
    menuCurrentIndex = index;

    emit(AdminChangeBottomNavState());
  }

  List<Widget> menuBottomScreen = const[
    HotDrinksAdminScreen(),
    ColdDrinksAdminScreen(),
  ];

  var picker = ImagePicker();

  File? profileImage;

  void getProfileImageFromGallery() async {
    emit(LoadingProfileImagePickedState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(SuccessProfileImagePickedState());
    } else {
      emit(ErrorProfileImagePickedState());
    }
  }

  void getProfileImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(SuccessProfileImagePickedState());
    } else {
      emit(ErrorProfileImagePickedState());
    }
  }
  void uploadProfileImage() {
    userModel!.image != '' ?
    firebase_storage.FirebaseStorage.instance.refFromURL(userModel!.image!).delete()
        : emit(LoadingProfileImagePickedState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateProfileImage(imageUrl: value);
        emit(SuccessUploadProfileImageState());
      }).catchError((e) {
        emit(ErrorUploadProfileImageState());
      });
    }).catchError((e) {
      emit(ErrorUploadProfileImageState());
    });
  }
  void updateProfileImage({required String imageUrl}) {
    UserModel model = UserModel(
      admin: true,
      address: userModel!.address,
      uId: userModel!.uId,
      email: userModel!.email,
      phone: userModel!.phone,
      name: userModel!.name,
      image: imageUrl,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((e) {
      print('Error is ${e.toString()}');
      emit(ErrorUpdateUserDataState());
    });

  }
}

