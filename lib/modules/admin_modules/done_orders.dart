import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:take_away/layout/admin_cubit/cubit.dart';
import 'package:take_away/layout/admin_cubit/states.dart';
import 'package:take_away/model/order_model.dart';
import 'package:take_away/shared/components/components.dart';
import 'package:take_away/shared/styles/icons.dart';

class DoneOrders extends StatelessWidget {
  const DoneOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AdminCubit.get(context).getDoneOrders();
      return BlocConsumer<AdminCubit, AdminStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AdminCubit.get(context);
            return Container(
              child: Conditional.single(
                  conditionBuilder: (context) => cubit.doneOrders.isNotEmpty,
                  widgetBuilder: (BuildContext context) => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => doneOrderItem(
                          cubit.doneOrders[index],
                          index,
                          context,
                        ),
                        itemCount: cubit.doneOrders.length,
                      ),
                  fallbackBuilder: (context) => Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // const CircularProgressIndicator(),
                            Icon(
                              FontAwesomeIcons.notEqual,
                              color: Theme.of(context).primaryColor,
                              size: 80,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'مفيش طلبات إتسلمت',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40,
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

Widget doneOrderItem(OrderModel model, int index, context) {
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
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(.8),
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                30)),
                                    child: Image.network(
                                      cubit.orderModel!.drinkImage,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 10),
                                    child: Text(
                                      cubit.orderModel!.drinkName,
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            actions: [
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
                  children: [
                    cubit.userDetails!.hasProfileImage!
                        ? Image(
                            image: NetworkImage(cubit.userDetails!.image!),
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            IconBroken.Profile,
                            size: 70,
                            color: Colors.white,
                          ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        cubit.userDetails!.name!,
                        textAlign: TextAlign.center,
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

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: defaultButton(
            //       label: 'حاسب',
            //       fontSize: 17,
            //       onPressed: () {
            //         cubit.orderDone(model: model);
            //
            //       },
            //       context: context,
            //       width: 50),
            // ),

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
