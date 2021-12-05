import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_away/layout/admin_cubit/cubit.dart';
import 'package:take_away/shared/bloc_observer.dart';
import 'package:take_away/shared/components/constance.dart';
import 'package:take_away/shared/network/local/cache_helper.dart';
import 'package:take_away/shared/styles/themes.dart';
import 'package:take_away/layout/main_cubit/cubit.dart';
import 'package:take_away/layout/main_cubit/states.dart';
import 'layout/main_layout.dart';
import 'modules/main_modules/login_screen/login_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  dId = 0;
  oId = 0;
  uId = CacheHelper.getData(key: 'uId')??CacheHelper.getData(key: 'uId');
  if(uId != null){

    widget = const MainLayout();
  }else{
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}
class MyApp extends StatelessWidget
{
  Widget? startWidget;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MainLayCubit()..getHotDrinksData()..getColdDrinksData(),
        ),
        BlocProvider(
          create: (BuildContext context) => AdminCubit()..getHotDrinksData()..getColdDrinksData(),
        ),
      ],
      child: BlocConsumer<MainLayCubit, MainLayStates>(

          listener: (context,state){},
          builder: (context,state) {

            return MaterialApp(

              theme:lightTheme,
              darkTheme:  darkTheme,
              themeMode: ThemeMode.system,
              debugShowCheckedModeBanner: false,
              home: startWidget,
            );
          }
      ),
    );
  }

}