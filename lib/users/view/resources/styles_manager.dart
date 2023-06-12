import 'package:flutter/material.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontwight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontConstants.fontFamily,
    fontWeight: fontwight,
    color: color,
  );
}

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontWhightManager.regular,
    color,
  );
}

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontWhightManager.medium,
    color,
  );
}

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontWhightManager.light,
    color,
  );
}

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontWhightManager.bold,
    color,
  );
}

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontWhightManager.semiBold,
    color,
  );
}
