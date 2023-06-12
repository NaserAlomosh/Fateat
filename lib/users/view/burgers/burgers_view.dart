import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../view_model/burgers/cubit.dart';
import '../../view_model/burgers/states.dart';
import '../details_prodect/details_view.dart';
import '../home/widget/rating_bar/rating_bar.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/size_confige.dart';
import '../resources/strings_manager.dart';

class BurgersView extends StatelessWidget {
  const BurgersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BurgersCubit()..getBurgerData(),
      child: BlocConsumer<BurgersCubit, BurgersStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BurgersLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight! / 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        AppString.burger.tr,
                        style: const TextStyle(
                          fontSize: FontSize.s20,
                          fontWeight: FontWhightManager.semiBold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight! / 2.9,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => DetailsView(
                                    image: context
                                        .read<BurgersCubit>()
                                        .burgerList[index]
                                        .image
                                        .toString(),
                                    price: context
                                        .read<BurgersCubit>()
                                        .burgerList[index]
                                        .price
                                        .toString(),
                                    title: context
                                        .read<BurgersCubit>()
                                        .burgerList[index]
                                        .title
                                        .toString(),
                                    descrption: context
                                        .read<BurgersCubit>()
                                        .burgerList[index]
                                        .description
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(
                                    height: SizeConfig.screenHeight! / 5,
                                    width: double.infinity,
                                    image: NetworkImage(context
                                        .read<BurgersCubit>()
                                        .burgerList[index]
                                        .image
                                        .toString()),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeConfig.screenWidth! / 20,
                                        right: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context
                                              .read<BurgersCubit>()
                                              .burgerList[index]
                                              .title
                                              .toString(),
                                          style: TextStyle(
                                            color: ColorManger.white,
                                            fontSize:
                                                SizeConfig.defaultSize! / 0.8,
                                          ),
                                        ),
                                        StarsRating(
                                            itemSize:
                                                SizeConfig.defaultSize! / 0.6),
                                        Text(
                                          '\$${context.read<BurgersCubit>().burgerList[index].price.toString()}',
                                          style: TextStyle(
                                              color: ColorManger.white,
                                              fontSize:
                                                  SizeConfig.defaultSize! /
                                                      0.5),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        itemCount:
                            context.read<BurgersCubit>().burgerList.length,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
