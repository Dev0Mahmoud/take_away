import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:take_away/data/dialoge_options.dart';
import 'package:take_away/data/dialoge_options.dart';
import 'package:take_away/data/hot_drinks_menu.dart';
import 'package:take_away/layout/main_cubit/cubit.dart';
import 'package:take_away/layout/main_cubit/states.dart';
import 'package:take_away/model/drinks_model.dart';
import 'package:take_away/shared/components/components.dart';

class HotDrinksScreen extends StatelessWidget {
  const HotDrinksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainLayCubit, MainLayStates>(
        listener: (context, state) {
      if (state is MainLayOrderDone) {
        showToast(state: ToastStates.SUCCESS, msg: 'طلبت و هتنول ;)');
      }
      if (state is MainLayOrderDeleteDone) {
        showToast(state: ToastStates.ERROR, msg: 'طلبك إتلغي');
      }
    }, builder: (context, state) {
      return Conditional.single(
          conditionBuilder: (context) => HotDrinksMenu.menu.isNotEmpty,
          widgetBuilder: (BuildContext context) => ListView.separated(
                itemBuilder: (context, index) =>
                    hotItemBuilder(HotDrinksMenu.menu[index], index, context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: HotDrinksMenu.menu.length,
              ),
          fallbackBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
          context: context);
    });
  }
}

