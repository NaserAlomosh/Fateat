import 'package:eatmore_app/admin/view_model/delete_prodect/cubit.dart';
import 'package:eatmore_app/admin/view_model/delete_prodect/states.dart';
import 'package:eatmore_app/users/view/resources/strings_manager.dart';
import 'package:eatmore_app/users/view/widget/custem_buttom.dart';
import 'package:eatmore_app/users/view_model/theme/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../users/view/resources/color_manager.dart';
import '../../../users/view/resources/font_manager.dart';
import '../../../users/view/resources/size_confige.dart';
import '../home_admin/home_admin.dart';

class DetailsAdminView extends StatelessWidget {
  final String image;

  final String title;

  final String descrption;

  final String price;
  final String id;
  final String tybe;

  const DetailsAdminView({
    Key? key,
    required this.image,
    required this.title,
    required this.descrption,
    required this.price,
    required this.id,
    required this.tybe,
    //required this.price, required this.id, required this.tybe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return BlocProvider(
      create: (context) => DeleteProdectCubit(),
      child: SafeArea(
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
                                  fontSize: FontSize.s16,
                                  fontWeight: FontWhightManager.bold),
                            ),
                            SizedBox(height: SizeConfig.screenHeight! / 30),
                            Text(
                              '\$$price',
                              style: const TextStyle(
                                  fontSize: FontSize.s18,
                                  fontWeight: FontWhightManager.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth! / 10,
                            vertical: SizeConfig.screenHeight! / 30),
                        child: BlocConsumer<DeleteProdectCubit,
                            DeleteProdectStates>(
                          listener: (context, state) {
                            if (state is DeleteProdectSuccessState) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const HomeAdmin()),
                                  (Route<dynamic> route) => false);
                            }
                          },
                          builder: (context, state) {
                            if (state is DeleteProdectLoadingState) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return CustemBottom(
                                lable: AppString.remove.tr,
                                onTap: () {
                                  context
                                      .read<DeleteProdectCubit>()
                                      .deleteProdect(
                                        tybe: tybe,
                                        idProdect: id,
                                      );
                                },
                              );
                            }
                          },
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
