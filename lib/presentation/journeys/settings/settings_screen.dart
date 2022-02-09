import 'dart:io';
import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/presentation/journeys/home_page/home_screen.dart';
import 'package:dilaac/presentation/journeys/settings/settings_screens/change_language_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/bank_list_widget.dart';
import 'package:dilaac/presentation/widgets/button.dart';
import 'package:dilaac/presentation/widgets/dilaac.dart';
import 'package:dilaac/presentation/widgets/dilaac_input_dropdown.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:dilaac/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../common/extensions/size_extensions.dart';

class SettingsSreen extends StatefulHookWidget {
  @override
  _SettingsSreenState createState() => _SettingsSreenState();
}

class _SettingsSreenState extends State<SettingsSreen> {
  var formKey = GlobalKey<FormState>();

  String? selectedBank;
  String? selectedBankBranch;
  String? selectedBankCode;

  final _title = [
    TranslationConstants.editProfile,
    TranslationConstants.setPin,
    // TranslationConstants.addBank,
    // TranslationConstants.uploadKyc,
    TranslationConstants.changeLanguage,
  ];

  _onTap(int index) {
    if (index == 4) {
      navigator.context!.navigateReplace(LanguageSettingScreen());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Stack(
        children: [
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.9,
            child: Column(
              children: [
                const YMargin(Sizes.dimen_100),
                Expanded(
                  child: ListView.builder(
                      itemCount: _title.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: Sizes.dimen_10),
                          child: ListTile(
                            onTap: () {
                              _onTap(index);
                            },
                            title: Text(
                              _title[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Sizes.dimen_14,
                                      color: AppColor.black),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.12,
              child: Container(
                decoration: BoxDecoration(
                  gradient: kHomeLinearGrad,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Sizes.dimen_30),
                    bottomRight: Radius.circular(Sizes.dimen_30),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: Sizes.dimen_4),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Builder(
                            builder: (context) => IconButton(
                                icon: Icon(
                                  Platform.isAndroid
                                      ? Icons.arrow_back
                                      : Icons.arrow_back_ios,
                                  color: AppColor.white,
                                  size: Sizes.dimen_32,
                                ),
                                padding: const EdgeInsets.all(0),
                                alignment: Alignment.centerLeft,
                                onPressed: () => navigator.context!
                                    .navigateReplace(DashBoardScreen())),
                          ),
                        ),
                      ),
                      XMargin(ScreenUtil.screenWidth! * 0.3),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          TranslationConstants.settings,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: Sizes.dimen_18,
                                  color: AppColor.white),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
