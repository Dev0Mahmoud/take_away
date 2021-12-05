import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:take_away/layout/admin_cubit/cubit.dart';
import 'package:take_away/layout/admin_cubit/states.dart';
import 'package:take_away/model/drinks_model.dart';
import 'package:take_away/shared/components/components.dart';

import 'drinks_menu_admin_screen.dart';

class EditDrinkData extends StatelessWidget {
  EditDrinkData({Key? key, required this.model,required this.isCold}) : super(key: key);
  DrinksModel model;
  bool isCold;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        TextEditingController drinkNameController = TextEditingController();
        drinkNameController.text = model.drinkName;
        var formKey = GlobalKey<FormState>();
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  reverse: true,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                    children: [
                                      SimpleDialogOption(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Text(
                                              'صورة من عندك',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.image,
                                              color: Colors.blueGrey,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          cubit.getDrinkImageFromGallery();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      SimpleDialogOption(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Text('كاميرا',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 18)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.camera_sharp,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          cubit.getDrinkImageFromCamera();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      SimpleDialogOption(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Text('لا خلاص',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 18)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ));
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10)),
                              child: Center(
                                  child: state is SuccessDrinkImagePickedState
                                      ? const CircularProgressIndicator()
                                      : Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (model.drinkImage.isEmpty)
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .only(
                                                                end: 20.0,
                                                                bottom: 40),
                                                    child: Icon(
                                                      FontAwesomeIcons.coffee,
                                                      size: 90,
                                                    ),
                                                  ),
                                                  Text(
                                                    'صورة المشروب الجديد',
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                  ),
                                                ],
                                              ),
                                            if (model.drinkImage.isNotEmpty)
                                              cubit.drinkImageUrl == ''
                                                  ? Image.network(
                                                      model.drinkImage,
                                                      height: 295,
                                                      width: 295,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      cubit.drinkImageUrl!,
                                                      height: 295,
                                                      width: 295,
                                                      fit: BoxFit.cover,
                                                    ),
                                          ],
                                        )),
                            ),
                            Container(
                              width: 300,
                              color: Colors.black.withOpacity(0.7),
                              child: const Text(
                                'اضغط لتغير الصورة',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        context: context,
                        textDirection: TextDirection.rtl,
                        controller: drinkNameController,
                        label: 'إسم المشروب الجديد',
                        keyboard: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return '!! هتعمل مشروب جديد إزاي من غير إسم أو صورة';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Conditional.single(
                        context: context,
                        widgetBuilder: (context) => defaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate() &&
                                      cubit.drinkImageUrl != '' ||
                                  model.drinkImage.isNotEmpty) {
                                    if(isCold){
                                  cubit.updateColdDrinkData(
                                    id: model.id,
                                    drinkName: drinkNameController.text,
                                    imageUrl: cubit.drinkImageUrl!.isNotEmpty
                                        ? cubit.drinkImageUrl!
                                        : model.drinkImage,
                                  );
                                }else{
                                      cubit.updateHotDrinkData(
                                        id: model.id,
                                        drinkName: drinkNameController.text,
                                        imageUrl: cubit.drinkImageUrl!.isNotEmpty
                                            ? cubit.drinkImageUrl!
                                            : model.drinkImage,
                                      );
                                    }
                                navigateAndFinishTo(
                                    context, const DrinksMenuAdminScreen());
                                cubit.drinkImageUrl = '';
                                drinkNameController.clear();
                              }
                            },
                            label: 'كدا تمام',
                            context: context,
                            fontSize: 20),
                        conditionBuilder: (context) =>
                            state is! LoadingAddDrinkState,
                        fallbackBuilder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultButton(
                          onPressed: () {
                                if(isCold){
                                  cubit.deleteColdDrink(
                                    id: model.id,
                                  );
                                }else{
                              cubit.deleteHotDrink(
                                id: model.id,
                              );
                            }
                            cubit.drinkImageUrl = '';
                            navigateAndFinishTo(
                                context, const DrinksMenuAdminScreen());
                          },
                          label: 'امسح المشروب',
                          color: Colors.red,
                          context: context,
                          fontSize: 20),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultButton(
                          onPressed: () {
                            cubit.drinkImageUrl = '';
                            navigateAndFinishTo(
                                context, const DrinksMenuAdminScreen());
                          },
                          label: 'لا خلاص',
                          context: context,
                          fontSize: 20),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
