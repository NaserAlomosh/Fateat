import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../utils/translate/translate.dart';

import '../../../users/view/resources/assets_manager.dart';
import '../../../users/view/resources/color_manager.dart';
import '../../../users/view/resources/font_manager.dart';
import '../../../users/view/resources/size_confige.dart';
import '../../../users/view/resources/strings_manager.dart';
import '../../../users/view_model/image_appbar/cubit.dart';
import '../../../users/view_model/theme/cubit.dart';
import '../admin_add_prodect/add_prodect_view.dart';
import '../order_admin/orders_admin.dart';
import '../prodect_Admin/burgers/burgers_view.dart';
import '../prodect_Admin/chicken/chicken_view.dart';
import '../prodect_Admin/pizza/pizza_view.dart';
import '../sign_in_admin/sign_in_admen.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({Key? key}) : super(key: key);

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
            elevation: 0,
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrdersAdmin()),
              );
            },
            child: Center(
              child: Image.asset(ImageAsset.requst),
            ),
          ),
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: <Color>[ColorManger.primary, ColorManger.grey]),
              ),
            ),
            backgroundColor: ColorManger.primary,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const AdminSignInView()),
                    (Route<dynamic> route) => false);
              },
              icon: const Icon(Icons.logout),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddProdectView()),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight! / 20,
                            left: SizeConfig.screenWidth! / 10,
                            right: SizeConfig.screenWidth! / 10,
                          ),
                          child: Text(
                            'Admin',
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
                            AppString.home.tr,
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
                            animationDuration:
                                const Duration(milliseconds: 300),
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
                                  splashColor:
                                      ColorManger.primary.withOpacity(0.5),
                                  unselectedBackgroundColor: ColorManger.white,
                                  unselectedBorderColor: ColorManger.grey,
                                  borderWidth: 1,
                                  tabs: [
                                    Tab(
                                      child: Container(
                                        width: SizeConfig.screenWidth! / 4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                      AdminBurgersView(),
                                      AdminPizzaView(),
                                      AdminChickenView()
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
