
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:take_away/layout/main_layout.dart';
import 'package:take_away/modules/main_modules/register_screen/register_screen.dart';
import 'package:take_away/shared/components/components.dart';
import 'package:take_away/shared/network/local/cache_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              showToast(msg: state.error.toString(), state: ToastStates.ERROR);
            }
            if (state is LoginSuccessState) {

              CacheHelper.saveData(key: 'uId', value: state.uId).then((
                  value) async {
              navigateAndFinishTo(context,  const MainLayout());
              }).catchError((error) {
                print('Error is ${error.toString()}');
              });
            }
          },
          builder: (context, state) {
            var cubit = LoginCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '7HEVƎN',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                    color: Colors.blueGrey[700],
                                    fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(width: 20,),
                              const CircleAvatar(
                                child: Icon(
                                  Icons.coffee, size: 40,),
                              ),
                            ],
                          ),
                          Text(

                            'تسجيل دخول',
                            textAlign: TextAlign.end,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                 color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MaterialButton(
                                    onPressed: () {

                                      navigateTo(context, RegisterScreen());
                                    },
                                    child: Text(
                                      'سجل حساب جديد من هنا',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: Theme.of(context).primaryColor.withBlue(1000),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  Text(
                                    'أو',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .headline4!
                                         .copyWith(color: Theme.of(context).primaryColor),
                                  ),


                                ],
                              ),
                              Text(
                                '٫ لتسجيل طلباتك معانا',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline5!
                                     .copyWith(color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            context: context,
                            controller: emailController,
                            label: 'إميلك الجميل',
                            hintText: 'إكتب إميلك',
                            prefixIcon: Icons.email_outlined,
                            keyboard: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'محتاج الإيميل يا معلم';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            context: context,
                            controller: passwordController,
                            hintText: 'إكتب كلمة السر',
                            label: 'كلمة السر',
                            prefixIcon: Icons.lock_outlined,
                            suffixIcon: cubit.suffixIcon,
                            suffixPressed: () {
                              cubit.changeVisibility();
                            },
                            isPassword: cubit.isPassword,
                            keyboard: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'إكتب الباسورد';
                              }
                              return null;
                            },
                            onSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(

                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Conditional.single(
                            context: context,
                            widgetBuilder: (context) =>
                                defaultButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    label: 'تسجيل دخول', fontSize: 20, context: context),
                            conditionBuilder: (
                                context) => state is! LoginLoadingState,
                            fallbackBuilder: (context) =>
                                const Center(child: CircularProgressIndicator()),
                          ),
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
          }),
    );
  }
}
