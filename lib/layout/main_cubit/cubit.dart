import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_away/data/dialoge_options.dart';
import 'package:take_away/layout/main_cubit/states.dart';
import 'package:take_away/model/drinks_model.dart';
import 'package:take_away/model/order_model.dart';
import 'package:take_away/model/user_model.dart';
import 'package:take_away/modules/main_modules/drinks_screen/cold_drinks_screen.dart';
import 'package:take_away/modules/main_modules/drinks_screen/hot_drinks_screen.dart';
import 'package:take_away/shared/components/constance.dart';
import 'package:take_away/shared/network/local/cache_helper.dart';

class MainLayCubit extends Cubit<MainLayStates> {
  MainLayCubit() : super(MainLayInitialState());

  static MainLayCubit get(context) => BlocProvider.of(context);


  UserModel?
  userModel; // ==> my json model that i use to receive data from Firestore

  void getUserData() async{
    uId = CacheHelper.getData(key: 'uId')??CacheHelper.getData(key: 'uId');

    emit(LoadingGetUserDataState());
    await FirebaseFirestore.instance
        .collection('users') // ==> my Firestore collection
        .doc(uId)
        .get()
        .then((value) async {
      final userModel =  UserModel.fromJson(value.data()!);
      if(userModel.admin!) {
        emit(AdminUserState());
      } else {
        emit(NormalUserState());
      }
      // print(value.data()!.toString());
      emit(SuccessGetUserDataState());
    }).catchError((error) {
      print('Error is ${error.toString()}');
      emit(ErrorGetUserDataState());
    });

  }


  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;

