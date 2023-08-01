import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const jPrimaryColor = Color(0xFF8669A6);
  static const jSecondaryColor = Color(0xFFAD98C5);
  static const jAccentColor = Color(0xFF001BFF);
  static const jCardBgColor = Color(0xffffdcbd);

  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;
  static const completed = Color.fromARGB(255, 28, 88, 30);
  static const notCompleted = Color.fromARGB(255, 210, 32, 19);
  static const textLightColor = Colors.white70;
  static const textDarkColor = Colors.black87;

  static const darkBackground = Color.fromRGBO(0, 39, 71, 1);
  static const darkBackgroundContainer = Color.fromRGBO(0, 59, 109, 1);
  static const lightBackground = Color(0xFFFFE95D);
  static const lightBackgroundontainer = Color(0xFFFFF3A3);
  static const greyBackground = Color(0xFF444654);

  static const tGoogleBgColor = Color(0xFFD0DEEE);
  static const tGoogleForegroundColor = Color(0xFF5886BD);
  static const tFacebookBgColor = Color(0xFF0C68E0);

  static const colors = [
    Colors.red,
    Colors.white,
    Colors.yellow,
    Colors.green,
    Color(0xFFABB2BF),
  ];

  static const red = Colors.red;
  static const light = Colors.white;
  static const yellow = Colors.yellow;
  static const green = Colors.green;
  static const grey = Color(0xFFABB2BF);

  static Color randomColor() {
    final random = Random();
    int randomIndex = random.nextInt(AppColors.colors.length);
    return AppColors.colors[randomIndex];
  }
}
