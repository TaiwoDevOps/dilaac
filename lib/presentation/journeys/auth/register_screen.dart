import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/core/providers.dart';
import 'package:dilaac/models/constants_model.dart';
import 'package:dilaac/presentation/journeys/auth/login_screen.dart';
import 'package:dilaac/presentation/journeys/auth/otp_verification_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/button.dart';
import 'package:dilaac/presentation/widgets/dilaac.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/validator.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class RegistrationScreen extends StatefulHookWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var formKey = GlobalKey<FormState>();
  bool checkValue = false;
  String? selectedCountry,
      selectedCountryImg,
      selectedCountryPhoneCode,
      selectedCountryCode,
      selectedLanguage;

  @override
  void initState() {
    context.read(authVM).init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(authVM);
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
                    TranslationConstants.createNewAccount,
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
            child: Form(
              key: formKey,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DilaacTextField(
                          labelTitle: "First Name",
                          labelText: 'Enter first Name',
                          controller: provider.firstNameTEC,
                          margin: 30,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else if (value.isEmpty) {
                              return "First Name should not be blank";
                            } else {
                              return "Please enter a Name";
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: DilaacTextField(
                          labelTitle: "Last Name",
                          labelText: 'Enter Last Name',
                          controller: provider.lastNameTEC,
                          margin: 30,
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else if (value.isEmpty) {
                              return "Last Name should not be blank";
                            } else {
                              return "Please enter a last name";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const YMargin(Sizes.dimen_20),
                  DilaacTextField(
                    labelTitle: "What Is your registered business name",
                    labelText: 'Enter business name',
                    controller: provider.businessNameTEC,
                    margin: 30,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else if (value.isEmpty) {
                        return "Enter business name should not be blank";
                      } else {
                        return "Please enter a Name";
                      }
                    },
                  ),
                  const YMargin(Sizes.dimen_20),
                  DilaacTextField(
                    labelTitle: "Email Address",
                    isEmail: true,
                    controller: provider.emailTEC,
                    labelText: 'Email Address ',
                    margin: 30,
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
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: DropdownButtonHideUnderline(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: Sizes.dimen_28),
                                child: Text(
                                  "Country",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.2,
                                          height: 2),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: Sizes.dimen_30),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Sizes.dimen_10),
                                  color: Colors.white,
                                ),
                                child: DropdownButtonFormField<String>(
                                  icon: SizedBox.shrink(),
                                  decoration: InputDecoration(
                                    prefixIcon: SizedBox(
                                      width: Sizes.dimen_22,
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Sizes.dimen_100),
                                            child: Image.asset(
                                              selectedCountryImg ??
                                                  ImageConstant.logo,
                                              scale: Sizes.dimen_10,
                                              height: Sizes.dimen_20,
                                              width: Sizes.dimen_20,
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: AppColor.black,
                                            size: Sizes.dimen_22,
                                          ),
                                        ],
                                      ),
                                    ),
                                    fillColor: Colors.white,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.textFormBorderColor),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.textFormBorderColor),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.textFormBorderColor),
                                    ),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  hint: Text(
                                    "Country",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                            color: AppColor
                                                .textFormPlaceHolderColor,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  value: selectedCountry,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCountry = newValue;
                                    });
                                  },
                                  items: countryListTest.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value['id'],
                                      onTap: () {
                                        setState(() {
                                          selectedCountryCode = value['code'];
                                          selectedCountryPhoneCode =
                                              value['phoneCode'];
                                          selectedCountryImg = value['flag'];
                                          provider.countryTEC.text =
                                              value['name'];
                                          provider.countryCodeTEC.text =
                                              value['code'];
                                        });
                                        Log().debug(
                                            "The country code  :::::${value['phoneCode']} ::::: ${value['flag']} ");
                                      },
                                      child: Text(
                                        value['name'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                                color: AppColor.black,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                      Expanded(
                        child: DilaacTextField(
                          labelTitle: "Mobile number",
                          labelText: 'Phone number',
                          controller: provider.phoneNumberTEC,
                          isPhone: true,
                          // prefixWidget: Padding(
                          //   padding: const EdgeInsets.only(top: Sizes.dimen_14),
                          //   child: Text(
                          //     "${selectedCountryPhoneCode == null ? '' : '+'} ${selectedCountryPhoneCode ?? ''}",
                          //     textAlign: TextAlign.start,
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .subtitle1
                          //         ?.copyWith(
                          //             fontSize: Sizes.dimen_14,
                          //             color: AppColor.black,
                          //             fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          margin: 30,
                          validator: (value) {
                            if (value!.isNotEmpty &&
                                Validator.longerThanEight(value)) {
                              return null;
                            } else if (value.isEmpty) {
                              return "Phone number should not be blank";
                            } else {
                              return "Please enter a Phone number";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const YMargin(Sizes.dimen_20),
                  DilaacTextField(
                    labelTitle: "Password",
                    isPassword: true,
                    labelText: 'Password',
                    controller: provider.passwordTEC,
                    margin: 30,
                    validator: (v) {
                      if (v!.isNotEmpty) {
                        if (!Validator.longerThanEight(v))
                          return "Password must be at least 8 characters long";
                        else
                          return null;
                      } else {
                        return 'Password should not be blank';
                      }
                    },
                  ),
                  const YMargin(Sizes.dimen_20),
                  const YMargin(Sizes.dimen_20),
                  DilaacTextField(
                    labelTitle: "Project Name",
                    labelText: 'Enter project name',
                    controller: provider.projectNameTEC,
                    margin: 30,
                    validator: (v) {
                      if (v!.isNotEmpty) {
                        return null;
                      } else if (v.isEmpty) {
                        return "Enter project name should not be blank";
                      } else {
                        return "Please enter a project name";
                      }
                    },
                  ),
                  const YMargin(Sizes.dimen_20),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: Sizes.dimen_30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.dimen_10),
                          color: Colors.white,
                        ),
                        child: DropdownButtonFormField<String>(
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColor.black,
                            size: Sizes.dimen_22,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.textFormBorderColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.textFormBorderColor),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.textFormBorderColor),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          hint: Text(
                            "Language",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                    color: AppColor.textFormPlaceHolderColor,
                                    fontWeight: FontWeight.w500),
                          ),
                          value: selectedLanguage,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLanguage = newValue;
                            });
                          },
                          items: languageList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value['id'],
                              onTap: () {
                                setState(() {
                                  selectedLanguage = value['name'];
                                });
                              },
                              child: Text(
                                value['name'],
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w500),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const YMargin(Sizes.dimen_64),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: Sizes.dimen_20),
                    child: Button(
                      text: TranslationConstants.signUp,
                      onPressed: () {
                        if (formKey.currentState!.validate())
                          provider.register();
                      },
                    ),
                  ),
                  const YMargin(Sizes.dimen_20),
                  InkWell(
                    onTap: () {
                      context.navigateReplace(LoginPage());
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: TranslationConstants.alreadyHaveAnAccount,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w400, color: AppColor.black),
                        children: [
                          TextSpan(
                            text: TranslationConstants.login,
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
                  const YMargin(Sizes.dimen_40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
