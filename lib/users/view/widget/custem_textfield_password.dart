// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/theme/cubit.dart';
import '../resources/color_manager.dart';

class CustemTextFieldPassword extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustemTextFieldPassword(
      {Key? key, required this.hintText, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: TextFormField(
        style: TextStyle(color: ColorManger.black),
        controller: controller,
        obscureText: true,
        cursorColor: ColorManger.primary,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock_outline,
            color: theme.isDark ? ColorManger.black : ColorManger.black,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: ColorManger.black),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 3, color: ColorManger.grey.withOpacity(0.5))),
          labelStyle: TextStyle(color: ColorManger.grey, fontSize: 15),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManger.primary)),
        ),
      ),
    );
  }
}
