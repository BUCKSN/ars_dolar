import 'package:flutter/material.dart';

abstract class AppColors {
  // static const Color yellow = Color.fromRGBO(255, 221, 0, 1);
  // static const Color lyellow = Color.fromRGBO(208, 201, 157, 1);
  static const Color grey = Color.fromRGBO(99, 101, 106, 1);
  static const Color lgrey = Color.fromRGBO(201, 202, 204, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color green_old = Color.fromRGBO(58, 140, 110, 1);
  static const Color blue = Color.fromRGBO(106, 169, 205, 1);
  static const Color green = Color.fromRGBO(54, 136, 57, 1);
  static const Color transparent = Colors.transparent;
}

// abstract class AppButtonStyle {
//   static final ButtonStyle linkButton = ButtonStyle(
//     foregroundColor: MaterialStateProperty.all(AppColors.yellow),
//     textStyle: MaterialStateProperty.all(
//       const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//     ),
//   );
// }

abstract class AppTextStyle {
  static const TextStyle dolarBlueBuy = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.blue,
  );
  static const TextStyle dolarBlueSell = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.blue,
  );
  static const TextStyle dolarOficialBuy = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.green,
  );
  static const TextStyle dolarOficialSell = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.green,
  );
  static const TextStyle dolarOtherBuy = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static const TextStyle dolarOtherSell = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.black,
  );
  static const TextStyle headers = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static const TextStyle headersGrey = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.grey,
  );
  static const TextStyle headersBlack = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static const TextStyle text = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
  static const TextStyle textGrey = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
  static const TextStyle helper = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
}

abstract class AppOutlineInputBorderStyle {
  static OutlineInputBorder activeDark = OutlineInputBorder(
      borderRadius: BorderRadius.circular(999),
      borderSide: AppBorderSide.activeDark);
  static OutlineInputBorder activeLight = OutlineInputBorder(
      borderRadius: BorderRadius.circular(999),
      borderSide: AppBorderSide.activeLight);
  static OutlineInputBorder inactive = OutlineInputBorder(
      borderRadius: BorderRadius.circular(999),
      borderSide: AppBorderSide.inactive);
}

abstract class AppBorderSide {
  static BorderSide activeDark = const BorderSide(
      style: BorderStyle.solid, color: AppColors.green, width: 3.0);
  static BorderSide activeLight = const BorderSide(
      style: BorderStyle.solid, color: AppColors.black, width: 3.0);
  static BorderSide inactive = const BorderSide(
      style: BorderStyle.solid, color: AppColors.grey, width: 3.0);
}
