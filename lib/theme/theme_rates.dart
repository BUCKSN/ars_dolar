import 'package:flutter/material.dart';
import 'theme_constants.dart';

final kDarkTheme = ThemeData.dark().copyWith(
    // textTheme: TextTheme(
    //     headlineSmall: AppTextStyle.headers, bodySmall: AppTextStyle.textGrey),
    // textSelectionTheme: TextSelectionThemeData(
    //     cursorColor: AppColors.yellow, selectionColor: AppColors.grey),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: AppTextStyle.headers,
      //   focusColor: AppColors.yellow,
      //   contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      //   enabledBorder: AppOutlineInputBorderStyle.inactive,
      //   errorBorder: AppOutlineInputBorderStyle.inactive,
      //   focusedErrorBorder: AppOutlineInputBorderStyle.activeDark,
      //   focusedBorder: AppOutlineInputBorderStyle.activeDark,
    ),
    scaffoldBackgroundColor: AppColors.grey,
    colorScheme: const ColorScheme.light().copyWith(primary: AppColors.green),
    primaryColor: AppColors.green,
    appBarTheme: const AppBarTheme(
        surfaceTintColor: AppColors.transparent, //color of appbar then scroll
        elevation: 0.5,
        shadowColor: AppColors.lgrey,
        backgroundColor: AppColors.grey,
        // foregroundColor: AppColors.grey,
        iconTheme: IconThemeData(color: AppColors.green)));

final kLightTheme = ThemeData.light().copyWith(
    // textTheme: TextTheme(
    //     headlineSmall: AppTextStyle.headersBlack,
    //     bodySmall: AppTextStyle.textGrey),
    // textSelectionTheme: TextSelectionThemeData(
    //     cursorColor: AppColors.black, selectionColor: AppColors.grey),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: AppTextStyle.headersBlack,
      // focusColor: AppColors.green_one,
      // contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      // enabledBorder: AppOutlineInputBorderStyle.inactive,
      // errorBorder: AppOutlineInputBorderStyle.inactive,
      // focusedErrorBorder: AppOutlineInputBorderStyle.activeLight,
      // focusedBorder: AppOutlineInputBorderStyle.activeLight,
    ),
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light().copyWith(primary: AppColors.green),
    primaryColor: AppColors.green,
    appBarTheme: const AppBarTheme(
        surfaceTintColor: AppColors.transparent, //color of appbar then scroll
        elevation: 0.5,
        // если убрать цвет тени то будут артефакты при смене темы
        shadowColor: AppColors.lgrey,
        backgroundColor: AppColors.white,
        // foregroundColor: AppColors.grey,
        iconTheme: IconThemeData(color: AppColors.green)));
