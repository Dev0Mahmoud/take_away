import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:take_away/data/dialoge_options.dart';
import 'package:take_away/layout/main_cubit/cubit.dart';
import 'package:take_away/layout/main_cubit/states.dart';
import 'package:take_away/model/drinks_model.dart';
import 'package:take_away/shared/components/components.dart';

class ColdDrinks extends StatelessWidget {
  const ColdDrinks({Key? key}) : super(key: key);

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
      var cubit = MainLayCubit.get(context);
      return Conditional.single(
          conditionBuilder: (context) => cubit.coldDrinksMenu.isNotEmpty,
          widgetBuilder: (BuildContext context) => ListView.builder(
            itemBuilder: (context, index) =>
                coldItemBuilder(cubit.coldDrinksMenu[index], index, context),

            itemCount: cubit.coldDrinksMenu.length,
          ),
          fallbackBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
          context: context);
    });
  }
}

Widget coldItemBuilder(
    DrinksModel model,
    int index,
    BuildContext context,
    ) {
  var cubit = MainLayCubit.get(context);
  TextEditingController otherAddController = TextEditingController();
  bool isCold = true;
  return Padding(
    padding: const EdgeInsets.all(8.0),
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
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) =>
                    Center(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        AlertDialog(
                          titlePadding: const EdgeInsetsDirectional.all(35),
                          contentPadding: const EdgeInsetsDirectional.all(10),
                          insetPadding: EdgeInsets.zero,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.circular(15)
                                ),
                                child: Image(
                                  image: NetworkImage(model.drinkImage),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
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
                          content: Column(
                            children: [

                              const Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Padding(
                                  padding:
                                  EdgeInsetsDirectional.only(bottom: 10),
                                  child: Text('سكر معاليك ؟',
                                      style: TextStyle(fontSize: 20)),
                                ),
                              ),
                              defaultToggleButton(
                                onTap: (int index) {
                                  cubit.coldDrinkSugarPressed(index);
                                },
                                isSelectedList: coldDrinkSugarSelected,
                                constToggleChildren:
                                coldDrinkSugarChildren,
                                context: context,
                              ),
                              Container(
                                padding: const EdgeInsetsDirectional.only(
                                    bottom: 10),
                                width: 230,
                                height: 50,
                                child: defaultFormField(
                                  context: context,
                                  textDirection: TextDirection.rtl,
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
                              Text('حسابك : ${model.price} جنيه ',
                                  style: const TextStyle(fontSize: 20)),
                              defaultButton(
                                  fontSize: 20,
                                  icon: FontAwesomeIcons.rocket,
                                  label: '(:  خمسة و جايلك',
                                  onPressed: () {
                                    cubit.orderComplete(
                                      isCold: isCold,
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
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 55 ),
                          child: Material(
                            borderRadius:
                            BorderRadiusDirectional.circular(22),
                            child: CircleAvatar(
                              radius: 20,
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
                )
            );
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
                  textAlign: TextAlign.center,
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
