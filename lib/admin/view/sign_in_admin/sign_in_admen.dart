import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:eatmore_app/admin/view/sign_in_admin/widget/sign_in_admin_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../users/view/main_sign_in_up/main_sign.dart';
import '../../../users/view/resources/assets_manager.dart';
import '../../../users/view/resources/color_manager.dart';
import '../../../users/view/resources/size_confige.dart';
import '../../../users/view/resources/strings_manager.dart';

class AdminSignInView extends StatelessWidget {
  const AdminSignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      Text(AppString.administratorLogIn.tr),
                    ],
                    views: const [
                      SignInAdminWidget(),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInView()),
                  );
                },
                icon: const Icon(Icons.cancel)),
          ],
        ),
      ),
    );
  }
}
