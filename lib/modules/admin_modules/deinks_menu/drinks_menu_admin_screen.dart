import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:take_away/layout/admin_cubit/cubit.dart';
import 'package:take_away/layout/admin_cubit/states.dart';

class DrinksMenuAdminScreen extends StatelessWidget {
  const DrinksMenuAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context,state){},
      builder: (context,state)=>Scaffold(
        appBar:  AppBar(
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
            ),),
        body: cubit.menuBottomScreen[cubit.menuCurrentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.coffee), label: 'مشروبات ساخنة'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.wineGlass),
                label: 'مشروبات ساقعة'),
          ],
          currentIndex: cubit.menuCurrentIndex,
          showSelectedLabels: true,
          onTap: (index) {
            cubit.menuChangeIndex(index);
          },
        ),
      ),
    );
  }
}
