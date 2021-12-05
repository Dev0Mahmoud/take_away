import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:take_away/layout/admin_cubit/states.dart';
import 'package:take_away/model/drinks_model.dart';
import 'package:take_away/model/order_model.dart';
import 'package:take_away/model/user_model.dart';
import 'package:take_away/modules/admin_modules/deinks_menu/cold_drinks_admin_screen.dart';
import 'package:take_away/modules/admin_modules/deinks_menu/hot_drinks_admin_screen.dart';
import 'package:take_away/modules/admin_modules/done_orders.dart';
import 'package:take_away/modules/admin_modules/new_orders.dart';
import 'package:take_away/shared/components/constance.dart';
import 'package:take_away/shared/network/local/cache_helper.dart';
import 'dart:io';

class AdminCubit extends Cubit<AdminStates> {
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

  List<Widget> mainBottomScreen = const [
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

  List<Widget> menuBottomScreen = const [
    HotDrinksAdminScreen(),
    ColdDrinksAdminScreen(),
  ];

  var profilePicker = ImagePicker();
  File? profileImage;

  void getProfileImageFromGallery() async {
    emit(LoadingProfileImagePickedState());
    final pickedFile =
        await profilePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(SuccessProfileImagePickedState());
    } else {
      emit(ErrorProfileImagePickedState());
    }
  }

