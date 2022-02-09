import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/button.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/material.dart';
import '../../common/extensions/size_extensions.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  const FilterBottomSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  _FilterBottomSheetWidgetState createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.screenHeight! / 2.5,
      padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const YMargin(Sizes.dimen_32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TranslationConstants.filter,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: Sizes.dimen_18,
                    color: AppColor.black),
              ),
              Row(
                children: [
                  Text(
                    TranslationConstants.clearFilter,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: Sizes.dimen_14,
                        color: Color(0xFFF46363)),
                  ),
                  const XMargin(Sizes.dimen_24),
                  GestureDetector(
                      onTap: () => navigator.popView(),
                      child: SvgAssetConstant.closeIconSVG),
                ],
              ),
            ],
          ),
          const YMargin(Sizes.dimen_40),
          GestureDetector(
            onTap: () => navigator.popView(),
            child: Text(
              TranslationConstants.date,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: Sizes.dimen_14,
                  color: AppColor.black),
            ),
          ),
          const YMargin(Sizes.dimen_30),
          GestureDetector(
            onTap: () => navigator.popView(),
            child: Text(
              TranslationConstants.amount,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: Sizes.dimen_14,
                  color: AppColor.black),
            ),
          ),
          const YMargin(Sizes.dimen_30),
          GestureDetector(
            onTap: () => navigator.popView(),
            child: Text(
              TranslationConstants.description,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: Sizes.dimen_14,
                  color: AppColor.black),
            ),
          ),
        ],
      ),
    );
  }
}
