import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/presentation/journeys/payout_screen/payout_screen.dart';
import 'package:dilaac/presentation/journeys/settings/settings_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DrawerScreen extends StatefulHookWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final _title = [
    TranslationConstants.home,
    TranslationConstants.payout,
    TranslationConstants.profile,
  ];

  final _icons = [
    SvgAssetConstant.homeSVG,
    SvgAssetConstant.sendSVG,
    SvgAssetConstant.userSVG,
  ];

  _onTap(int index) {
    if (index == 0) {
      navigator.popView();
    } else if (index == 1) {
      navigator.context!.navigateReplace(PayoutScreen());
    } else {
      navigator.context!.navigateReplace(SettingsSreen());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    top: ScreenUtil.screenHeight! * 0.1, left: Sizes.dimen_16),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Sizes.dimen_40),
                  ),
                  child: Container(
                    height: Sizes.dimen_90,
                    width: Sizes.dimen_90,
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.dimen_12),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.dimen_40),
                      ),
                    ),
                    child: Image.asset(
                      ImageConstant.bgPng,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const YMargin(Sizes.dimen_40),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _onTap(index);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        bottom: Sizes.dimen_4, top: Sizes.dimen_6),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColor.textFormPlaceHolderColor
                              .withOpacity(0.5),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: Sizes.dimen_14),
                      child: Row(
                        children: [
                          const XMargin(Sizes.dimen_16),
                          _icons[index],
                          const XMargin(Sizes.dimen_16),
                          Text(
                            _title[index],
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: Sizes.dimen_14,
                                    color: AppColor.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: _icons.length),
        )
      ],
    );
  }
}
