import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../view_model/theme/cubit.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/size_confige.dart';
import '../resources/strings_manager.dart';
import '../widget/custem_buttom.dart';

class DetailsView extends StatelessWidget {
  final String image;

  final String title;

  final String descrption;

  final String price;

  const DetailsView(
      {Key? key,
      required this.image,
      required this.title,
      required this.descrption,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                height: SizeConfig.screenHeight! / 1,
                width: SizeConfig.screenWidth! / 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: const Alignment(1, 2),
                    colors: <Color>[
                      ColorManger.primary,
                      ColorManger.grey,
                    ],
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorManger.white,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: ColorManger.black,
                                size: 18,
                              )),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight! / 20),
                      SizedBox(
                          height: SizeConfig.screenHeight! / 4,
                          width: SizeConfig.screenWidth! / 1,
                          child: Image(image: NetworkImage(image)))
                    ],
                  ),
                )),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: SizeConfig.screenHeight! / 1.8,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(60),
                  ),
                  color: theme.isDark ? ColorManger.black : ColorManger.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight! / 18,
                        left: SizeConfig.screenWidth! / 15,
                        right: SizeConfig.screenWidth! / 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: FontSize.s20,
                                fontWeight: FontWhightManager.bold),
                          ),
                          SizedBox(height: SizeConfig.screenHeight! / 30),
                          Text(
                            descrption,
                            style: const TextStyle(
                                fontSize: FontSize.s18,
                                fontWeight: FontWhightManager.bold),
                          ),
                          SizedBox(height: SizeConfig.screenHeight! / 30),
                          Text(
                            '\$$price',
                            style: const TextStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWhightManager.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth! / 10,
                          vertical: SizeConfig.screenHeight! / 30),
                      child: CustemBottom(
                          lable: AppString.addToCart.tr,
                          onTap: () {
                            database
                                .insertToDatabase(image, title, price)
                                .then((V) {
                              database.getAll().then((value) {
                                log(value.toString());
                              });
                            });
                            SnackBar snackBar = SnackBar(
                              content: Text(AppString.done.tr),
                              backgroundColor: Colors.green,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
