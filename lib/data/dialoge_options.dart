import 'package:flutter/material.dart';
import 'package:take_away/model/drinks_model.dart';

int drinkTypeIndex = 0;

List<bool> drinkTypeSelected = [
  true,
  false,
];
List<bool> forEditDrinkTypeSelected = [
  true,
  false,
];
List<Widget> drinkTypeChildren = const [
  Padding(
    padding: EdgeInsetsDirectional.only(start: 5),
    child: Text('فتلة'),
  ),
  Padding(
    padding: EdgeInsetsDirectional.only(end: 5),
    child: Text('عادي'),
  ),
];
int drinkQuantityIndex = 1;

List<bool> drinkQuantitySelected = [false, true, false];
List<bool> forEditDrinkQuantitySelected = [false, true, false];
List<Widget> drinkQuantityChildren = const [
  Padding(
    padding: EdgeInsetsDirectional.only(start: 5),
    child: Text('تقيل'),
  ),
  Text('مظبوط'),
  Padding(
    padding: EdgeInsetsDirectional.only(end: 5),
    child: Text('خفيف'),
  ),
];
int glassTypeIndex = 2;

List<bool> glassTypeSelected = [false, false, true];
List<bool> forEditGlassTypeSelected = [false, false, true];
List<Widget> glassTypeChildren = const [
  Padding(
    padding: EdgeInsetsDirectional.only(start: 5, end: 5),
    child: Text('خمسينة'),
  ),
  Text('كوباية'),
  Padding(
    padding: EdgeInsetsDirectional.only(end: 5),
    child: Text('سفري'),
  ),
];
int sugarIndex = 0;

List<bool> sugarSelected = [true, false, false, false];
List<bool> forEditSugarSelected = [true, false, false, false];
List<Widget> sugarChildren = const [
  Padding(
    padding: EdgeInsetsDirectional.only(start: 5),
    child: Text('سكر بره'),
  ),
  Text('زيادة'),
  Text('مظبوط'),
  Padding(
    padding: EdgeInsetsDirectional.only(end: 5),
    child: Text('خفيف'),
  ),
];


int coldDrinkSugarIndex = 1;
List<bool> coldDrinkSugarSelected = [ false,true, false, ];
List<Widget> coldDrinkSugarChildren = const [
  Padding(
    padding: EdgeInsetsDirectional.only(start: 5),
    child: Text('زيادة'),
  ),
  Text('مظبوط'),
  Padding(
    padding: EdgeInsetsDirectional.only(end: 5),
    child: Text('خفيف'),
  ),
];


int coffeeTypeIndex = 1;
List<bool> coffeeTypeSelected = [false, true];
List<bool> forEditCoffeeTypeSelected = [false, true];
List<Widget> coffeeTypeChildren = const [
  Padding(
    padding: EdgeInsetsDirectional.only(start: 5),
    child: Text('محوج'),
  ),
  Padding(
    padding: EdgeInsetsDirectional.only(end: 5),
    child: Text('سادة'),
  ),
];
int coffeeLevelIndex = 1;
List<bool> coffeeLevelSelected = [false, true, false];
List<bool> forEditCoffeeLevelSelected = [false, true, false];
List<Widget> coffeeLevelChildren = const [
  Padding(
    padding: EdgeInsetsDirectional.only(start: 5),
    child: Text('غامق'),
  ),
  Text('وسط'),
  Padding(
    padding: EdgeInsetsDirectional.only(end: 5),
    child: Text('فاتح'),
  ),
];

int singleCoffeeGlassTypeIndex = 2;
List<bool> singleCoffeeGlassTypeSelected = [false, false, true];
List<bool> forEditSingleCoffeeGlassTypeSelected = [false, false, true];
List<Widget> singleCoffeeGlassTypeChildren = const [
  Padding(
    padding: EdgeInsetsDirectional.only(start: 5, end: 5),
    child: Text('فنجان'),
  ),
  Text('كوباية'),
  Padding(
    padding: EdgeInsetsDirectional.only(end: 5),
    child: Text('سفري'),
  ),
];

int doubleCoffeeGlassTypeIndex = 1;
List<bool> doubleCoffeeGlassTypeSelected = [false, true];
List<bool> forEditDoubleCoffeeGlassTypeSelected = [false, true];
List<Widget> doubleCoffeeGlassTypeChildren = const [
  Padding(
    padding: EdgeInsetsDirectional.only(start: 5, end: 5),
    child: Text('كوباية'),
  ),
  Padding(
    padding: EdgeInsetsDirectional.only(end: 5),
    child: Text('سفري'),
  ),
];

