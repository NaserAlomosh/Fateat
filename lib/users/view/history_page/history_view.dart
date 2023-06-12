import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../view_model/history/cubit.dart';
import '../../view_model/history/state.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/size_confige.dart';
import '../resources/strings_manager.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HistoryCubit()..getHistory(),
        child: SafeArea(
          child: Scaffold(
              body: BlocConsumer<HistoryCubit, HistoryStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Stack(
                children: [
                  Positioned(
                      left: 5,
                      top: 5,
                      child: IconButton(
                          color: ColorManger.grey,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: ColorManger.grey,
                          ))),
                  Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight! / 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppString.productsYouHavePurchased.tr,
                          style: TextStyle(
                              fontSize: SizeConfig.screenHeight! / 40,
                              fontWeight: FontWhightManager.semiBold),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! / 1.2,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount:
                              context.read<HistoryCubit>().dataAll.length,
                          itemBuilder: (context, index) {
                            if (state is HistoryLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: ColorManger.primary),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  leading: SizedBox(
                                    height: SizeConfig.screenHeight! / 16,
                                    width: SizeConfig.screenWidth! / 7.5,
                                    child: Image(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        context
                                            .read<HistoryCubit>()
                                            .dataAll[index]
                                            .image
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    context
                                        .read<HistoryCubit>()
                                        .dataAll[index]
                                        .title
                                        .toString(),
                                  ),
                                  trailing: Text(
                                      '\$${context.read<HistoryCubit>().dataAll[index].price}'),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          )),
        ));
  }
}
