import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

class CustemBottom extends StatelessWidget {
  final String lable;
  final Function() onTap;

  final Color color;

  final double fontSize;
  const CustemBottom({
    Key? key,
    required this.lable,
    required this.onTap,
    this.color = ColorManger.primary,
    this.fontSize = FontSize.s17,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: color),
        child: Center(
            child: Text(
          lable,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: ColorManger.white),
        )),
      ),
    );
  }
}
