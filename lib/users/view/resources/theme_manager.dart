import 'package:eatmore_app/users/view/resources/styles_manager.dart';
import 'package:eatmore_app/users/view/resources/values_manager.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main colors
    primaryColor: ColorManger.primary,
    primaryColorLight: ColorManger.lightPrimary,
    primaryColorDark: ColorManger.darkPrimary,
    disabledColor: ColorManger.grey1,
    splashColor: ColorManger.lightPrimary,
    // cardview theme
    cardTheme: CardTheme(
      color: ColorManger.white,
      shadowColor: ColorManger.grey,
      elevation: AppSize.s4,
    )
    //app bar theme
    ,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManger.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManger.lightPrimary,
      titleTextStyle: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManger.white,
      ),
    ),
    // buttom theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManger.grey1,
      buttonColor: ColorManger.primary,
      splashColor: ColorManger.lightPrimary,
    ),
    // elevated buttom theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManger.white,
          fontSize: FontSize.s17,
        ),
        primary: ColorManger.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    // text theme
    textTheme: TextTheme(
      displayLarge:
          getLightStyle(color: ColorManger.white, fontSize: FontSize.s22),
      headlineLarge:
          getSemiBoldStyle(color: ColorManger.darkGrey, fontSize: FontSize.s16),
      titleMedium:
          getMediumStyle(color: ColorManger.lightGrey, fontSize: FontSize.s14),
      bodyLarge: getRegularStyle(color: ColorManger.grey1),
      bodySmall: getRegularStyle(color: ColorManger.grey),
    ),
    // input decoration theme (text from field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle:
          getRegularStyle(color: ColorManger.grey, fontSize: FontSize.s14),
      labelStyle:
          getMediumStyle(color: ColorManger.grey, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManger.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.error,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManger.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
  );
}
