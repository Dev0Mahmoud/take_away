import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:take_away/layout/main_cubit/cubit.dart';
import 'package:take_away/layout/main_cubit/states.dart';
import 'package:take_away/shared/components/components.dart';
import 'package:take_away/shared/styles/icons.dart';

import 'drinks_screen/fav_order.dart';
import 'drinks_screen/user_order_screen.dart';


class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = MainLayCubit.get(context);


    return BlocConsumer<MainLayCubit, MainLayStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    '7HEVƎN',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Takeaway',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
                // actions: [
                //     Padding(
                //       padding: const EdgeInsetsDirectional.only(end: 10),
                //       child: IconButton(onPressed: (){
                //         navigateTo(context, const FavOrder());
                //       }, icon: const Icon(IconBroken.Edit,size: 40,)),
                //     )
                //   ],
            ),
            body: cubit.bottomScreen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.coffee), label: 'مشروبات ساخنة'),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.wineGlass),
                    label: 'مشروبات ساقعة'),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.shoppingCart),
                    label: 'طلباتي'),
              ],
              currentIndex: cubit.currentIndex,
              showSelectedLabels: true,
              onTap: (index) {
                cubit.changeIndex(index);
              },
            ),
          );
        });
  }
}
