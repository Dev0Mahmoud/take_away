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
    return Builder(builder: (context) {
      AdminCubit.get(context).getUserOrders();
      return BlocConsumer<AdminCubit, AdminStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AdminCubit.get(context);
            return Container(
              child: Conditional.single(
                  conditionBuilder: (context) => cubit.newOrders.isNotEmpty,
                  widgetBuilder: (BuildContext context) => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => orderItem(
                          cubit.newOrders[index],
                          index,
                          context,
                        ),
                        itemCount: cubit.newOrders.length,
                      ),
                  fallbackBuilder: (context) => Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // const CircularProgressIndicator(),
                            Icon(
                              FontAwesomeIcons.hourglassHalf,
                              color: Theme.of(context).primaryColor,
                              size: 80,
                            ),
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
                  context: context),
            );
          });
    });
  }
}

Widget orderItem(OrderModel model, int index, context) {
  var cubit = AdminCubit.get(context);

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration:
          BoxDecoration(borderRadius: BorderRadiusDirectional.circular(20)),
      child: Card(
        shadowColor: Colors.grey.withOpacity(.3),
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 2),
        color: Colors.orange.withOpacity(.1),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  cubit.getUsersDetails(uId: model.uId);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        titlePadding: EdgeInsetsDirectional.zero,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color:
                                    Theme.of(context).primaryColor.withOpacity(.8),
                                    borderRadius: BorderRadiusDirectional.circular(30)),
                                child: cubit.userDetails!.hasProfileImage!
                                    ? Image.network(
                                  cubit.userDetails!.image!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                                    : const Icon(
                                  IconBroken.Profile,
                                  size: 70,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(end: 10),
                                    child: Text(
                                      cubit.userDetails!.name!,
                                      textAlign: TextAlign.end,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      cubit.userDetails!.address!,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    )),
                                const Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'مكانه',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      cubit.userDetails!.phone!,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    )),
                                const Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'موبايله',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                          defaultButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              label: 'ماشي',
                              context: context,
                              fontSize: 20),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: NetworkImage(model.drinkImage),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: model.isCold
                          ? Text(
                              '${model.drinkName} ${model.coldDrinkSugarType}',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            )
                          : model.drinkName == 'قهوة'
                              ? Text(
                                  ' ${model.sCGlassType} ${model.doubleGlassType} قهوة ${model.isDouble} بن '
                                  '${model.coffeeType} ${model.coffeeLevel} ${model.cSugarType} .. ${model.otherAdd}',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                )
                              : Text(
                                  ' ${model.glassType} ${model.drinkName} ${model.drinkType} '
                                  '${model.drinkQuantity}  '
                                  '${model.sugarType} .. ${model.otherAdd}',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: defaultButton(
                  label: 'إتسلم',
                  fontSize: 17,
                  onPressed: () {
                    cubit.deleteNewOrder(model: model);
                    cubit.orderDone(model: model);

                  },
                  context: context,
                  width: 80),
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
