
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:take_away/layout/admin_cubit/cubit.dart';
import 'package:take_away/layout/admin_cubit/states.dart';
import 'package:take_away/model/order_model.dart';
import 'package:take_away/shared/components/components.dart';
import 'package:take_away/shared/styles/icons.dart';


class NewOrders extends StatelessWidget {
  const NewOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          AdminCubit.get(context).getUserOrders();
          return BlocConsumer<AdminCubit, AdminStates>(
              listener: (context, state) {},
              builder: (context, state) {
            var cubit = AdminCubit.get(context);
            return Container(
              child: Conditional.single(
                  conditionBuilder: (context) =>
                  cubit.newOrders.isNotEmpty,
                  widgetBuilder: (BuildContext context) =>
                      SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => orderItem(
                            cubit.newOrders[index],index,
                            context,),
                          itemCount: cubit.newOrders.length,
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
                              'في إنتظار طلبات',
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
    );
  }
}

Widget orderItem(OrderModel model,int index, context) {
  var cubit = AdminCubit.get(context);

  return InkWell(
    onTap: (){
      cubit.getUsersDetails(uId: model.uId);
      showDialog(context: context, builder: (context)=> AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image.network(
                  cubit.userDetails!.image!,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(cubit.userDetails!.name!),

          ],
        ),
      ));
    },
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20)
      ),
      child: Card(
        shadowColor: Colors.grey.withOpacity(.3),
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 2),
        color: Colors.orange.withOpacity(.1),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.drinkImage),
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: model.drinkName == 'قهوة' ? Text(
                ' ${model.sCGlassType} ${model.doubleGlassType} قهوة ${model.isDouble} بن '
                    '${model.coffeeType} ${model.coffeeLevel} ${model.cSugarType} .. ${model.otherAdd}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              )
                  : Text(
                ' ${model.glassType} ${model.drinkName} ${model.drinkType} '
                    '${model.drinkQuantity}  '
                    '${model.sugarType} .. ${model.otherAdd}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     showDialog(
            //         context: context,
            //         builder: (context) =>   Center(
            //           child: AlertDialog(
            //
            //             titlePadding: const EdgeInsetsDirectional.all(10),
            //             contentPadding: const EdgeInsetsDirectional.all(10),
            //             insetPadding: EdgeInsets.zero,
            //             content:
            //             const Text('هتلغي الطلب ؟',style: TextStyle(fontSize: 30,),textAlign: TextAlign.end,),
            //             actions: [
            //               Row(
            //                 children: [
            //                   defaultButton(
            //                       icon: FontAwesomeIcons.smile,
            //                       label: 'لا دي حركة',
            //                       fontSize: 20,
            //                       onPressed: () {
            //                         Navigator.pop(context);
            //                       },
            //                       context: context,
            //                       width: 140
            //                   ),
            //                   const Spacer(),
            //                   defaultButton(
            //                       icon: FontAwesomeIcons.sadCry,
            //                       label: 'أيوة',
            //                       fontSize: 17,
            //                       onPressed: () {
            //                         cubit.deleteOrder(id: model.id);
            //                         Navigator.pop(context);
            //                       },
            //                       context: context,
            //                       width: 90
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ));
            //   },
            //   icon: const Icon(Icons.delete),color: Theme.of(context).primaryColor,),
            // IconButton(
            //   onPressed: () {
            //     cubit.addFavOrder(index: index);
            //   },
            //   icon: const Icon(IconBroken.Heart),color: Theme.of(context).primaryColor,),
          ],
        ),
      ),
    ),
  );
}
