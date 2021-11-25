import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:take_away/model/drinks_model.dart';

class HotDrinksAdminScreen extends StatelessWidget {
  const HotDrinksAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
Widget hotMenuItemBuilder ({required BuildContext context,required DrinksModel model})=>
Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: NetworkImage(model.drinkImage),
    ),
    color: Theme.of(context).primaryColor.withOpacity(.5),
  ),
  width: 200,
  height: 200,
);