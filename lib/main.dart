import 'dart:io';
import 'dart:async';

import 'package:dilaac/presentation/journeys/splash_screen.dart/splash_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/themes/theme_text.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common/constants/size_constants.dart';
import 'common/screenutil/screenutil.dart';
import 'core/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  Log.init(kReleaseMode);
  runApp(Phoenix(child: ProviderScope(child: MyApp())));
}

class MyApp extends HookWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var vm = useProvider(loaderVM);
    ScreenUtil.init();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      /* set Status bar color in Android devices. */
      statusBarColor: Colors.transparent,
      /* set Status bar icons color in Android devices.*/
      statusBarIconBrightness: Brightness.dark,
      /* set Status bar icon color in iOS. */
      statusBarBrightness:
          (Platform.isIOS ? Brightness.light : Brightness.dark),
      systemNavigationBarColor: AppColor.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Dilaac',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator.key,
      theme: ThemeData(
        unselectedWidgetColor: AppColor.unselectedGreyColor,
        primaryColor: AppColor.darkOrange,
        accentColor: AppColor.deepOrange,
        scaffoldBackgroundColor: AppColor.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeText.getTextTheme(),
        appBarTheme: const AppBarTheme(elevation: Sizes.dimen_0),
      ),
      builder: (context, child) {
        return Scaffold(
          // Global scaffold used to show SnackBars
          body: vm.isLoading
              ? Container(
                  child: Stack(
                    children: [
                      child!,
                      AbsorbPointer(
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: AppColor.black.withOpacity(0.65),
                          child: Center(
                              child: vm.percent == null
                                  ? Platform.isIOS
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              Sizes.dimen_8),
                                          child: Container(
                                            height: Sizes.dimen_8,
                                            width: context.screenWidth(0.25),
                                            child: LinearProgressIndicator(
                                              backgroundColor: Colors.white12,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                            ),
                                          ),
                                        )
                                      : SpinKitRipple(
                                          color: Colors.white,
                                          size: Sizes.dimen_40,
                                        )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        height: 9,
                                        width: context.screenWidth(0.55),
                                        child: LinearProgressIndicator(
                                          backgroundColor: Colors.white12,
                                          value: (vm.percent),
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        ),
                                      ),
                                    )),
                        ),
                      )
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    if (Platform.isIOS) hideKeyboard(context);
                  },
                  child: child,
                ),
        );
      },
      home: SplashScreen(),
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
