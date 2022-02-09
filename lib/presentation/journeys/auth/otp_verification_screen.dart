import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/core/providers.dart';
import 'package:dilaac/presentation/journeys/auth/login_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/button.dart';
import 'package:dilaac/utils/log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_mail_app/open_mail_app.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulHookWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with AfterLayoutMixin<OtpVerificationScreen> {
  bool hasError = false, activateOtp = false;
  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    var result = await OpenMailApp.openMailApp(
      nativePickerTitle: TranslationConstants.selectEmailApp,
    );
    if (result.canOpen) {
      showDialog(
        context: context,
        builder: (_) {
          return MailAppPickerDialog(
            title: "Open mail to continue",
            mailApps: result.options,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var email = useProvider(verifyEmailOtpVM.select((v) => v.emailTEC.text));
    var provider = useProvider(verifyEmailOtpVM);

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: Sizes.dimen_16),
            child: Stack(
              children: [
                Image.asset(
                  ImageConstant.bgPng,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil.screenHeight! * 0.1,
                      left: Sizes.dimen_16),
                  child: Text(
                    TranslationConstants.verifyAccount,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.w900,
                          fontSize: Sizes.dimen_24,
                          letterSpacing: Sizes.dimen_1,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SvgAssetConstant.phoneSVG,
                const YMargin(Sizes.dimen_16),
                Text(
                  "${TranslationConstants.phoneVerification}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColor.black,
                      fontSize: Sizes.dimen_18),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Sizes.dimen_8, horizontal: Sizes.dimen_30),
                  child: Text(
                    "${TranslationConstants.phoneVerificationDesc} ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                        fontSize: Sizes.dimen_12),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil.screenWidth! * 0.2),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        fieldHeight: Sizes.dimen_50,
                        fieldWidth: Sizes.dimen_40,
                        fieldOuterPadding: const EdgeInsets.all(0),
                        activeColor: Colors.grey.shade300,
                        inactiveFillColor: Colors.transparent,
                        activeFillColor:
                            hasError ? Colors.black87 : Colors.transparent,
                        inactiveColor: Colors.black,
                        selectedColor: Colors.black,
                        selectedFillColor: Colors.transparent,
                        disabledColor: Colors.grey),
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.text,
                    onCompleted: (v) {
                      setState(() => activateOtp = true);
                    },
                    onChanged: (value) {
                      setState(() => activateOtp = false);
                    },
                  ),
                ),
                const YMargin(Sizes.dimen_32),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.dimen_20),
                    child: Button(
                      text: TranslationConstants.verify,
                      onPressed: () {
                        if (activateOtp)
                          provider
                              .verifyEmailOtpMethod(textEditingController.text);
                      },
                    ),
                  ),
                ),
                const YMargin(Sizes.dimen_18),
                Center(
                  child: InkWell(
                    onTap: () {
                      provider.resendEmailOtpMethod();
                    },
                    child: RichText(
                      text: TextSpan(
                        text: TranslationConstants.noCode,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: Sizes.dimen_14,
                            color: AppColor.black),
                        children: [
                          TextSpan(
                            text: TranslationConstants.resendCode,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.deepDarkOrange),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
