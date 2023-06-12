import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../view_model/pizza/cubit.dart';
import '../../view_model/pizza/states.dart';
import '../details_prodect/details_view.dart';
import '../home/widget/rating_bar/rating_bar.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/size_confige.dart';
import '../resources/strings_manager.dart';

class PizzaView extends StatelessWidget {
  const PizzaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PizzaCubit()..getPizzaData(),
      child: BlocConsumer<PizzaCubit, PizzaStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PizzaLoadingState) {
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
                    SizedBox(height: SizeConfig.screenHeight! / 50),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth! / 18,
                          vertical: SizeConfig.screenHeight! / 100),
                      child: Text(
                        AppString.pizza.tr,
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
                                        .read<PizzaCubit>()
                                        .pizzaList[index]
                                        .image
                                        .toString(),
                                    price: context
                                        .read<PizzaCubit>()
                                        .pizzaList[index]
                                        .price
                                        .toString(),
                                    title: context
                                        .read<PizzaCubit>()
                                        .pizzaList[index]
                                        .title
                                        .toString(),
                                    descrption: context
                                        .read<PizzaCubit>()
                                        .pizzaList[index]
                                        .description
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 400,
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
                                        .read<PizzaCubit>()
                                        .pizzaList[index]
                                        .image
                                        .toString()),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.screenWidth! / 20,
                                      right: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context
                                              .read<PizzaCubit>()
                                              .pizzaList[index]
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
                                          '\$${context.read<PizzaCubit>().pizzaList[index].price.toString()}',
                                          style: TextStyle(
                                            color: ColorManger.white,
                                            fontSize:
                                                SizeConfig.defaultSize! / 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        itemCount: context.read<PizzaCubit>().pizzaList.length,
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