  void getProfileImageFromCamera() async {
    final pickedFile =
        await profilePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(SuccessProfileImagePickedState());
    } else {
      emit(ErrorProfileImagePickedState());
    }
  }

  void uploadProfileImage() {
    userModel!.image != ''
        ? deleteProfileImage()
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


  void deleteProfileImage() async {
    await firebase_storage.FirebaseStorage.instance
        .refFromURL(userModel!.image!)
        .delete();
    UserModel model = UserModel(
      admin: true,
      address: userModel!.address,
      uId: userModel!.uId,
      email: userModel!.email,
      phone: userModel!.phone,
      name: userModel!.name,
      image: '',
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

  List<DrinksModel> hotDrinksMenu = [];
  List<DrinksModel> coldDrinksMenu = [];
  DrinksModel? drinksModel;

  void getHotDrinksData() async {
    emit(LoadingGetDrinksDataState());

    await FirebaseFirestore.instance
        .collection('hotDrinksMenu').snapshots()
    .listen((event) {
      hotDrinksMenu = [];
      for (var element in event.docs) {
        hotDrinksMenu.add(DrinksModel.fromJson(element.data()));
      }
      emit(SuccessGetDrinksDataState());
    });

    // await FirebaseFirestore.instance
    //     .collection('hotDrinksMenu')
    //     .get()
    //     .then((value) async {
    //   value.docs.forEach((element) {
    //     hotDrinksMenu = [];
    //      element.reference.snapshots().listen((event) {
    //       drinkId.add(element.id);
    //       hotDrinksMenu.add(DrinksModel.fromJson(element.data()));
    //     });
    //   });
    //   emit(SuccessGetDrinksDataState());
    // }).catchError((error) {
    //   print('Error is ${error.toString()}');
    //   emit(ErrorGetDrinksDataState());
    // });
  }

  void addNewHotDrink({
    required String drinkName,
    required String drinkImage,
  }) async {
    emit(LoadingAddDrinkState());
    DrinksModel model = DrinksModel(
      id: dId,
      drinkName: drinkName,
      drinkImage: drinkImage,
    );
    await FirebaseFirestore.instance
        .collection('hotDrinksMenu')
        .doc('${model.id}')
        .set(model.toMap())
        .then((value) {
          CacheHelper.saveData(key: 'dId', value: ++dId);
          drinkImageUrl = '';
          getHotDrinksData();
      emit(SuccessAddDrinkState());
    }).catchError((error) {
      emit(ErrorAddDrinkState());
      print('Error is ${error.toString()}');
    });
  }

  void updateHotDrinkData({required String imageUrl,required String drinkName,required int id,}) {
    DrinksModel model = DrinksModel(
      id: id,
      drinkName: drinkName,
      drinkImage: imageUrl,
    );
    FirebaseFirestore.instance
        .collection('hotDrinksMenu')
        .doc('${model.id}')
        .update(model.toMap())
        .then((value) {
      getHotDrinksData();
    }).catchError((e) {
      print('Error is ${e.toString()}');
      emit(ErrorUpdateDrinkDataState());
    });
  }

  void deleteHotDrink({required int id,}) {
    FirebaseFirestore.instance
        .collection('hotDrinksMenu')
        .doc('$id')
        .delete()
        .then((value) {
      getHotDrinksData();
    }).catchError((e) {
      print('Error is ${e.toString()}');
      emit(ErrorUpdateDrinkDataState());
    });
  }

  void getColdDrinksData() async {
    emit(LoadingGetDrinksDataState());

    await FirebaseFirestore.instance
        .collection('coldDrinksMenu').snapshots()
        .listen((event) {
      coldDrinksMenu = [];
      for (var element in event.docs) {
        coldDrinksMenu.add(DrinksModel.fromJson(element.data()));
      }
      emit(SuccessGetDrinksDataState());
    });

    // await FirebaseFirestore.instance
    //     .collection('hotDrinksMenu')
    //     .get()
    //     .then((value) async {
    //   value.docs.forEach((element) {
    //     hotDrinksMenu = [];
    //      element.reference.snapshots().listen((event) {
    //       drinkId.add(element.id);
    //       hotDrinksMenu.add(DrinksModel.fromJson(element.data()));
    //     });
    //   });
    //   emit(SuccessGetDrinksDataState());
    // }).catchError((error) {
    //   print('Error is ${error.toString()}');
    //   emit(ErrorGetDrinksDataState());
    // });
  }

  void addNewColdDrink({
    required String drinkName,
    required String drinkImage,
  }) async {

    emit(LoadingAddDrinkState());
    DrinksModel model = DrinksModel(
      id: dId,
      drinkName: drinkName,
      drinkImage: drinkImage,
    );
    await FirebaseFirestore.instance
        .collection('coldDrinksMenu')
        .doc('${model.id}')
        .set(model.toMap())
        .then((value) {
      CacheHelper.saveData(key: 'dId', value: ++dId);
      drinkImageUrl = '';
      getColdDrinksData();
      emit(SuccessAddDrinkState());
    }).catchError((error) {
      emit(ErrorAddDrinkState());
      print('Error is ${error.toString()}');
    });
  }

  void updateColdDrinkData({required String imageUrl,required String drinkName,required int id,}) {
    DrinksModel model = DrinksModel(
      id: id,
      drinkName: drinkName,
      drinkImage: imageUrl,
    );
    FirebaseFirestore.instance
        .collection('coldDrinksMenu')
        .doc('${model.id}')
        .update(model.toMap())
        .then((value) {
      getColdDrinksData();
    }).catchError((e) {
      print('Error is ${e.toString()}');
      emit(ErrorUpdateDrinkDataState());
    });
  }

  void deleteColdDrink({required int id,}) {
    FirebaseFirestore.instance
        .collection('coldDrinksMenu')
        .doc('$id')
        .delete()
        .then((value) {
      getHotDrinksData();
    }).catchError((e) {
      print('Error is ${e.toString()}');
      emit(ErrorUpdateDrinkDataState());
    });
  }

  var drinkImagePicker = ImagePicker();
  File? drinkImage;
  String? drinkImageUrl = '';
  void getDrinkImageFromGallery() async {
    emit(LoadingDrinkImagePickedState());
    final pickedFile =
        await drinkImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      drinkImage = File(pickedFile.path);
      uploadDrinkImage();
      emit(SuccessDrinkImagePickedState());
    } else {
      emit(ErrorDrinkImagePickedState());
    }
  }

  void getDrinkImageFromCamera() async {
    emit(LoadingDrinkImagePickedState());
    final pickedFile =
        await drinkImagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      drinkImage = File(pickedFile.path);
      uploadDrinkImage();
      emit(SuccessDrinkImagePickedState());
    } else {
      emit(ErrorDrinkImagePickedState());
    }
  }


  void uploadDrinkImage() {
    // drinksModel!.drinkImage != ''
    //     ? firebase_storage.FirebaseStorage.instance
    //         .refFromURL(drinksModel!.drinkImage)
    //         .delete()
    //     :
    emit(LoadingDrinkImagePickedState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('DrinksMenu/${Uri.file(drinkImage!.path).pathSegments.last}')
        .putFile(drinkImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        drinkImageUrl = value;

        // updateDrinkImage(imageUrl: value,);
        emit(SuccessUploadDrinkImageState());
      }).catchError((e) {
        emit(ErrorUploadDrinkImageState());
      });
    }).catchError((e) {
      emit(ErrorUploadDrinkImageState());
    });
  }


  List<OrderModel> newOrders = [];

  void getUserOrders()async{
    emit(LoadingGetOrdersDataState());

    FirebaseFirestore.instance
        .collection('users').get().asStream().listen((event) {
      for (var user in event.docs) {

        user.reference.collection('orders').get().asStream().listen((event) {
          newOrders = [];
          for(var order in event.docs){
            newOrders.add(OrderModel.fromJson(order.data()));
          }
          emit(SuccessGetOrdersDataState());
        });

    }
        });
  }

  UserModel? userDetails;
  void getUsersDetails({required String uId})async{

    await FirebaseFirestore.instance
        .collection('users').doc(uId).get().then((value) {
          userDetails = UserModel.fromJson(value.data()!);
    }).catchError((Error){});
  }

}
