import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:take_away/layout/admin_cubit/cubit.dart';

import 'package:take_away/modules/admin_modules/deinks_menu/drinks_menu_admin_screen.dart';
import 'package:take_away/modules/main_modules/login_screen/login_screen.dart';
import 'package:take_away/modules/main_modules/order_screen.dart';
import 'package:take_away/shared/components/components.dart';
import 'package:take_away/shared/components/constance.dart';
import 'package:take_away/shared/styles/icons.dart';

class AdminNavBar extends StatelessWidget {
  AdminNavBar({
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
                child: condition ? const CircularProgressIndicator():Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    ClipOval(
                      child: accountImage == ''?
                      const Icon(IconBroken.Profile,size: 70,) : Image.network(
                        accountImage!,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey[300],
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                        titlePadding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        title: const Text(
                                            'يلا نغير صورة البروفايل',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
                                        children: [
                                          SimpleDialogOption(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Text(
                                                  'صورة من عندك',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.image,
                                                  color: Colors.blueGrey,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              AdminCubit.get(context)
                                                  .getProfileImageFromGallery();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          SimpleDialogOption(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Text('كاميرا',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 18)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.camera_sharp,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              AdminCubit.get(context)
                                                  .getProfileImageFromCamera();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          SimpleDialogOption(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Text('إمسح الصورة خالص',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 18)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.delete,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              AdminCubit.get(context)
                                                  .deleteProfileImage();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          SimpleDialogOption(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Text('لا خلاص',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 18)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ));
                            },
                            icon: const Icon(
                              IconBroken.Camera,
                              size: 18,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ],
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
            leading: const Icon(FontAwesomeIcons.list),
            title: const Text('قائمة المشروبات',style: TextStyle(color: Colors.black),),
            onTap: (){
              navigateTo(context, const DrinksMenuAdminScreen() );
            },

          ),

          ListTile(
            leading: const Icon(FontAwesomeIcons.user),
            title: const Text('واجهة المستخدم',style: TextStyle(color: Colors.black),),
            onTap: (){
              navigateTo(context, const OrderScreen());
            },

          ),

          ListTile(
            leading: const Icon(FontAwesomeIcons.signOutAlt),
            title: const Text('تسجيل خروج',style: TextStyle(color: Colors.black),),
            onTap: (){
              signOut(context);
              navigateTo(context,LoginScreen());
            },

          ),
        ],
      ),
    );
  }
}
