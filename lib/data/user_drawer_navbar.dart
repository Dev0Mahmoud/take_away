import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:take_away/layout/admin_cubit/cubit.dart';

import 'package:take_away/modules/admin_modules/deinks_menu/drinks_menu_admin_screen.dart';
import 'package:take_away/modules/main_modules/edit_profile_screen.dart';
import 'package:take_away/modules/main_modules/login_screen/login_screen.dart';
import 'package:take_away/layout/user_layout.dart';
import 'package:take_away/shared/components/components.dart';
import 'package:take_away/shared/components/constance.dart';
import 'package:take_away/shared/styles/icons.dart';

class UserNavBar extends StatelessWidget {
  UserNavBar({
    Key? key,
    required this.accountName,
    required this.accountEmail,
    required this.accountImage,
    required this.condition
  }) : super(key: key);
  String? accountName;
  String? accountEmail;
  String? accountImage;
  bool condition;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName!),
            accountEmail: Text(accountEmail!),
            currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: condition ? const CircularProgressIndicator():ClipOval(
                  child: accountImage == ''?
                  const Icon(IconBroken.Profile,size: 70,) : Image.network(
                    accountImage!,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                )),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  HexColor('#f7e094'),
                  Colors.orange,
                ],
                begin: AlignmentDirectional.topEnd,
                end: AlignmentDirectional.bottomStart,
              ),
            ),
          ),

          ListTile(
            leading: const Icon(IconBroken.Setting),
            title: const Text('إعدادات',style: TextStyle(color: Colors.black),),
            onTap: (){
              navigateTo(context, const SettingsScreen());
            },

          ),

          ListTile(
            leading: const Icon(FontAwesomeIcons.signOutAlt),
            title: const Text('تسجيل خروج',style: TextStyle(color: Colors.black),),
            onTap: (){
              signOut(context);
              navigateAndFinishTo(context,LoginScreen());
            },

          ),
        ],
      ),
    );
  }
}
