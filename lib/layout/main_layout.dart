import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:take_away/data/user_drawer_navbar.dart';
import 'package:take_away/layout/admin_layout.dart';
import 'package:take_away/modules/main_modules/drinks_screen/fav_order.dart';
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
    return Builder(builder: (BuildContext context) {
      MainLayCubit.get(context).getUserData();
      var cubit = MainLayCubit.get(context);
      return BlocConsumer<MainLayCubit, MainLayStates>(
        listener: (context, state) {

          if (state is AdminUserState) {
            navigateAndFinishTo(context, const AdminLayout());
          }

          if (state is ErrorGetUserDataState) {
            CacheHelper.removeData(key: 'uId');
            navigateAndFinishTo(context, LoginScreen());
          }
        },
        builder: (context, states) => Scaffold(
          drawer:Conditional.single(
            context: context,
            widgetBuilder: (BuildContext context) =>UserNavBar(
              condition: states is SuccessProfileImagePickedState,
              accountEmail: cubit.userModel!.email,
              accountName: cubit.userModel!.name,
              accountImage: cubit.userModel!.image,
            ),
            conditionBuilder: (BuildContext context) => cubit.userModel != null,
            fallbackBuilder: (BuildContext context)=>const SizedBox(),
          ),
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '7HEVƎN',
                  style: TextStyle(
                      fontSize: 33, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Takeaway',
                  style: TextStyle(
                      fontSize: 17, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                defaultButton(
                  onPressed: () {
                    cubit.currentIndex = 0;
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
                    navigateTo(
                      context,
                      const FavOrder(),
                    );
                  },
                  label: 'طلباتي المفضلة',
                  fontSize: 25,
                  context: context,
                  width: 180,
                ),
              ],
            ),
          ),

        ),
      );
    });
  }
}
