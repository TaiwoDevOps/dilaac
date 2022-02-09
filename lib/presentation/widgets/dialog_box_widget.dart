import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:flutter/material.dart';
import '../../../../common/extensions/size_extensions.dart';

class DialogBoxWidget extends StatelessWidget {
  final String title;
  const DialogBoxWidget(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Sizes.dimen_20, vertical: Sizes.dimen_20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const YMargin(Sizes.dimen_64),
          Center(child: SvgAssetConstant.checkBigSVG),
          const YMargin(Sizes.dimen_20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_20),
            child: Center(
                child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontSize: Sizes.dimen_20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black),
            )),
          ),
          const YMargin(Sizes.dimen_64),
        ],
      ),
    );
  }
}
