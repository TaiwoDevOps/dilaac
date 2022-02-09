import 'dart:io';
import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/presentation/journeys/home_page/home_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/bank_list_widget.dart';
import 'package:dilaac/presentation/widgets/button.dart';
import 'package:dilaac/presentation/widgets/dialog_box_widget.dart';
import 'package:dilaac/presentation/widgets/dilaac.dart';
import 'package:dilaac/presentation/widgets/dilaac_input_dropdown.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:dilaac/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../common/extensions/size_extensions.dart';

class LanguageSettingScreen extends StatefulHookWidget {
  @override
  _LanguageSettingScreenState createState() => _LanguageSettingScreenState();
}

class _LanguageSettingScreenState extends State<LanguageSettingScreen> {
  var formKey = GlobalKey<FormState>();

  String? selectedBank;
  String? selectedBankBranch;
  String? selectedBankCode;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const YMargin(Sizes.dimen_140),
                Padding(
                  padding: const EdgeInsets.only(left: Sizes.dimen_16),
                  child: Text(
                    TranslationConstants.changeLanguage,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: Sizes.dimen_14,
                        color: AppColor.black),
                  ),
                ),
                const YMargin(Sizes.dimen_10),
                InputDropdown(
                  valueText: selectedBank,
                  hintText: 'Select Language',
                  valueStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w500),
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColor.textFormPlaceHolderColor,
                    size: Sizes.dimen_40,
                  ),
                ),
                const YMargin(Sizes.dimen_36),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
                    child: Button(
                      text: TranslationConstants.change,
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(Sizes.dimen_16)),
                              elevation: Sizes.dimen_16,
                              child: Container(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context, true),
                                      child: DialogBoxWidget(
                                        TranslationConstants.languageUpdate,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
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
                      XMargin(ScreenUtil.screenWidth! * 0.17),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          TranslationConstants.changeLanguage,
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
