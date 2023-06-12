import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:eatmore_app/users/view/home/widget/darwer/home_drawer.dart';
import 'package:eatmore_app/users/view/home/widget/image_appbar/image_appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../utils/translate/translate.dart';
import '../../view_model/image_appbar/cubit.dart';
import '../../view_model/theme/cubit.dart';

import '../account/account_view.dart';
import '../burgers/burgers_view.dart';
import '../chicken/chicken_view.dart';
import '../pizza/pizza_view.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/size_confige.dart';
import '../resources/strings_manager.dart';
import '../search/search_view.dart';
import '../shop_cart/shop_cart.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TranslationController());

    SizeConfig().init(context);
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ImageAppBarCubit()),
      ],
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorManger.white,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => const ShopCart()));
            },
            child: CircleAvatar(
              radius: SizeConfig.defaultSize! / 0.4,
              backgroundColor: ColorManger.primary,
              child: Image.asset(ImageAsset.shop),
            ),
          ),
          drawer: const HomeDrawer(),
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: theme.isDark ? ColorManger.white : ColorManger.black,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountView()),
                  );
                },
                child: const ImageAppbar(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight! / 40,
                        left: SizeConfig.screenWidth! / 10,
                        right: SizeConfig.screenWidth! / 10,
                      ),
                      child: Text(
                        AppString.chooseThe.tr,
                        style: TextStyle(
                            fontSize: FontSize.s20,
                            color: theme.isDark
                                ? ColorManger.white
                                : ColorManger.black,
                            fontWeight: FontWhightManager.regular),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth! / 10,
                        right: SizeConfig.screenWidth! / 10,
                        bottom: SizeConfig.screenHeight! / 40,
                      ),
                      child: Text(
                        AppString.foodYouLove.tr,
                        style: TextStyle(
                          fontSize: FontSize.s20,
                          color: theme.isDark
                              ? ColorManger.white
                              : ColorManger.black,
                          fontWeight: FontWhightManager.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! / 50),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth! / 12,
                        right: SizeConfig.screenWidth! / 12,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchItem()),
                          );
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            cursorColor: ColorManger.primary,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: ColorManger.black,
                              ),
                              hintText: AppString.searchForAYourFood.tr,
                              hintStyle: TextStyle(
                                  color: theme.isDark
                                      ? ColorManger.grey
                                      : ColorManger.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorManger.primary),
                                gapPadding: 6,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorManger.outlineInputBorder),
                                gapPadding: 6,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              border: OutlineInputBorder(
                                gapPadding: 6,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              filled: true,
                              fillColor: ColorManger.white,
                            ),
                          ),
                        ),
                      ),
                    ),
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
                              backgroundColor:
                                  ColorManger.primary.withOpacity(0.1),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  BurgersView(),
                                  PizzaView(),
                                  ChickenView()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
