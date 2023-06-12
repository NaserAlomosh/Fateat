import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../users/view/resources/color_manager.dart';
import '../../../../users/view/resources/font_manager.dart';
import '../../../../users/view/resources/icon_manager.dart';
import '../../../../users/view/resources/size_confige.dart';
import '../../../../users/view/resources/strings_manager.dart';
import '../../../../users/view/widget/custem_buttom.dart';
import '../../../../users/view/widget/custem_textfield_email.dart';

import '../../../../users/view/widget/custem_textfield_password.dart';
import '../../home_admin/home_admin.dart';

class SignInAdminWidget extends StatelessWidget {
  const SignInAdminWidget({Key? key}) : super(key: key);

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: SizeConfig.defaultSize! * 3),
          Text(
            'Admin',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWhightManager.semiBold,
                color: ColorManger.grey),
          ),
          SizedBox(height: SizeConfig.defaultSize! * 3),
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
          SizedBox(height: SizeConfig.screenHeight! / 30),
          CustemBottom(
              lable: AppString.logIn.tr,
              onTap: () {
                if (emailController.text == 'admin@gmail.com' &&
                    passwordController.text == '123456') {
                  snackBar(color: ColorManger.success, text: AppString.welcome);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeAdmin()),
                  );
                } else {
                  snackBar(
                      color: ColorManger.error,
                      text: AppString.theEmailOrPasswordIsIncorrect);
                }
              })
        ],
      ),
    );
  }
}
