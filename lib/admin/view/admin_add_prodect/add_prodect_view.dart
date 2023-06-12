import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:eatmore_app/admin/view/admin_add_prodect/pizza/add_pizza_view.dart';
import 'package:eatmore_app/users/view/resources/assets_manager.dart';
import 'package:eatmore_app/users/view_model/theme/cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../users/view/resources/color_manager.dart';
import '../../../users/view/resources/font_manager.dart';
import '../../../users/view/resources/size_confige.dart';
import '../../../users/view/resources/strings_manager.dart';
import 'burgers/add_burgers_view.dart';
import 'chicken/add_chicken_view.dart';

class AddProdectView extends StatelessWidget {
  const AddProdectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight! / 40,
                  left: SizeConfig.screenWidth! / 14,
                  right: SizeConfig.screenWidth! / 14,
                ),
                child: Container(
                  height: SizeConfig.screenHeight! / 6,
                  width: SizeConfig.screenWidth! / 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: const Alignment(0.8, 1),
                      colors: <Color>[
                        ColorManger.primary,
                        ColorManger.primary.withOpacity(0.5),
                      ],
                      tileMode: TileMode.mirror,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 1),
                        blurStyle: BlurStyle.solid,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Add New',
                        style: TextStyle(
                            fontSize: FontSize.s28,
                            color: theme.isDark
                                ? ColorManger.white
                                : ColorManger.white,
                            fontWeight: FontWhightManager.regular),
                      ),
                      Text(
                        'Prodect',
                        style: TextStyle(
                          fontSize: FontSize.s28,
                          color: theme.isDark
                              ? ColorManger.white
                              : ColorManger.white,
                          fontWeight: FontWhightManager.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight! / 50),
              SizedBox(height: SizeConfig.screenHeight! / 50),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth! / 12.5,
                  right: SizeConfig.screenWidth! / 12.5,
                ),
                child: Text(
                  AppString.categories.tr,
                  style: const TextStyle(
                      fontWeight: FontWhightManager.semiBold,
                      fontSize: FontSize.s18),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight! / 80),
              SizedBox(
                height: SizeConfig.screenHeight! / 1.6,
                child: DefaultTabController(
                  animationDuration: const Duration(milliseconds: 300),
                  length: 3,
                  child: Column(
                    children: [
                      ButtonsTabBar(
                        radius: 20,
                        height: SizeConfig.screenHeight! / 10,
                        backgroundColor: ColorManger.primary.withOpacity(0.1),
                        borderColor: ColorManger.primary,
                        unselectedLabelStyle:
                            TextStyle(color: ColorManger.white),
                        splashColor: ColorManger.primary.withOpacity(0.5),
                        unselectedBackgroundColor: ColorManger.white,
                        unselectedBorderColor: ColorManger.grey,
                        borderWidth: 1,
                        tabs: [
                          Tab(
                            child: Container(
                              width: SizeConfig.screenWidth! / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageAsset.burger,
                                    color: ColorManger.primary,
                                  ),
                                  Text(
                                    AppString.burger.tr,
                                    style: const TextStyle(
                                        color: ColorManger.primary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              width: SizeConfig.screenWidth! / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageAsset.fastFood,
                                    color: ColorManger.primary,
                                  ),
                                  Text(
                                    AppString.pizza.tr,
                                    style: const TextStyle(
                                        color: ColorManger.primary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              width: SizeConfig.screenWidth! / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageAsset.chicken,
                                    color: ColorManger.primary,
                                  ),
                                  Text(
                                    AppString.chicken.tr,
                                    style: const TextStyle(
                                        color: ColorManger.primary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            AddBurgersView(),
                            AddPizzaView(),
                            AddChickenView()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
