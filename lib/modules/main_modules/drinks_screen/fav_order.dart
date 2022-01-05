
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:take_away/layout/user_cubit/cubit.dart';
import 'package:take_away/layout/user_cubit/states.dart';
import 'package:take_away/model/drinks_model.dart';
import 'package:take_away/model/order_model.dart';
import 'package:take_away/shared/components/components.dart';
import 'package:take_away/shared/styles/icons.dart';

class FavOrder extends StatelessWidget {
  const FavOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is UserOrderDeleteDone) {
            showToast(state: ToastStates.ERROR, msg: 'طلبك المفضل مبقاش مفضل');
            Fluttertoast.cancel();
          }
        }, builder: (context, state) {
      var cubit = UserCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: const Icon(IconBroken.Heart,size: 40,),
        ),
        body:Conditional.single(
            conditionBuilder: (context) =>
            cubit.favOrder.isNotEmpty,
            widgetBuilder: (BuildContext context) =>
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => favOrderItem(
                      cubit.favOrder[index],index,
                      cubit.hotDrinksMenu[index],
                      context,),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: cubit.favOrder.length,
                  ),
                ),
            fallbackBuilder: (context) =>
                Center(
                  child: Text(
                    'ضيف طلبك المفضل',
                    style: TextStyle(
                        fontSize: 50,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
            context: context
        ),


      );
    });
  }
}

Widget favOrderItem(OrderModel model,int index, DrinksModel dModel, context) {
  var cubit = UserCubit.get(context);
  TextEditingController otherAddController = TextEditingController();
  otherAddController.text = model.otherAdd!;

  return Card(
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
            child: model.drinkName == 'قهوة' ?
            Text(
              'قهوتك المفضلة ${model.sCGlassType} ${model.doubleGlassType} ${model.isDouble} بن  '
                  '${model.coffeeType} ${model.coffeeLevel} ${model.cSugarType}٫٫${model.otherAdd} ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            )
                : model.drinkName == 'شاي' ? Text(
              '${model.drinkName}ك المفضل ${model.glassType} ${model.drinkType} ${model.drinkQuantity} '
                  '${model.sugarType}٫٫ ${model.otherAdd}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            )
            : Text(
              '${model.drinkName}  ${model.glassType} ${model.drinkType} ${model.drinkQuantity} '
                  '${model.sugarType}٫٫ ${model.otherAdd}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ) ,
          ),
          IconButton(
            onPressed: () {
              cubit.deleteFavOrder(index: index);
              },
            icon: const Icon(Icons.delete),color: Theme.of(context).primaryColor,),
          defaultButton(
            onPressed: () {
              cubit.orderFav(
                index: index
              );
            },
            label: 'إطلب',
            fontSize: 17,
            context: context,
            width: 50,

          ),
        ],
      ),
    ),
  );
}
