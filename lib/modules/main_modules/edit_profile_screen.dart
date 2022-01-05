import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:take_away/layout/user_cubit/cubit.dart';
import 'package:take_away/layout/user_cubit/states.dart';
import 'package:take_away/shared/components/components.dart';
import 'package:take_away/shared/styles/icons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var addressController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = UserCubit.get(context);
          var model = UserCubit.get(context).userModel;
          nameController.text = model!.name!;
          emailController.text = model.email!;
          addressController.text = model.address!;
          phoneController.text = model.phone!;
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'حسابي',
              actions: [
                TextButton(
                    onPressed: () {
                      UserCubit.get(context).updateUserData(
                        name: nameController.text,
                        email: emailController.text,
                        address: addressController.text,
                        phone: phoneController.text,
                      );
                    },
                    child: Text(
                      'حدث',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.blue),
                    )),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is LoadingGetUserDataState)
                      const LinearProgressIndicator(),
                    if (state is LoadingGetUserDataState)
                      const SizedBox(
                        height: 10,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(.8),
                              borderRadius: BorderRadiusDirectional.circular(30)
                          ),

                          child:
                              state is SuccessProfileImagePickedState?
                         const Center(child: CircularProgressIndicator()) :
                          cubit.userModel!.hasProfileImage! ?Image.network(
                            cubit.userModel!.image!,
                            width: 195,
                            height: 195,
                            fit: BoxFit.cover,
                          ):const Icon(IconBroken.Profile,size: 70,color: Colors.white,),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey[300],
                          child: Center(
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                        titlePadding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        title: const Text(
                                            'يلا نغير صورة البروفايل',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
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
                                              UserCubit.get(context)
                                                  .getProfileImageFromGallery();
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
                                                    style:
                                                    TextStyle(fontSize: 18)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.camera_sharp,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              UserCubit.get(context)
                                                  .getProfileImageFromCamera();
                                              Navigator.pop(context);
                                            },
                                          ),
                                          SimpleDialogOption(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: const [
                                                Text('إمسح الصورة خالص',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                    TextStyle(fontSize: 18)),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.delete,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              UserCubit.get(context)
                                                  .deleteProfileImage();
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
                                                    style:
                                                    TextStyle(fontSize: 18)),
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
                                icon: const Icon(
                                  IconBroken.Camera,
                                  size: 28,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      label: 'إسمك',
                      prefixIcon: IconBroken.User,
                      keyboard: TextInputType.name,
                      validate: (String? v) {
                        if (v!.isEmpty) {
                          return 'مينفعش الإسم يبقي فاضي';
                        }
                        return null;
                      }, context: context,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: emailController,
                      label: 'إميلك',
                      prefixIcon: Icons.info_outlined,
                      keyboard: TextInputType.text,
                      validate: (String? v) {
                        if (v!.isEmpty) {
                          return 'مينفعش الإميل يبقي فاضي';
                        }
                        return null;
                      }, context: context,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: addressController,
                      label: 'مكانك',
                      prefixIcon: FontAwesomeIcons.mapPin,
                      keyboard: TextInputType.text,
                      validate: (String? v) {
                        if (v!.isEmpty) {
                          return 'مينفعش مكانك يبقي فاضي';
                        }
                        return null;
                      }, context: context,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      label: 'الموبايل',
                      prefixIcon: IconBroken.Call,
                      keyboard: TextInputType.phone,
                      validate: (String? v) {
                        if (v!.isEmpty) {
                          return 'مينفعش الموبايل يبقي فاضي';
                        }
                        return null;
                      }, context: context,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
