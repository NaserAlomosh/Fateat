import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../view_model/ruta_us/cubit.dart';
import '../../view_model/ruta_us/state.dart';
import '../../view_model/theme/cubit.dart';
import '../home/home_view.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/size_confige.dart';
import '../resources/strings_manager.dart';
import '../widget/custem_buttom.dart';

class RutaView extends StatefulWidget {
  const RutaView({Key? key}) : super(key: key);

  @override
  State<RutaView> createState() => _RutaViewState();
}

class _RutaViewState extends State<RutaView> {
  late double _rating;
  final int _ratingBarMode = 1;
  final double _initialRating = 3.0;
  final bool _isVertical = false;

  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return SafeArea(
      child: BlocProvider(
        create: (context) => RutaUsCubit()..getUserData(),
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  backgroundColor: ColorManger.grey,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                        color: theme.isDark
                            ? ColorManger.white
                            : ColorManger.black,
                      ))),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Center(
            child: BlocConsumer<RutaUsCubit, RutaUstState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is RutaUstLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight! / 14),
                      Text(
                        AppString.rateOurService.tr,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWhightManager.bold),
                      ),
                      SizedBox(height: SizeConfig.screenHeight! / 24),
                      CircleAvatar(
                        radius: SizeConfig.defaultSize! / 0.15,
                        backgroundColor: ColorManger.primary,
                        child: CircleAvatar(
                          backgroundColor: ColorManger.grey,
                          radius: SizeConfig.defaultSize! / 0.16,
                          child: context.read<RutaUsCubit>().image == ""
                              ? Center(
                                  child: Text(
                                    context
                                        .read<RutaUsCubit>()
                                        .firstCharName
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: SizeConfig.defaultSize! * 7,
                                      fontWeight: FontWhightManager.bold,
                                      color: ColorManger.white,
                                    ),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image(
                                    image: NetworkImage(
                                      context
                                          .read<RutaUsCubit>()
                                          .image
                                          .toString(),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight! / 40),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorManger.primary)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            context.read<RutaUsCubit>().name.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWhightManager.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight! / 24),
                      _ratingBar(_ratingBarMode),
                      SizedBox(height: SizeConfig.screenHeight! / 60),
                      Text(
                        AppString.dontWorryThiswillnotbeSharedWithAnyone.tr,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWhightManager.semiBold),
                      ),
                      SizedBox(height: SizeConfig.screenHeight! / 18),
                      Padding(
                        padding: EdgeInsets.only(
                          right: SizeConfig.screenWidth! / 10,
                          left: SizeConfig.screenWidth! / 10,
                        ),
                        child: CustemBottom(
                          lable: AppString.sendYourRuting.tr,
                          fontSize: 20,
                          onTap: () {
                            context
                                .read<RutaUsCubit>()
                                .sendRutaUs(ruta: _rating);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeView()),
                            );
                            var snackBar = SnackBar(
                                content: Text(AppString.sendRutaIsDone.tr),
                                backgroundColor: ColorManger.success);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          initialRating: _initialRating,
          minRating: 1,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 50.0,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
              log(_rating.toString());
            });
          },
          updateOnDrag: true,
        );
      default:
        return Container();
    }
  }
}
