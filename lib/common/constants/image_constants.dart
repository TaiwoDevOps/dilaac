import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageConstant {
  ImageConstant._();

  //**************PNG ****************************** */
  static const String logo = 'assets/logo.png';
  static const String bgPng = 'assets/images/Bg.png';
  static const String paperPng = 'assets/images/paper.png';
  static const String chainPng = 'assets/images/chain.png';
  static const String smartPhonePng = 'assets/images/smartphone.png';
  static const String bankPng = 'assets/images/bank.png';
  static const String ngPng = 'assets/images/ng.png';
  static const String ukPng = 'assets/images/gb.png';
  static const String ciPng = 'assets/images/ci.png';
  static const String snPng = 'assets/images/sn.png';

  //**************SVG ****************************** */
  static const String bgSVG = 'assets/svgs/Bg.svg';
  static const String phoneSVG = 'assets/svgs/phone.svg';
  static const String menuSVG = 'assets/svgs/menu.svg';
  static const String chainSVG = 'assets/svgs/chain.svg';
  static const String copySVG = 'assets/svgs/copy.svg';
  static const String homeSVG = 'assets/svgs/home.svg';
  static const String sendSVG = 'assets/svgs/send.svg';
  static const String userSVG = 'assets/svgs/user.svg';
  static const String upArrowSVG = 'assets/svgs/up-arrow.svg';
  static const String downArrowSVG = 'assets/svgs/down-arrow.svg';
  static const String rightMenuSVG = 'assets/svgs/right-menu.svg';
  static const String closeIconSVG = 'assets/svgs/close-icon.svg';
  static const String walletSVG = 'assets/svgs/wallet.svg';
  static const String blackChainSVG = 'assets/svgs/black-chain.svg';
  static const String checkBigSVG = 'assets/svgs/check-big.svg';
}

class SvgAssetConstant {
  SvgAssetConstant._();

  static Widget bgSvg = SvgPicture.asset(
    ImageConstant.bgSVG,
    semanticsLabel: 'Bg Template',
  );

  static Widget phoneSVG = SvgPicture.asset(
    ImageConstant.phoneSVG,
    semanticsLabel: 'Phone',
  );

  static Widget menuSVG = SvgPicture.asset(
    ImageConstant.menuSVG,
    semanticsLabel: 'Menu',
  );

  static Widget chainSVG = SvgPicture.asset(
    ImageConstant.chainSVG,
    semanticsLabel: 'chain',
  );

  static Widget copySVG = SvgPicture.asset(
    ImageConstant.copySVG,
    semanticsLabel: 'copy',
  );

  static Widget sendSVG = SvgPicture.asset(
    ImageConstant.sendSVG,
    semanticsLabel: 'send',
  );

  static Widget userSVG = SvgPicture.asset(
    ImageConstant.userSVG,
    semanticsLabel: 'user',
  );

  static Widget homeSVG = SvgPicture.asset(
    ImageConstant.homeSVG,
    semanticsLabel: 'home',
  );
  static Widget downArrowSVG = SvgPicture.asset(
    ImageConstant.downArrowSVG,
    semanticsLabel: 'downArrow',
  );
  static Widget upArrowSVG = SvgPicture.asset(
    ImageConstant.upArrowSVG,
    semanticsLabel: 'upArrow',
  );

  static Widget rightMenuSVG(Color color) => SvgPicture.asset(
        ImageConstant.rightMenuSVG,
        color: color,
        semanticsLabel: 'Right Menu',
      );

  static Widget closeIconSVG = SvgPicture.asset(
    ImageConstant.closeIconSVG,
    semanticsLabel: 'Close Icon',
  );

  static Widget blackChainSVG = SvgPicture.asset(
    ImageConstant.blackChainSVG,
    semanticsLabel: 'Black Chain Icon',
  );

  static Widget walletSVG = SvgPicture.asset(
    ImageConstant.walletSVG,
    semanticsLabel: 'Wallet Icon',
  );

  static Widget checkBigSVG = SvgPicture.asset(
    ImageConstant.checkBigSVG,
    semanticsLabel: 'Check Big Icon',
  );
}