int coffeeDoubleIndex = 0;
bool isCoffeeDouble = false;
List<bool> coffeeDoubleSelected = [false];
List<bool> forEditCoffeeDoubleSelected = [false];
List<Widget> coffeeDoubleChildren = const [
  Text('دوبل'),
];

int coffeeSugarIndex = 5;
List<bool> coffeeSugarSelected = [false, false, false, false, false, true];
List<bool> forEditCoffeeSugarSelected = [
  false,
  false,
  false,
  false,
  false,
  true
];
List<Widget> coffeeSugarChildren = const [
  Padding(
    padding: EdgeInsetsDirectional.only(start: 5, end: 10),
    child: Text('زيادة عالي'),
  ),
  Text('زيادة'),
  Text('مانو'),
  Text('مظبوط'),
  Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Text('عـ الريحة'),
  ),
  Padding(
    padding: EdgeInsetsDirectional.only(end: 5),
    child: Text('ساده'),
  ),
];

String drinkType(int index, DrinksModel model) {
  String type = '';
  if (model.drinkName != 'شاي') return type = '';
  switch (index) {
    case 0:
      type = 'فتلة';
      break;
    case 1:
      type = 'عادي';
      break;
    default:
      'فتلة';
  }
  return type;
}

String drinkQuantity(int index, int drinkTypeIndex, DrinksModel model) {
  String quantity = '';
  if (drinkTypeIndex == 0) return quantity = '';
  if (model.drinkName != 'شاي') return quantity = '';

  switch (index) {
    case 0:
      quantity = 'تقيل';
      break;
    case 1:
      quantity = 'مظبوط';
      break;
    case 2:
      quantity = 'خفيف';
      break;
    default:
      'فتلة';
  }
  return quantity;
}

String glassType(
  int index,
) {
  String glass = '';

  switch (index) {
    case 0:
      glass = 'خمسينة';
      break;
    case 1:
      glass = 'كوباية';
      break;
    case 2:
      glass = 'سفري';
      break;
    default:
      'سفري';
  }
  return glass;
}

String sugarQuantity(int index) {
  String sugar = '';
  switch (index) {
    case 0:
      sugar = 'سكر بره';
      break;
    case 1:
      sugar = 'سكر زيادة';
      break;
    case 2:
      sugar = 'سكر مظبوط';
      break;
    case 3:
      sugar = 'سكر خفيف';
      break;
    default:
      'محددش سكر';
  }
  return sugar;
}
String coldDrinkSugarQuantity(int index) {
  String sugar = '';
  switch (index) {
    case 0:
      sugar = 'سكر زيادة';
      break;
    case 1:
      sugar = 'سكر مظبوط';
      break;
    case 2:
      sugar = 'سكر خفيف';
      break;
    default:
      'محددش سكر';
  }
  return sugar;
}

String coffeeLevel(
  int index,
) {
  String level = '';
  switch (index) {
    case 0:
      level = 'غامق';
      break;
    case 1:
      level = 'وسط';
      break;
    case 2:
      level = 'فاتح';
      break;
    default:
      'وسط';
  }
  return level;
}

String isCoffeDouble(
  bool isDouble,
) {
  String double = '';
  if (isDouble == true) {
    return double = 'دوبل';
  } else {
    return double = '';
  }

  return double;
}

String coffeeDoubleGlassType(int index, bool isDouble) {
  String glass = '';
  if (isDouble == false) {
    return glass = '';
  }
  switch (index) {
    case 0:
      glass = 'كوباية';
      break;
    case 1:
      glass = 'سفري';
      break;
    default:
      'سفري';
  }
  return glass;
}

String coffeeSingleGlassType(
  int index,
  bool isDouble,
) {
  String glass = '';
  if (isDouble == true) {
    return glass = '';
  }
  switch (index) {
    case 0:
      glass = 'فنجان';
      break;
    case 1:
      glass = 'كوباية';
      break;
    case 2:
      glass = 'سفري';
      break;
    default:
      'سفري';
  }
  return glass;
}

String coffeeType(
  int index,
) {
  String type = '';
  switch (index) {
    case 0:
      type = 'محوج';
      break;
    case 1:
      type = 'سادة';
      break;
    default:
      'سادة';
  }
  return type;
}

String coffeeSugar(
  int index,
) {
  String sugar = '';
  switch (index) {
    case 0:
      sugar = 'سكر زيادة عالي';
      break;
    case 1:
      sugar = 'سكر زيادة';
      break;
    case 2:
      sugar = 'سكر مانو';
      break;
    case 3:
      sugar = 'سكر مظبوط';
      break;
    case 4:
      sugar = 'سكر عـ الريحة';
      break;
    case 5:
      sugar = 'سكر سادة';
      break;
    default:
      'سكر سادة';
  }
  return sugar;
}
