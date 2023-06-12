import 'package:eatmore_app/users/view/resources/assets_manager.dart';
import 'package:eatmore_app/users/view/resources/color_manager.dart';
import 'package:eatmore_app/users/view/resources/font_manager.dart';
import 'package:eatmore_app/users/view/resources/size_confige.dart';
import 'package:eatmore_app/users/view/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../view_model/shoping_cart/cubit.dart';
import '../../view_model/theme/cubit.dart';
import '../account/account_view.dart';
import '../home/widget/image_appbar/image_appbar.dart';

class ShopCart extends StatefulWidget {
  const ShopCart({Key? key}) : super(key: key);

  @override
  State<ShopCart> createState() => _ShopCartState();
}

class _ShopCartState extends State<ShopCart> {
  List orderList = [];
  int? totalPrice;
  bool selectPlaceOrder = false;
  bool? selectRemove = false;

  @override
  void initState() {
    database.getAll().then((value) {
      setState(() {
        totalPrice = 0;
        orderList = value;
        if (selectRemove == false) {
          for (var order in orderList) {
            totalPrice = totalPrice! + int.parse(order['price']);
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return SafeArea(
      child: BlocProvider(
        create: (context) => ShopCartCubit(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: theme.isDark ? ColorManger.white : ColorManger.black,
                )),
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
            child: Column(
              children: [
                const SizedBox(height: 10),
                orderList.isEmpty
                    ? SizedBox(
                        height: SizeConfig.screenHeight! / 1.3,
                        width: SizeConfig.screenWidth! / 1.3,
                        child: Center(
                          child: Stack(
                            children: [
                              Image.asset(
                                ImageAsset.isEmpty,
                              ),
                              Positioned(
                                bottom: SizeConfig.screenHeight! / 5.5,
                                right: SizeConfig.screenWidth! / 6,
                                child: Text(
                                  AppString.yourCartIsEmpty.tr,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWhightManager.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        height: SizeConfig.screenHeight! / 1.3,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            if (selectPlaceOrder == true) {
                              context
                                  .read<ShopCartCubit>()
                                  .sendOrderToHistoryData(
                                    orderList[index]['image'],
                                    orderList[index]['price'],
                                    orderList[index]['title'],
                                  );

                              database
                                  .deleteDatabase(id: orderList[index]['id'])
                                  .then((value) {
                                context
                                    .read<ShopCartCubit>()
                                    .getLocation()
                                    .then((value) {
                                  context
                                      .read<ShopCartCubit>()
                                      .sendOrderToAdmin(
                                        orderList[index]['image'],
                                        orderList[index]['price'],
                                        orderList[index]['title'],
                                      )
                                      .then((value) {
                                    database.getAll().then((valuee) {
                                      setState(() {
                                        orderList = valuee;
                                      });
                                    });
                                  });
                                });
                              });
                            }

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: ColorManger.primary),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                leading: SizedBox(
                                  width: SizeConfig.screenWidth! / 7.5,
                                  child: Image(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          orderList[index]['image'])),
                                ),
                                title: Text(
                                  orderList[index]['title'],
                                ),
                                subtitle: Text(orderList[index]['price']),
                                trailing: IconButton(
                                    onPressed: () {
                                      removeDialog(
                                        context,
                                        () {
                                          removeItem(index: index);
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.more_vert)),
                              ),
                            );
                          },
                          itemCount: orderList.length,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: SizeConfig.screenHeight! / 9,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorManger.black, width: 3),
                      borderRadius: BorderRadius.circular(20),
                      color: ColorManger.primary.withRed(200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: double.infinity,
                          width: SizeConfig.screenWidth! / 2,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(17)),
                            color: ColorManger.grey,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Stack(
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      color: ColorManger.white,
                                      size: SizeConfig.screenHeight! / 12,
                                    ),
                                    Positioned(
                                      bottom: SizeConfig.screenHeight! / 24,
                                      right: SizeConfig.screenWidth! / 15,
                                      child: Text(
                                        '${orderList.length}',
                                        style: TextStyle(
                                            color: ColorManger.black,
                                            fontSize:
                                                SizeConfig.screenHeight! / 50,
                                            fontWeight: FontWhightManager.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: SizeConfig.screenHeight! / 24,
                                right: SizeConfig.screenWidth! / 15,
                                child: Text(
                                  '${AppString.totalPrice.tr} $totalPrice',
                                  style: TextStyle(
                                      color: ColorManger.white,
                                      fontSize: SizeConfig.screenWidth! / 25,
                                      fontWeight: FontWhightManager.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BlocConsumer<ShopCartCubit, ShopCartState>(
                          listener: (context, state) {
                            if (state is ShopCartSuccess) {
                              final snackBar = SnackBar(
                                  content: Icon(
                                    Icons.done,
                                    color: ColorManger.white,
                                  ),
                                  backgroundColor: ColorManger.success);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          builder: (context, state) {
                            if (state is ShopCartLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  if (orderList.isEmpty) {
                                    emptyOrder(context);
                                  } else {
                                    placeOrder(context);
                                  }
                                },
                                child: Container(
                                  width: SizeConfig.screenWidth! / 2.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: ColorManger.primary.withRed(200),
                                  ),
                                  child: Text(
                                    AppString.sendOrder.tr,
                                    style: TextStyle(
                                        fontSize: FontSize.s22,
                                        fontWeight: FontWhightManager.medium,
                                        color: ColorManger.white),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  removeItem({int? index}) {
    database.deleteDatabase(id: orderList[index!]['id']).then((value) {
      database.getAll().then((value) {
        setState(() {
          totalPrice = totalPrice! - int.parse(orderList[index]['price']);
          orderList = value;
          selectRemove = true;
        });
        Navigator.of(context).pop();
      });
    });
  }

  Future<void> placeOrder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppString.confirmation.tr),
          content: Text(
            AppString.cancel.tr,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                AppString.no.tr,
                style: const TextStyle(color: ColorManger.primary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                AppString.yas.tr,
                style: const TextStyle(color: ColorManger.primary),
              ),
              onPressed: () async {
                LocationPermission per;
                per = await Geolocator.checkPermission();
                if (per != LocationPermission.denied) {
                  setState(() {
                    selectPlaceOrder = true;
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                } else {
                  per = await Geolocator.requestPermission();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> emptyOrder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppString.note.tr),
          content: Text(
            AppString.youDoNotHaveOrdersInTheShoppingCart.tr,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                AppString.ok.tr,
                style: const TextStyle(color: ColorManger.primary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  removeDialog(BuildContext context, Function()? onTap) {
    Widget okButton = TextButton(
      onPressed: onTap,
      child: Text(AppString.ok.tr),
    );
    Widget cancelButton = TextButton(
      child: Text(AppString.cancel.tr),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(AppString.remove.tr),
      content: Text(AppString.doYouReallyWantToDeleteThisItem.tr),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        cancelButton,
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // sendOrder(
  //   int? index,
  //   String? image,
  //   String? price,
  //   String? title,
  // ) async {
  //   setState(() {
  //     selectPlaceOrder = true;
  //   });

  //   //
  // }
}
