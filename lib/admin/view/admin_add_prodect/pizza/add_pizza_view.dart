import 'dart:io';

import 'package:eatmore_app/users/view/widget/custem_buttom.dart';
import 'package:eatmore_app/users/view/widget/custem_textfield_email.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../users/view/resources/color_manager.dart';
import '../../../../users/view/resources/icon_manager.dart';
import '../../../../users/view/resources/size_confige.dart';
import '../../../../users/view/resources/strings_manager.dart';
import '../../../view_model/add_pizza/cubit.dart';
import '../../../view_model/add_pizza/states.dart';
import '../../home_admin/home_admin.dart';

class AddPizzaView extends StatelessWidget {
  const AddPizzaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController descrptionController = TextEditingController();

    return BlocProvider(
        create: (context) => AddPizzaCubit(),
        child: BlocConsumer<AddPizzaCubit, AddPizzaStates>(
          listener: (context, state) {
            if (state is AddPizzaSendDataSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (c) => const HomeAdmin()),
              );
            }
          },
          builder: (context, state) {
            if (state is AddPizzaLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth! / 8,
                  vertical: SizeConfig.screenHeight! / 24,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: SizeConfig.screenHeight! / 6,
                        width: double.infinity,
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
                        child:
                            context.read<AddPizzaCubit>().selectImage == false
                                ? IconButton(
                                    onPressed: () {
                                      context
                                          .read<AddPizzaCubit>()
                                          .getImagePicker();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: ColorManger.white,
                                      size: 50,
                                    ),
                                  )
                                : Image.file(
                                    fit: BoxFit.fill,
                                    File(
                                      context.read<AddPizzaCubit>().file!.path,
                                    ),
                                  ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth! / 2.8,
                              child: CustemTextField(
                                hintText: 'Title',
                                controller: titleController,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth! / 2.8,
                              child: CustemTextField(
                                hintText: AppString.price,
                                controller: priceController,
                                textAlign: TextAlign.center,
                                textInputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustemTextField(
                        hintText: 'description',
                        controller: descrptionController,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                      SizedBox(height: SizeConfig.screenHeight! / 20),
                      CustemBottom(
                          lable: AppString.save.tr,
                          onTap: () {
                            if (descrptionController.text != "" &&
                                priceController.text != "" &&
                                titleController.text != "") {
                              context.read<AddPizzaCubit>().sendImageFirestore(
                                  decoration: descrptionController.text,
                                  price: priceController.text,
                                  title: titleController.text);
                            } else {
                              final snackBar = SnackBar(
                                duration: const Duration(milliseconds: 1500),
                                backgroundColor: ColorManger.error,
                                content: Row(
                                  children: [
                                    Icon(
                                      IconManager.error,
                                      color: ColorManger.white,
                                    ),
                                    SizedBox(
                                        width: SizeConfig.screenWidth! / 30),
                                    const Text('error'),
                                  ],
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }),
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
