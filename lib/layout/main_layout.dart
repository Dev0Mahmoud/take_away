import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_away/layout/admin_layout.dart';
import 'package:take_away/modules/main_modules/drinks_screen/user_order_screen.dart';
import 'package:take_away/modules/main_modules/login_screen/login_screen.dart';
import 'package:take_away/modules/main_modules/order_screen.dart';
import 'package:take_away/shared/components/components.dart';
import 'package:take_away/shared/components/constance.dart';
import 'package:take_away/shared/network/local/cache_helper.dart';
import 'package:take_away/shared/styles/icons.dart';

import 'main_cubit/cubit.dart';
import 'main_cubit/states.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
       MainLayCubit.get(context).getUserData();

      return BlocConsumer<MainLayCubit, MainLayStates>(
        listener: (context, states) {
          if(states is AdminUserState){
            navigateAndFinishTo(context, const AdminLayout());
          }
          if(states is ErrorGetUserDataState){
            CacheHelper.removeData(key: 'uId');
            navigateAndFinishTo(context, LoginScreen());
          }

        },
        builder: (context, states) =>
            Scaffold(
              appBar: AppBar(
                actions: [
                  TextButton(
                    onPressed: () {
                      signOut(context);
                    },
                    child: const Icon(IconBroken.Logout),
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '7HEVƎN',
                      style: TextStyle(
                          fontSize: 33, color: Theme
                          .of(context)
                          .primaryColor),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Takeaway',
                      style: TextStyle(
                          fontSize: 17,
                          color: Theme
                              .of(context)
                              .primaryColor
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultButton(
                      onPressed: () {
                        navigateTo(context, const OrderScreen());
                      },
                      fontSize: 25,
                      label: 'طلب جديد',
                      context: context,
                      width: 110,

                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      onPressed: () {
                        navigateTo(context, const UserOrder());
                      },
                      label: 'طلباتي',
                      fontSize: 25,
                      context: context,
                      width: 90,

                    ),
                  ],
                ),
              ),
            ),
      );
    }
    );

  }
}
