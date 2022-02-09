import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/app_bar_widget.dart';
import 'package:dilaac/presentation/widgets/bottom_sheet.dart';
import 'package:dilaac/presentation/widgets/button.dart';
import 'package:dilaac/utils/list_item.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TransactionHistoryScreen extends StatefulHookWidget {
  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen>
    with AfterLayoutMixin<TransactionHistoryScreen> {
  final List<ListItem<String>> _title = [
    ListItem("All time"),
    ListItem("7 Days"),
    ListItem("14 Days"),
    ListItem("28 Days"),
    ListItem("1 Month"),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.9,
              child: Column(
                children: [
                  const YMargin(Sizes.dimen_40),
                  Container(
                      height: Sizes.dimen_40,
                      margin: const EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_16),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xFFFF9933), width: Sizes.dimen_2),
                          borderRadius: BorderRadius.circular(Sizes.dimen_8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              height: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: kHomeLinearGrad,
                                borderRadius:
                                    BorderRadius.circular(Sizes.dimen_6),
                              ),
                              child: Text(
                                TranslationConstants.all,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        fontSize: Sizes.dimen_18,
                                        color: AppColor.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                TranslationConstants.inflow,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        fontSize: Sizes.dimen_18,
                                        color:
                                            AppColor.textFormPlaceHolderColor),
                              ),
                            ),
                          ),
                          Container(
                            color: Color(0xFFFD8D3C),
                            height: Sizes.dimen_60,
                            width: Sizes.dimen_1,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                TranslationConstants.payout,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        fontSize: Sizes.dimen_18,
                                        color:
                                            AppColor.textFormPlaceHolderColor),
                              ),
                            ),
                          ),
                        ],
                      )),
                  const YMargin(Sizes.dimen_18),
                  //
                  Padding(
                    padding: const EdgeInsets.only(left: Sizes.dimen_16),
                    child: SizedBox(
                      height: Sizes.dimen_32,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _title[index].selected =
                                    !_title[index].selected;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: _title[index].selected
                                      ? AppColor.deepDarkOrange
                                      : null,
                                  border: Border.all(
                                      color: _title[index].selected
                                          ? AppColor.deepDarkOrange
                                          : AppColor.textFormBorderColor),
                                  borderRadius:
                                      BorderRadius.circular(Sizes.dimen_24)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.dimen_12),
                                child: Text(
                                  _title[index].data,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: Sizes.dimen_12,
                                          color: _title[index].selected
                                              ? AppColor.white
                                              : AppColor
                                                  .textFormPlaceHolderColor),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: _title.length,
                        separatorBuilder: (context, index) => Container(
                          width: Sizes.dimen_8,
                        ),
                      ),
                    ),
                  ),
                  //Transaction histories
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_16),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            onTap: () {
                              Log().debug("The inex tapped", index);
                            },
                            leading: Container(
                              padding: const EdgeInsets.all(Sizes.dimen_12),
                              width: Sizes.dimen_60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? AppColor.greenLightColor
                                          .withOpacity(0.2)
                                      : AppColor.redLightColor.withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.circular(Sizes.dimen_16)),
                              child: index % 2 == 0
                                  ? SvgAssetConstant.downArrowSVG
                                  : SvgAssetConstant.upArrowSVG,
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cash withdrawals ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.black,
                                          fontSize: Sizes.dimen_14),
                                ),
                                Text(
                                  "10:30 16 Jun",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF444444),
                                          fontSize: Sizes.dimen_12),
                                ),
                              ],
                            ),
                            trailing: Text(
                              "N50,0000",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF1D2121),
                                      fontSize: Sizes.dimen_18),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Container(height: Sizes.dimen_16),
                        itemCount: 24,
                      ),
                    ),
                  ),
                ],
              )),
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
                                onPressed: () => navigator.popView()),
                          ),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          TranslationConstants.transHistory,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: Sizes.dimen_18,
                                  color: AppColor.white),
                        ),
                      ),
                      const XMargin(Sizes.dimen_12),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: AppColor.white,
                          size: Sizes.dimen_32,
                        ),
                      ),
                      const XMargin(Sizes.dimen_12),
                      Padding(
                        padding: const EdgeInsets.only(right: Sizes.dimen_4),
                        child: Builder(
                          builder: (context) => IconButton(
                              icon:
                                  SvgAssetConstant.rightMenuSVG(AppColor.white),
                              padding: const EdgeInsets.all(0),
                              alignment: Alignment.centerLeft,
                              onPressed: () {
                                //show bottom sheet
                                showBottomSheet();
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  showBottomSheet() {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (context) => FilterBottomSheetWidget(),
    );
  }
}
