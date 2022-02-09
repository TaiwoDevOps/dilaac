import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/core/providers.dart';
import 'package:dilaac/presentation/journeys/auth/register_screen.dart';
import 'package:dilaac/presentation/journeys/home_page/home_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/button.dart';
import 'package:dilaac/presentation/widgets/dilaac.dart';
import 'package:dilaac/presentation/widgets/touchable_opacity.dart';
import 'package:dilaac/utils/greet.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dilaac/utils/navigator.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends StatefulHookWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    context.read(authVM)
      ..emailTEC.clear()
      ..passwordTEC.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    TranslationConstants.welcomeBack,
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
          Expanded(child: BuildForm()),
        ],
      ),
    );
  }
}

class BuildForm extends HookWidget {
  final _formKey = GlobalKey<FormState>();
  var provider = useProvider(authVM);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          DilaacTextField(
            labelTitle: "Email Address",
            isEmail: true,
            labelText: 'Email Address',
            controller: provider.emailTEC,
            margin: Sizes.dimen_20,
            validator: (value) {
              if (value!.isNotEmpty && Validator.isEmail(value)) {
                return null;
              } else if (value.isEmpty) {
                return "Email should not be blank";
              } else {
                return "Please enter a valid email address";
              }
            },
          ),
          const YMargin(Sizes.dimen_20),
          DilaacTextField(
            labelTitle: "Password",
            isPassword: true,
            labelText: 'Password',
            controller: provider.passwordTEC,
            margin: Sizes.dimen_20,
            validator: (value) {
              if (value!.isNotEmpty && !Validator.longerThanEight(value)) {
                return null;
              } else if (value.isEmpty) {
                return "Password should not be blank";
              }
            },
          ),
          const YMargin(Sizes.dimen_60),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_20),
              child: Button(
                text: "Login",
                onPressed: () {
                  if (_formKey.currentState!.validate()) provider.login();
                },
              ),
            ),
          ),
          const YMargin(Sizes.dimen_18),
          Center(
            child: InkWell(
              onTap: () {
                context.navigateReplace(RegistrationScreen());
              },
              child: RichText(
                text: TextSpan(
                  text: TranslationConstants.dontHaveAnAccount,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Sizes.dimen_14,
                      color: AppColor.black),
                  children: [
                    TextSpan(
                      text: TranslationConstants.signUp,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
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
    );
  }
}