Widget hotItemBuilder(
  DrinksModel model,
  int index,
  BuildContext context,
) {
  var cubit = MainLayCubit.get(context);
  TextEditingController otherAddController = TextEditingController();

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
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => Center(
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            AlertDialog(
                              titlePadding: const EdgeInsetsDirectional.all(10),
                              contentPadding: const EdgeInsetsDirectional.all(10),
                              insetPadding: EdgeInsets.zero,
                              title: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: NetworkImage(model.drinkImage),
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        model.drinkName,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.only(top: 10),
                                    child: Text(
                                      '(: عشان نظبط طلبك',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                              content: Column(
                                children: [
                                  model.drinkName == 'شاي'
                                      ? Column(
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional.centerEnd,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(bottom: 10),
                                                child: Text(
                                                    '${model.drinkName} معاليك ؟',
                                                    style: const TextStyle(
                                                        fontSize: 20)),
                                              ),
                                            ),
                                            defaultToggleButton(
                                              onTap: (int index) {
                                                cubit.drinkTypePressed(index);
                                              },
                                              isSelectedList:
                                                  drinkTypeSelected,
                                              constToggleChildren:
                                                  drinkTypeChildren,
                                              context: context,
                                            ),
                                            drinkTypeSelected[1]
                                                ? defaultToggleButton(
                                                    onTap: (int index) {
                                                      cubit.drinkQuantityPressed(
                                                          index);
                                                    },
                                                    isSelectedList: drinkQuantitySelected,
                                                    constToggleChildren: drinkQuantityChildren,
                                                    context: context,
                                                  )
                                                : const SizedBox(),
                                          ],
                                        )
                                      : const SizedBox(),
                                  model.drinkName == 'قهوة'
                                      ? Column(
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional.centerEnd,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(bottom: 10),
                                                child: Text(
                                                    '${model.drinkName} معاليك ؟',
                                                    style: const TextStyle(
                                                        fontSize: 20)),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                defaultToggleButton(
                                                  onTap: (int index) {
                                                    cubit.coffeeLevelPressed(
                                                        index);
                                                  },
                                                  isSelectedList:
                                                      coffeeLevelSelected,
                                                  constToggleChildren:
                                                      coffeeLevelChildren,
                                                  context: context,
                                                ),
                                                const Spacer(),
                                                defaultToggleButton(
                                                  onTap: (int index) {
                                                    cubit
                                                        .coffeeTypePressed(index);
                                                  },
                                                  isSelectedList:
                                                      coffeeTypeSelected,
                                                  constToggleChildren:
                                                      coffeeTypeChildren,
                                                  context: context,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  Column(
                                    children: [
                                      const Align(
                                        alignment: AlignmentDirectional.centerEnd,
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              bottom: 10),
                                          child: Text('كوباية معاليك ؟',
                                              style: TextStyle(fontSize: 20)),
                                        ),
                                      ),
                                      model.drinkName == 'قهوة'
                                          ? Row(
                                              children: [
                                                defaultToggleButton(
                                                  onTap: (int index) {
                                                    cubit.coffeeDoublePressed(
                                                        index);
                                                  },
                                                  isSelectedList:
                                                      coffeeDoubleSelected,
                                                  constToggleChildren:
                                                      coffeeDoubleChildren,
                                                  context: context,
                                                ),
                                                const Spacer(),
                                                isCoffeeDouble == true
                                                    ? defaultToggleButton(
                                                        onTap: (int index) {
                                                          cubit
                                                              .doubleCoffeeGlassTypePressed(
                                                                  index);
                                                        },
                                                        isSelectedList: doubleCoffeeGlassTypeSelected,
                                                        constToggleChildren: doubleCoffeeGlassTypeChildren,
                                                        context: context,
                                                      )
                                                    : defaultToggleButton(
                                                        onTap: (int index) {
                                                          cubit
                                                              .singleCoffeeGlassTypePressed(
                                                                  index);
                                                        },
                                                        isSelectedList: singleCoffeeGlassTypeSelected,
                                                        constToggleChildren: singleCoffeeGlassTypeChildren,
                                                        context: context,
                                                      ),
                                              ],
                                            )
                                          : defaultToggleButton(
                                              onTap: (int index) {
                                                cubit.glassTypePressed(index);
                                              },
                                              isSelectedList:
                                                  glassTypeSelected,
                                              constToggleChildren:
                                                 glassTypeChildren,
                                              context: context,
                                            ),
                                    ],
                                  ),
                                  const Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Padding(
                                      padding:
                                          EdgeInsetsDirectional.only(bottom: 10),
                                      child: Text('سكر معاليك ؟',
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                  ),
                                  model.drinkName == 'قهوة'
                                      ? defaultToggleButton(
                                          onTap: (int index) {
                                            cubit.coffeeSugarPressed(index);
                                          },
                                          isSelectedList:
                                              coffeeSugarSelected,
                                          constToggleChildren:
                                              coffeeSugarChildren,
                                          context: context,
                                        )
                                      : defaultToggleButton(
                                          onTap: (int index) {
                                            cubit.sugarPressed(index);
                                          },
                                          isSelectedList: sugarSelected,
                                          constToggleChildren:
                                              sugarChildren,
                                          context: context,
                                        ),
                                  Container(
                                    padding: const EdgeInsetsDirectional.only(
                                        bottom: 10),
                                    width: 230,
                                    height: 50,
                                    child: defaultFormField(
                                      context: context,
                                      controller: otherAddController,
                                      label: 'ضيف علي طلبي ٫٫٫',
                                      hintText: '  (:أي إضافة ، متشغلش بالك',
                                      hintStyle: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      labelStyle: const TextStyle(
                                        fontSize: 15,
                                      ),
                                      prefixIcon: Icons.add_circle_outline_sharp,
                                      suffixIcon: Icons.clear,
                                      suffixPressed: () {
                                        otherAddController.clear();
                                      },
                                      keyboard: TextInputType.text,
                                    ),
                                  ),
                                  defaultButton(
                                      fontSize: 20,
                                      icon: FontAwesomeIcons.rocket,
                                      label: '(:  خمسة و جايلك',
                                      onPressed: () {
                                        cubit.orderComplete(
                                          model: model,
                                          otherAdd: otherAddController.text
                                              .toString(),
                                        );
                                        Navigator.pop(context);
                                      },
                                      context: context,
                                      width: 190)
                                ],
                              ),
                            ),
                            model.drinkName == 'قهوة'
                                ? Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 40, top: 3),
                                    child: Material(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(22),
                                      child: CircleAvatar(
                                        radius: 22,
                                        backgroundColor: Colors.red,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 70, top: 3),
                                    child: Material(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(22),
                                      child: CircleAvatar(
                                        radius: 22,
                                        backgroundColor: Colors.red,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ));
          },
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
                child: Text(
                  model.drinkName,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 35, color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    ),
  );
}
