import 'dart:ui';

import 'package:flutter/material.dart';

const kLinearGrad = LinearGradient(
  colors: [
    Color(0xFFC05810),
    Color(0xFFE19901),
    Color(0xFFFBC000),
  ],
  stops: [0.5, 0.9, 1],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const kHomeLinearGrad = LinearGradient(
  colors: [
    Color(0xFFC05810),
    Color(0xFFE19901),
    Color(0xFFFBC000),
  ],
  stops: [0.5, 0.9, 1],
  begin: Alignment.topCenter,
  end: Alignment.bottomLeft,
);

class AppColor {
  const AppColor._();

  static const Color black = Color(0xFF1D2121);
  static const Color lightOrange = Color(0xFFFBC000);
  static const Color deepOrange = Color(0xFFE19901);
  static const Color darkOrange = Color(0xFFC05810);
  static const Color deepDarkOrange = Color(0xFFBB5002);
  static const Color white = Color(0xFFFFFFFF);
  static const Color unselectedGreyColor = Color(0xFFA6AAB4);
  static const Color bgColor = Color(0xFFFBFBFB);
  static const Color textFormPlaceHolderColor = Color(0xFF959393);
  static const Color textFormBorderColor = Color(0xFFE1E1E1);
  static const Color greenLightColor = Color(0xFF2ED477);
  static const Color redLightColor = Color(0xFFF46363);
}
