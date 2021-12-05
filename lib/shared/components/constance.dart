


import 'package:take_away/modules/main_modules/login_screen/login_screen.dart';
import 'package:take_away/shared/network/local/cache_helper.dart';

import 'components.dart';

void signOut(context) {

    CacheHelper.removeData(key:'uId').then((value){
      uId = CacheHelper.getData(key: 'uId');
      if(value){
         navigateAndFinishTo(context, LoginScreen());
      }
    });
}


int dId = CacheHelper.getData(key: 'dId');

int oId = CacheHelper.getData(key: 'oId');
String? uId;
String? token;


