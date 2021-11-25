
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:take_away/data/hot_drinks_menu.dart';
import 'package:take_away/layout/main_cubit/cubit.dart';
import 'package:take_away/layout/main_cubit/states.dart';
import 'package:take_away/model/drinks_model.dart';
import 'package:take_away/model/order_model.dart';
import 'package:take_away/shared/components/components.dart';
import 'package:take_away/shared/styles/icons.dart';

import 'fav_order.dart';

class UserOrder extends StatelessWidget {
  const UserOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainLayCubit, MainLayStates>(
        listener: (context, state) {
      if (state is MainLayOrderDeleteDone) {
        showToast(state: ToastStates.ERROR, msg: 'طلبك إتلغي');
        Fluttertoast.cancel();
      }
      if (state is MainLayFavOrderExisting) {
        showToast(state: ToastStates.ERROR, msg: 'طلبك المفضل موجود');
        Fluttertoast.cancel();
      }
      if (state is MainLayFavOrderDone) {
        showToast(state: ToastStates.WARNING, msg: 'طلبك بقي مفضل');
        Fluttertoast.cancel();
      }
    }, builder: (context, state) {
      var cubit = MainLayCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'طلباتي',
                style: TextStyle(fontSize: 33),
              ),
              SizedBox(
                width: 30,
              ),
              Icon(FontAwesomeIcons.clipboardList)
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: IconButton(onPressed: (){
                navigateTo(context, const FavOrder());
              }, icon: const Icon(IconBroken.Heart,size: 40,)),
            )
          ],
        ),
        body: Conditional.single(
            conditionBuilder: (context) =>
                cubit.orders.isNotEmpty,
            widgetBuilder: (BuildContext context) =>
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => orderItem(
                    cubit.orders[index],index,
                    HotDrinksMenu.menu[index],
                    context,),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.orders.length,
              ),
            ),
            fallbackBuilder: (context) =>
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'في إنتظار طلباتك',
                    style: TextStyle(
                        fontSize: 50,
                        color: Theme.of(context).primaryColor),
                  ),
                    ],
                  ),
                ),
            context: context
        ),
      );
    });
  }
}

Widget orderItem(OrderModel model,int index, DrinksModel dModel, context) {
  var cubit = MainLayCubit.get(context);
  TextEditingController otherAddController = TextEditingController();
  otherAddController.text = model.otherAdd!;

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5),
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(50)
    ),
    child: Card(
      shadowColor: Colors.grey.withOpacity(.3),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 2),
      color: Colors.orange.withOpacity(.1),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.drinkImage),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: model.drinkName == 'قهوة' ? Text(
                'طلبك ${model.sCGlassType} ${model.doubleGlassType} قهوة ${model.isDouble} بن '
                    '${model.coffeeType} ${model.coffeeLevel} ${model.cSugarType} .. ${model.otherAdd} ٫ جايلك حالاً',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              )
                  : Text(
                'طلبك ${model.glassType} ${model.drinkName} ${model.drinkType} '
                '${model.drinkQuantity}  '
                '${model.sugarType} .. ${model.otherAdd} ٫ جايلك حالاً ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>   Center(
                        child: AlertDialog(

                          titlePadding: const EdgeInsetsDirectional.all(10),
                          contentPadding: const EdgeInsetsDirectional.all(10),
                          insetPadding: EdgeInsets.zero,
                          content:
                          const Text('هتلغي الطلب ؟',style: TextStyle(fontSize: 30,),textAlign: TextAlign.end,),
                          actions: [
                            Row(
                              children: [
                                defaultButton(
                                    icon: FontAwesomeIcons.smile,
                                    label: 'لا دي حركة',
                                    fontSize: 20,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    context: context,
                                    width: 140
                                ),
                                const Spacer(),
                                defaultButton(
                                    icon: FontAwesomeIcons.sadCry,
                                    label: 'أيوة',
                                    fontSize: 17,
                                    onPressed: () {
                                      cubit.deleteOrder(index: index);
                                      Navigator.pop(context);
                                    },
                                    context: context,
                                    width: 90
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                },
                icon: const Icon(Icons.delete),color: Theme.of(context).primaryColor,),
            IconButton(
                onPressed: () {
                  cubit.addFavOrder(index: index);
                },
                icon: const Icon(IconBroken.Heart),color: Theme.of(context).primaryColor,),
          ],
        ),
      ),
    ),
  );
}
