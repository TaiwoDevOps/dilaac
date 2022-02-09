import 'dart:async';

import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/network_layer/network/authenticated_http_client.dart';
import 'package:dilaac/presentation/journeys/auth/login_screen.dart';
import 'package:dilaac/presentation/journeys/auth/register_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/utils/local_storage.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Animation<double> fadeAnimation;
  late AnimationController animationController;
  var _userObjectModel;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);

    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();

    new Timer(new Duration(milliseconds: 3000), () {
      autoAuthenticate();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Center(child: Image.asset(ImageConstant.logo)),
    );
  }

  void autoAuthenticate() async {
    var val = await LocalStorage.keyExists(key: SharedPrefKeys.LOGIN_MODEL);
    if (val) {
      context.navigateReplace(LoginPage());
    } else {
      context.navigateReplace(RegistrationScreen());
    }
  }
}