    emit(MainLayChangeBottomNavState());
  }

  List<Widget> bottomScreen = [
    const HotDrinksScreen(),
    const ColdDrinks(),
  ];



  void drinkTypePressed(int index) {
    drinkTypeIndex = index;

    drinkTypeSelected = [
      false,
      false,
    ];

    drinkTypeSelected[index] = !drinkTypeSelected[index];
    forEditDrinkTypeSelected = drinkTypeSelected;
    emit(MainLayDrinkTypeSelected());
  }



  void drinkQuantityPressed(int index) {
    drinkQuantityIndex = index;
    drinkQuantitySelected = [false, false, false];
    drinkQuantitySelected[index] = !drinkQuantitySelected[index];
    forEditDrinkQuantitySelected = drinkQuantitySelected;
    emit(MainLayDrinkQuantitySelected());
  }



  void glassTypePressed(int index) {
    glassTypeIndex = index;
    glassTypeSelected = [false, false, false];
    glassTypeSelected[index] = !glassTypeSelected[index];
    forEditGlassTypeSelected = glassTypeSelected;
    emit(MainLayGlassTypeSelected());
  }



  void sugarPressed(int index) {
    sugarIndex = index;
    sugarSelected = [false, false, false, false];
    sugarSelected[index] = !sugarSelected[index];
    forEditSugarSelected = sugarSelected;
    emit(MainLaySugarSelected());
  }
  void coldDrinkSugarPressed(int index) {
    coldDrinkSugarIndex = index;
    coldDrinkSugarSelected = [false, false, false,];
    coldDrinkSugarSelected[index] = !coldDrinkSugarSelected[index];
    emit(MainLayCDSugarSelected());
  }


  void coffeeTypePressed(int index) {
    coffeeTypeIndex = index;
    coffeeTypeSelected = [
      false,
      false,
    ];
    coffeeTypeSelected[index] = !coffeeTypeSelected[index];
    forEditCoffeeTypeSelected = coffeeTypeSelected;
    emit(MainLayCoffeeTypeSelected());
  }



  void coffeeLevelPressed(int index) {
    coffeeLevelIndex = index;
    coffeeLevelSelected = [false, false, false];
    coffeeLevelSelected[index] = !coffeeLevelSelected[index];
    forEditCoffeeLevelSelected = coffeeLevelSelected;
    emit(MainLayCoffeeLevelSelected());
  }

  void singleCoffeeGlassTypePressed(int index) {
    singleCoffeeGlassTypeIndex = index;
    singleCoffeeGlassTypeSelected = [false, false, false];
    singleCoffeeGlassTypeSelected[index] = !singleCoffeeGlassTypeSelected[index];
    forEditSingleCoffeeGlassTypeSelected = singleCoffeeGlassTypeSelected;
    emit(MainLaySingleCoffeeGlassTypeSelected());
  }

  void doubleCoffeeGlassTypePressed(int index) {
    doubleCoffeeGlassTypeIndex = index;
    doubleCoffeeGlassTypeSelected = [
      false,
      false,
    ];
    doubleCoffeeGlassTypeSelected[index] = !doubleCoffeeGlassTypeSelected[index];
    forEditDoubleCoffeeGlassTypeSelected = doubleCoffeeGlassTypeSelected;
    emit(MainLayDoubleCoffeeGlassTypeSelected());
  }


  void coffeeDoublePressed(int index) {
    coffeeDoubleIndex = index;
    coffeeDoubleSelected[index] = !coffeeDoubleSelected[index];
    isCoffeeDouble = coffeeDoubleSelected[index];
    forEditCoffeeDoubleSelected = coffeeDoubleSelected;
    emit(MainLayCoffeeDoubleSelected());
  }



  void coffeeSugarPressed(int index) {
    coffeeSugarIndex = index;
    coffeeSugarSelected = [false, false, false, false, false, false];
    coffeeSugarSelected[index] = !coffeeSugarSelected[index];
    forEditCoffeeSugarSelected = coffeeSugarSelected;

    emit(MainLayCoffeeSugarSelected());
  }

  OrderModel? orderModel;
  List<OrderModel> orders = [];
  List<OrderModel> favOrder = [];
  int? orderIndex;

  String? otherA;

  List<DrinksModel> hotDrinksMenu = [];

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

  List<DrinksModel> coldDrinksMenu = [];

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



  void orderComplete(
      {required DrinksModel model,
      required String otherAdd,
      }) async{
    emit(MainLayOrderLoading());
    if (model.drinkName == 'قهوة') {
      otherA = otherAdd;
      orderModel = OrderModel(
        uId: uId!,
        id: oId,
        orderTime: TimeOfDay.now().toString(),
        otherAdd: otherAdd,
        coffeeLevel: coffeeLevel(coffeeLevelIndex),
        isDouble: isCoffeDouble(isCoffeeDouble),
        doubleGlassType:
        coffeeDoubleGlassType(doubleCoffeeGlassTypeIndex, isCoffeeDouble),
        coffeeType: coffeeType(coffeeTypeIndex),
        cSugarType: coffeeSugar(coffeeSugarIndex),
        sCGlassType:
        coffeeSingleGlassType(singleCoffeeGlassTypeIndex, isCoffeeDouble),
        drinkImage: model.drinkImage,
        drinkName: model.drinkName,
      );
      await FirebaseFirestore.instance.collection('users').doc(uId)
          .collection('orders')
          .doc('${orderModel!.id}')
          .set(orderModel!.toMap())
          .then((value) {
        CacheHelper.saveData(key: 'oId', value: ++oId);
        emit(MainLayOrderDone());
      }).catchError((error) {
        print('Error is ${error.toString()}');
      });
      coffeeTypeIndex = 1;
      coffeeLevelIndex = 1;
      singleCoffeeGlassTypeIndex = 2;
      doubleCoffeeGlassTypeIndex = 1;
      coffeeDoubleIndex = 0;
      coffeeSugarIndex = 5;
      coffeeTypeSelected = [false, true];
      coffeeLevelSelected = [false, true, false];
      singleCoffeeGlassTypeSelected = [false, false, true];
      doubleCoffeeGlassTypeSelected = [false, true];
      isCoffeeDouble = false;
      coffeeDoubleSelected = [isCoffeeDouble];
      coffeeSugarSelected = [false, false, false, false, false, true];
      emit(MainLayOrderDone());
    } else {
      otherA = otherAdd;
      orderModel = OrderModel(
          uId: uId!,
          id: oId,
          drinkName: model.drinkName,
          drinkImage: model.drinkImage,
          orderTime: TimeOfDay.now().toString(),
          drinkType: drinkType(drinkTypeIndex, model),
          glassType: glassType(glassTypeIndex),
          sugarType: sugarQuantity(sugarIndex),
          drinkQuantity: drinkQuantity(drinkQuantityIndex, drinkTypeIndex,model),
          otherAdd: otherAdd);
      await FirebaseFirestore.instance.collection('users').doc(uId)
          .collection('orders')
          .doc('${orderModel!.id}')
          .set(orderModel!.toMap())
          .then((value) {
        CacheHelper.saveData(key: 'oId', value: ++oId);
        emit(MainLayOrderDone());
      }).catchError((error) {
        // emit(ErrorAddDrinkState());
        print('Error is ${error.toString()}');
      });
      // orders.add(orderModel!);
      drinkTypeIndex = 0;
      drinkQuantityIndex = 1;
      glassTypeIndex = 2;
      sugarIndex = 0;
      drinkTypeSelected = [true, false,];
      drinkQuantitySelected = [false, true, false];
      glassTypeSelected = [false, false, true];
      sugarSelected = [true, false, false, false];
      emit(MainLayOrderDone());
    }
  }
  
  
  void getUserOrders()async{
    emit(LoadingGetOrdersDataState());
     FirebaseFirestore.instance
        .collection('users').doc(uId).collection('orders').orderBy('orderTime').snapshots()
        .listen((event) {
      orders = [];
      for (var element in event.docs) {
        orders.add(OrderModel.fromJson(element.data()));
      }
      emit(SuccessGetOrdersDataState());
    });
  }

  void deleteOrder({required int id,}) async{
    emit(MainLayOrderDeleteLoading());
    await FirebaseFirestore.instance.collection('users').doc(uId)
        .collection('orders')
        .doc('$id')
        .delete();

  }



  void addFavOrder({required int index,}) {
    emit(MainLayFavOrderLoading());
    if(favOrder.contains(orders[index])){
      emit(MainLayFavOrderExisting());
    }
    else {
      favOrder.add(orders[index]);
      emit(MainLayFavOrderDone());
    }
  }
  void deleteFavOrder({required int index,}) {
    emit(MainLayOrderDeleteLoading());
    favOrder.removeAt(index);
    emit(MainLayOrderDeleteDone());
  }

  void orderFav({required int index,}) {
    orders.add(favOrder[index]);
    emit(MainLayOrderDone());
  }





}
