import 'package:eatmore_app/users/view/resources/color_manager.dart';
import 'package:eatmore_app/users/view_model/sign_in/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../view_model/sign_in/states.dart';
import '../home/home_view.dart';
import '../resources/icon_manager.dart';
import '../resources/size_confige.dart';
import '../resources/strings_manager.dart';
import '../widget/custem_buttom.dart';
import '../widget/custem_textfield_email.dart';
import '../widget/custem_textfield_password.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    snackBar({String? text, Color? color}) {
      final snackBar = SnackBar(
        duration: const Duration(milliseconds: 1500),
        backgroundColor: color,
        content: Row(
          children: [
            Icon(
              color == ColorManger.error
                  ? IconManager.error
                  : IconManager.success,
              color: ColorManger.white,
            ),
            SizedBox(width: SizeConfig.defaultSize! * 1),
            Text(text!),
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => SigninCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: SizeConfig.defaultSize! * 4),
            CustemTextField(
              hintText: AppString.enterYourEmail.tr,
              icon: Icon(
                Icons.email_outlined,
                color: ColorManger.black,
              ),
              controller: emailController,
            ),
            SizedBox(height: SizeConfig.defaultSize! * 2),
            CustemTextFieldPassword(
              hintText: AppString.enterPassword.tr,
              controller: passwordController,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.defaultSize! * 2, right: 8, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {},
                      child: Text(AppString.forgetPassword.tr,
                          style: TextStyle(color: ColorManger.black))),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize! * 4),
            BlocConsumer<SigninCubit, SigninStates>(
              listener: (context, state) {
                //
                if (state is SigninSuccessState) {
                  snackBar(
                    text: AppString.welcome.tr,
                    color: ColorManger.success,
                  );
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeView()));
                } else if (state is SigninNotFoundUserState) {
                  snackBar(
                    text: AppString.noUserFoundForThatEmail.tr,
                    color: ColorManger.error,
                  );
                } else if (state is SigninEmailOrPasswordErrorState) {
                  snackBar(
                    text: AppString.theEmailOrPasswordIsIncorrect.tr,
                    color: ColorManger.error,
                  );
                }
              },
              builder: (context, state) {
                if (state is SigninLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return CustemBottom(
                    lable: AppString.logIn.tr,
                    onTap: () {
                      if (emailController.text != "" &&
                          passwordController.text != "") {
                        context.read<SigninCubit>().signInUser(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                      } else {
                        snackBar(
                          text: AppString.allFieldsAreRequired.tr,
                          color: ColorManger.error,
                        );
                      }
                    },
                  );
                }
              },
            ),
            SizedBox(height: SizeConfig.screenHeight! / 30),
          ],
        ),
      ),
    );
  }
}
