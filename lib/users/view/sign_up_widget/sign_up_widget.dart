import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../view_model/sign_up/cubit.dart';
import '../../view_model/sign_up/states.dart';
import '../main_sign_in_up/main_sign.dart';
import '../resources/color_manager.dart';
import '../resources/icon_manager.dart';
import '../resources/size_confige.dart';
import '../resources/strings_manager.dart';
import '../widget/custem_buttom.dart';
import '../widget/custem_textfield_email.dart';
import '../widget/custem_textfield_password.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key}) : super(key: key);

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
            SizedBox(width: SizeConfig.screenWidth! / 30),
            Text(text!.tr),
          ],
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight! / 50),
            CustemTextField(
              icon: Icon(
                Icons.person,
                color: ColorManger.black,
              ),
              hintText: AppString.enterYourName.tr,
              controller: nameController,
            ),
            SizedBox(height: SizeConfig.screenHeight! / 50),
            CustemTextField(
              icon: Icon(
                Icons.email_outlined,
                color: ColorManger.black,
              ),
              hintText: AppString.enterYourEmail.tr,
              controller: emailController,
            ),
            SizedBox(height: SizeConfig.screenHeight! / 50),
            CustemTextField(
              textInputType: TextInputType.phone,
              icon: Icon(
                Icons.phone_iphone_outlined,
                color: ColorManger.black,
              ),
              hintText: AppString.enterYourNumber.tr,
              controller: phoneController,
            ),
            SizedBox(height: SizeConfig.screenHeight! / 50),
            CustemTextFieldPassword(
              hintText: AppString.enterPassword.tr,
              controller: passwordController,
            ),
            SizedBox(height: SizeConfig.screenHeight! / 20),
            BlocConsumer<SignUpCubit, SignUpStates>(
              listener: (context, state) {
                if (state is SignUpSuccessState) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SignInView()),
                      (Route<dynamic> route) => false);
                  snackBar(
                    text: AppString.theAccountHasBeenCreated,
                    color: ColorManger.success,
                  );
                } else if (state is SignUpEmailErrorState) {
                  snackBar(
                      text: AppString.theAccountAlreadyExistsForThatEmail,
                      color: ColorManger.error);
                } else if (state is SignUpErrorPassworState) {
                  snackBar(
                      text: AppString.passwordLessThan6Characters,
                      color: ColorManger.error);
                } else if (state is SignUpEmailInValidState) {
                  snackBar(
                      text: AppString.emailinValid.tr,
                      color: ColorManger.error);
                }
              },
              builder: (context, state) {
                if (state is SignUpLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return CustemBottom(
                    lable: AppString.signUp.tr,
                    onTap: () {
                      if (emailController.text != "" &&
                          passwordController.text != "" &&
                          nameController.text != "" &&
                          phoneController.text != "") {
                        context.read<SignUpCubit>().signUpUser(
                            email: emailController.text.trim(),
                            pass: passwordController.text.trim(),
                            name: nameController.text,
                            phone: phoneController.text.trim());
                      } else {
                        snackBar(
                            text: AppString.allFieldsAreRequired.tr,
                            color: ColorManger.error);
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
