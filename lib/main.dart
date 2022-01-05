import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_away/layout/admin_cubit/cubit.dart';
import 'package:take_away/shared/bloc_observer.dart';
import 'package:take_away/shared/components/constance.dart';
import 'package:take_away/shared/network/local/cache_helper.dart';
import 'package:take_away/shared/styles/themes.dart';
import 'package:take_away/layout/user_cubit/cubit.dart';
import 'package:take_away/layout/user_cubit/states.dart';
import 'layout/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  dId = 0;
  oId = 0;
  uId = CacheHelper.getData(key: 'uId')??CacheHelper.getData(key: 'uId');
  // if(uId != null){
  //
  //   widget = const SplashScreen();
  // }else{
  //   widget = LoginScreen();
  // }
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => UserCubit()..getHotDrinksData()..getColdDrinksData(),
        ),
        BlocProvider(
          create: (BuildContext context) => AdminCubit()..getHotDrinksData()..getColdDrinksData()
        ),
      ],
      child: BlocConsumer<UserCubit, UserStates>(

          listener: (context,state){},
          builder: (context,state) {

            return MaterialApp(

              theme:lightTheme,
              darkTheme:  darkTheme,
              themeMode: ThemeMode.system,
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
            );
          }
      ),
    );
  }

}