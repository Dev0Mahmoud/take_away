import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:take_away/layout/main_layout.dart';
import 'package:take_away/shared/components/components.dart';
import 'package:take_away/shared/network/local/cache_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';


class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if(state is RegisterErrorState){
              showToast(msg: state.error.toString(), state: ToastStates.ERROR);
            }
            if (state is CreateUserSuccessState){
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
                // Cubit.get(context).getUserData();
                navigateAndFinishTo(context, const MainLayout());
              }).catchError((error){print('Error is ${error.toString()}');});
            }
          },
          builder: (context, state) {
        RegisterCubit cubit = RegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'يلا نعمل حساب جديد',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                      context: context,
                      controller: nameController,
                      label: 'إسمك سيادتك',
                      prefixIcon: Icons.person,
                      keyboard: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'إسمك مهم و الله';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      context: context,
                      controller: phoneController,
                      label: 'رقم موبايلك',
                      prefixIcon: Icons.smartphone,
                      keyboard: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'أهم حاجة رقم الموبايل';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      context: context,
                      controller: addressController,
                      label: 'العنوان ٫٫ أو إسم المحل',
                      prefixIcon: Icons.home,
                      keyboard: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'لازم العنوان';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      context: context,
                      controller: emailController,
                      label: 'الإيميل',
                      prefixIcon: Icons.email_outlined,
                      keyboard: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'هنسجل إزاي من غيره!!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      context: context,
                      controller: passwordController,
                      label: 'كلمة السر',
                      prefixIcon: Icons.lock_outlined,
                      suffixIcon: cubit.passwordSuffixIcon,
                      suffixPressed: () {
                        cubit.changeVisibility();
                      },
                      isPassword: cubit.isPassword,
                      keyboard: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'فين الباسورد';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      context: context,
                      controller: confirmPasswordController,
                      label: 'تأكيد كلمة السر',
                      hintText: 'إكتب الباسورد تاني',
                      prefixIcon: Icons.lock_outlined,
                      suffixIcon: cubit.confirmedPasswordSuffixIcon,
                      suffixPressed: () {
                        cubit.changeConfirmVisibility();
                      },
                      isPassword: cubit.isConfirmPassword,
                      keyboard: TextInputType.visiblePassword,
                      validate: (String? value) {
                         if(value!.isEmpty){
                          return 'مهم جداَ';
                        }else
                        if (value != passwordController.text) {
                          return 'الباسورد غلط';

                        }
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Conditional.single(
                      context: context,
                      widgetBuilder: (context) => defaultButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                name: nameController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          label: 'تسجيل', context: context, fontSize: 20),
                      conditionBuilder: (context) => state is! RegisterLoadingState,
                      fallbackBuilder: (context) => const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
