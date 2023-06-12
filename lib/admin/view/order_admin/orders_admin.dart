import 'package:eatmore_app/admin/view/detals_request/detals_request.dart';
import 'package:eatmore_app/admin/view_model/order_admin/cubit.dart';
import 'package:eatmore_app/admin/view_model/order_admin/state.dart';
import 'package:eatmore_app/users/view/resources/color_manager.dart';
import 'package:eatmore_app/users/view/resources/size_confige.dart';
import 'package:eatmore_app/users/view/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class OrdersAdmin extends StatelessWidget {
  const OrdersAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderAdminCubit()..getOrderAdmin(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
                color: ColorManger.grey,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.cancel)),
            title: const Text(
              'Order request',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: BlocConsumer<OrderAdminCubit, OrderAdminStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return ListView.builder(
                itemCount:
                    context.read<OrderAdminCubit>().orderAdminList.length,
                itemBuilder: (c, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (a) => DetalisRequestView(
                              descrption: context
                                  .read<OrderAdminCubit>()
                                  .orderAdminList[index]
                                  .description
                                  .toString(),
                              email: context
                                  .read<OrderAdminCubit>()
                                  .orderAdminList[index]
                                  .email
                                  .toString(),
                              image: context
                                  .read<OrderAdminCubit>()
                                  .orderAdminList[index]
                                  .image
                                  .toString(),
                              location: context
                                  .read<OrderAdminCubit>()
                                  .orderAdminList[index]
                                  .location
                                  .toString(),
                              name: context
                                  .read<OrderAdminCubit>()
                                  .orderAdminList[index]
                                  .name
                                  .toString(),
                              phone: context
                                  .read<OrderAdminCubit>()
                                  .orderAdminList[index]
                                  .phone
                                  .toString(),
                              price: context
                                  .read<OrderAdminCubit>()
                                  .orderAdminList[index]
                                  .priceOrder
                                  .toString(),
                              title: context
                                  .read<OrderAdminCubit>()
                                  .orderAdminList[index]
                                  .title
                                  .toString(),
                            )));
                  },
                  child: Padding(
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
                              image: NetworkImage(context
                                  .read<OrderAdminCubit>()
                                  .orderAdminList[index]
                                  .image
                                  .toString()))),
                      title: Text(context
                          .read<OrderAdminCubit>()
                          .orderAdminList[index]
                          .title
                          .toString()),
                      subtitle: Text(context
                          .read<OrderAdminCubit>()
                          .orderAdminList[index]
                          .priceOrder
                          .toString()),
                      trailing: IconButton(
                          onPressed: () {
                            removeDialog(
                              context,
                              () {
                                context
                                    .read<OrderAdminCubit>()
                                    .deleteOrderAdmin();
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          )),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
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
              onPressed: () {
                const snackBar = SnackBar(
                  content: Text(AppString.requestSentIssDone),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> confirmOrder(BuildContext context) {
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
}
