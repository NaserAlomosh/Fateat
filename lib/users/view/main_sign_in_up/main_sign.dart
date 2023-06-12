import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../admin/view/sign_in_admin/sign_in_admen.dart';
import '../../../utils/translate/translate.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/size_confige.dart';
import '../resources/strings_manager.dart';
import '../sign_in_widget/sign_in_widget.dart';
import '../sign_up_widget/sign_up_widget.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    Get.put(TranslationController());

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              ImageAsset.signInLoge,
              width: double.infinity,
              height: SizeConfig.defaultSize! * 22,
            ),
            Positioned(
                top: SizeConfig.defaultSize! * 10,
                left: SizeConfig.defaultSize! * 12.25,
                child: Image.asset(ImageAsset.splashLogo)),
            Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.defaultSize! * 20,
                right: SizeConfig.defaultSize! * 5,
                left: SizeConfig.defaultSize! * 5,
              ),
              child: SingleChildScrollView(
                child: Container(
                  height: SizeConfig.defaultSize! * 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorManger.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 20,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ContainedTabBarView(
                    tabBarProperties: TabBarProperties(
                      indicatorColor: ColorManger.primary,
                      labelColor: ColorManger.primary,
                      unselectedLabelStyle: TextStyle(
                        color: ColorManger.darkGrey,
                      ),
                    ),
                    tabs: [
                      Text(AppString.logIn.tr),
                      Text(AppString.signUp.tr),
                    ],
                    views: const [
                      SignInWidget(),
                      SignUpWidget(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminSignInView()),
                    );
                  },
                  icon: const Icon(Icons.admin_panel_settings_outlined)),
            ),
          ],
        ),
      ),
    );
  }
}
