import 'package:dilaac/common/constants/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/extensions/size_extensions.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _openSansTextTheme => GoogleFonts.openSansTextTheme();

  static TextStyle get _whiteHeadline6 =>
      _openSansTextTheme.headline6!.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteHeadline5 =>
      _openSansTextTheme.headline5!.copyWith(
        fontSize: Sizes.dimen_30.sp,
        color: Colors.white,
      );

  static TextStyle get _textSubtitle1 => _openSansTextTheme.subtitle1!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        letterSpacing: 0.5,
        color: Colors.white,
      );

  static TextStyle get _textButton => _openSansTextTheme.button!.copyWith(
        fontSize: Sizes.dimen_18.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  static TextStyle get _textBodyText1 => _openSansTextTheme.bodyText1!.copyWith(
        color: Colors.white,
        fontSize: Sizes.dimen_12.sp,
        height: 1.5,
      );

  static getTextTheme() => TextTheme(
        headline5: _whiteHeadline5,
        headline6: _whiteHeadline6,
        subtitle1: _textSubtitle1,
        bodyText1: _textBodyText1,
        button: _textButton,
      );
}
