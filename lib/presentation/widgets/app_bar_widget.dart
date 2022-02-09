import 'dart:io';

import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/navigator.dart';
import '../journeys/home_page/home_screen.dart';

class DilaacAppBarWidget extends HookWidget with PreferredSizeWidget {
  final String title;
  final bool showMenu;
  final double barHeight = 40;
  final Function()? onTap;
  const DilaacAppBarWidget(
      {Key? key, this.title = "", required this.showMenu, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
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
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: Sizes.dimen_18,
                    color: AppColor.white),
              ),
            ),
            const XMargin(Sizes.dimen_40),
            Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + barHeight);
}
