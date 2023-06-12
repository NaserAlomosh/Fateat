import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../view_model/account/cubit.dart';
import '../../view_model/account/state.dart';
import '../home/home_view.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/size_confige.dart';
import '../resources/strings_manager.dart';
import '../widget/custem_buttom.dart';
import '../widget/custem_textfield_email.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Update',
        message:
            'This is an example error message that will be shown in the body of snackbar!',
        contentType: ContentType.success,
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => AccountCubit()..getData(),
            child: BlocConsumer<AccountCubit, AccountState>(
              listener: (context, state) {},
              builder: (context, state) {
                TextEditingController nameController = TextEditingController(
                    text: context.read<AccountCubit>().name);
                TextEditingController emailController = TextEditingController(
                    text: context.read<AccountCubit>().email);
                TextEditingController phoneController = TextEditingController(
                    text: context.read<AccountCubit>().phoneNumber);

                if (state is AccountLoadingState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: SizeConfig.defaultSize! * 40,
                      ),
                      Row(
                        children: [
                          SizedBox(width: SizeConfig.defaultSize! * 18),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: CustomPaint(
                              painter: InverseTrianglePainter(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: ColorManger.grey,
                              radius: 21,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: ColorManger.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              radius: 70,
                              child: Stack(
                                children: [
                                  context.read<AccountCubit>().selectImage
                                      ? CircleAvatar(
                                          radius: SizeConfig.defaultSize! * 7,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.file(
                                              File(
                                                context
                                                    .read<AccountCubit>()
                                                    .file!
                                                    .path,
                                              ),
                                            ),
                                          ),
                                        )
                                      : (context.read<AccountCubit>().image ==
                                              ""
                                          ? CircleAvatar(
                                              backgroundColor: ColorManger.grey,
                                              radius:
                                                  SizeConfig.defaultSize! * 7,
                                              child: Center(
                                                child: Text(
                                                  context
                                                      .read<AccountCubit>()
                                                      .firstCharName
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .defaultSize! *
                                                          8,
                                                      fontWeight:
                                                          FontWhightManager
                                                              .bold,
                                                      color: ColorManger.white),
                                                ),
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius:
                                                  SizeConfig.defaultSize! * 7,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image(
                                                    image: NetworkImage(context
                                                        .read<AccountCubit>()
                                                        .image
                                                        .toString())),
                                              ),
                                            )),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: ColorManger.primary,
                                      child: IconButton(
                                        onPressed: () {
                                          context
                                              .read<AccountCubit>()
                                              .getImagePicker();
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt_outlined,
                                          size: 21,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: ColorManger.grey,
                                      child: IconButton(
                                        onPressed: () {
                                          context
                                              .read<AccountCubit>()
                                              .removeImageFirestore();
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color: ColorManger.white,
                                          size: 21,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      AbsorbPointer(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 2, right: 80, left: 80),
                          child: TextFormField(
                            style: TextStyle(color: ColorManger.grey2),
                            controller: emailController,
                            cursorColor: ColorManger.primary,
                            decoration: InputDecoration(
                              hintText: AppString.email.tr,
                              labelStyle: TextStyle(
                                  color: ColorManger.grey,
                                  fontSize: FontSize.s14),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ColorManger.primary)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 80, right: 80),
                        child: CustemTextField(
                          darkModeColorText: ColorManger.white,
                          hintText: AppString.username.tr,
                          controller: nameController,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 80, right: 80),
                        child: CustemTextField(
                          textInputType: TextInputType.phone,
                          darkModeColorText: ColorManger.white,
                          hintText: AppString.phoneNumber.tr,
                          controller: phoneController,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(left: 80, right: 80),
                        child: CustemBottom(
                          lable: AppString.save.tr,
                          onTap: () {
                            if (nameController.text != "" &&
                                phoneController.text != "") {
                              context
                                  .read<AccountCubit>()
                                  .updateUserInformation(
                                    newName: nameController.text,
                                    newPhoneNumber: phoneController.text,
                                  );
                            }

                            if (context.read<AccountCubit>().saveUrlImage !=
                                null) {
                              context.read<AccountCubit>().sendImageFirestore();
                              context.read<AccountCubit>().getData();
                            }
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeView()),
                                (Route<dynamic> route) => false);
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 80, right: 80),
                        child: CustemBottom(
                          lable: AppString.cancel.tr,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          color: ColorManger.grey,
                        ),
                      ),
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
}

class InverseTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorManger.primary
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2.2, size.height / 1.1)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
