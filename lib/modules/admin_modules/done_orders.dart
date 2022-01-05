import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:take_away/layout/admin_cubit/cubit.dart';
import 'package:take_away/layout/admin_cubit/states.dart';
import 'package:take_away/model/order_model.dart';
import 'package:take_away/model/user_model.dart';
import 'package:take_away/shared/components/components.dart';
import 'package:take_away/shared/styles/icons.dart';

class DoneOrders extends StatelessWidget {
  const DoneOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    return Builder(builder: (context) {
      cubit.getDoneUsers();
      return BlocConsumer<AdminCubit, AdminStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Container(
              child: Conditional.single(
                  conditionBuilder: (context) => cubit.doneUsers.isNotEmpty,
                  // &&cubit.doneOrders.isNotEmpty,
                  widgetBuilder: (BuildContext context) => ListView.builder(
                        key: Key(cubit.selected.toString()),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => doneUserItem(
                            cubit.doneUsers[index], index, context, state),
                        itemCount: cubit.doneUsers.length,
                      ),
                  fallbackBuilder: (context) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // const CircularProgressIndicator(),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          bottom: 30),
                                      child: Icon(
                                        FontAwesomeIcons.notEqual,
                                        color: Theme.of(context).primaryColor,
                                        size: 50,
                                      ),
                                    ),
                                    // const SizedBox(
                                    //   height: 30,
                                    // ),
                                    Text(
                                      'مفيش طلبات اتسلمت',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  context: context),
            );
          });
    });
  }
}

Widget doneOrderItem(OrderModel model, int index, context, bool? value) {
  var cubit = AdminCubit.get(context);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'جنيه',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Text(
                    '${model.price}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 10),
            child: Text(
              model.drinkName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).primaryColor),
            ),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 10),
            child: Text(
              '${model.orderTime}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15, color: Theme.of(context).primaryColor),
            ),
          )),
          !value!
              ? Checkbox(
                  value: cubit.isChecked[model.id] ?? false,
                  onChanged: (v) {
                    cubit.checkBoxClicked(model.id);
                  },
                )
              : Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.check_box,
                    color: Theme.of(context).primaryColor,
                  ),
                )
        ],
      ),
    ),
  );
}

Widget doneUserItem(UserModel model, int index, context, state) {
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
                child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    key: Key(index.toString()),
                    // initiallyExpanded: index == selected,
                    onExpansionChanged: (v) {
                      cubit.getUserDoneOrders(uId: model.uId!);
                      cubit.expansionChangSelected(index);
                      print('s is $index');
                    },
                    title: Container(
                      clipBehavior: Clip.antiAlias,
                      padding: EdgeInsetsDirectional.zero,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20)),
                      child: Row(
                        children: [
                          model.hasProfileImage!
                              ? Container(
                                  width: 60,
                                  height: 60,
                                  clipBehavior: Clip.antiAlias,
                                  padding: EdgeInsetsDirectional.zero,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(20)),
                                  child: Image(
                                    image: NetworkImage(model.image!),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: 60,
                                  height: 60,
                                  clipBehavior: Clip.antiAlias,
                                  padding: EdgeInsetsDirectional.zero,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(20)),
                                  child: const Icon(
                                    IconBroken.Profile,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              model.name!,
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
                    children: [
                      if(cubit.doneOrders.isNotEmpty)
                  Checkbox(
                      value: cubit.isAllChecked??false,
                      onChanged: (v) {
                        cubit.allCheckBoxClicked();
                      }),
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => doneOrderItem(
                        cubit.doneOrders[index],
                        index,
                        context,
                        cubit.isAllChecked??false),
                    itemCount: cubit.doneOrders.length,
                  ),
                      if(cubit.doneOrders.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    'جنيه',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                Text(
                                  '${cubit.total}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(end: 10),
                            child: Text(
                              'إجمالي',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (cubit.checkedItems.isNotEmpty)
                    InkWell(
                      onTap: () {
                        cubit.billedOrders(uId: model.uId!);
                        cubit.expansionChangSelected(index);
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).primaryColor),
                        child:  Center(
                          child: state is LoadingBillOrdersState ? const CircularProgressIndicator() :const Text(
                          'خالص',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          )
                        ),
                      ),
                    ),
                ])),
          ],
        ),
      ),
    ),
  );
}
