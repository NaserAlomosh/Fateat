import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/theme/cubit.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

class CustemTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  final Icon? icon;

  final Color? darkModeColorText;

  final TextInputType textInputType;

  final TextAlign textAlign;

  final int maxLines;
  const CustemTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.darkModeColorText = Colors.black,
    this.textInputType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: TextFormField(
        maxLines: maxLines,
        textAlign: textAlign,
        keyboardType: textInputType,
        style: TextStyle(
            color: theme.isDark ? darkModeColorText : ColorManger.black),
        controller: controller,
        cursorColor: ColorManger.primary,
        decoration: InputDecoration(
          prefixIcon: icon,
          prefixIconColor: ColorManger.black,
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: ColorManger.grey.withOpacity(0.5)),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              color: theme.isDark ? ColorManger.grey : ColorManger.black),
          labelStyle:
              TextStyle(color: ColorManger.grey, fontSize: FontSize.s14),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManger.primary)),
        ),
      ),
    );
  }
}
