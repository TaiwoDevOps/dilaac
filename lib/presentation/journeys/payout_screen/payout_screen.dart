import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/presentation/journeys/home_page/home_screen.dart';
import 'package:dilaac/presentation/journeys/transaction_history_screen/transaction_history_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/app_bar_widget.dart';
import 'package:dilaac/presentation/widgets/bottom_sheet.dart';
import 'package:dilaac/presentation/widgets/button.dart';
import 'package:dilaac/presentation/widgets/transaction_amount_cards.dart';
import 'package:dilaac/utils/list_item.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'payout_flow_screens/bank_detail_screen.dart';

class PayoutScreen extends StatefulHookWidget {
  @override
  _PayoutScreenState createState() => _PayoutScreenState();
}

class _PayoutScreenState extends State<PayoutScreen>
    with AfterLayoutMixin<PayoutScreen> {
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YMargin(Sizes.dimen_40),
//
                  Padding(
                    padding: const EdgeInsets.only(left: Sizes.dimen_16),
                    child: Text(
                      TranslationConstants.payoutTo,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: Sizes.dimen_18,
                          color: AppColor.black),
                    ),
                  ),
                  const YMargin(Sizes.dimen_16),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
                    child: SizedBox(
                      height: Sizes.dimen_110,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => navigator.context!
                                  .navigate(RecipientDetailsSreen()),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF2CB9B),
                                  borderRadius:
                                      BorderRadius.circular(Sizes.dimen_6),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const YMargin(Sizes.dimen_16),
                                    Image.asset(
                                      ImageConstant.bankPng,
                                      scale: Sizes.dimen_2,
                                    ),
                                    Spacer(),
                                    Text(
                                      TranslationConstants.bank,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w900,
                                              color: AppColor.black,
                                              letterSpacing: 1,
                                              fontSize: Sizes.dimen_16),
                                    ),
                                    const YMargin(Sizes.dimen_16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const XMargin(Sizes.dimen_16),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffF2CB9B),
                                borderRadius:
                                    BorderRadius.circular(Sizes.dimen_6),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const YMargin(Sizes.dimen_16),
                                  Image.asset(
                                    ImageConstant.smartPhonePng,
                                    scale: Sizes.dimen_2,
                                  ),
                                  Spacer(),
                                  Text(
                                    TranslationConstants.smartPhone,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                            color: AppColor.black,
                                            letterSpacing: 1,
                                            fontSize: Sizes.dimen_16),
                                  ),
                                  const YMargin(Sizes.dimen_16),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const YMargin(Sizes.dimen_32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const XMargin(Sizes.dimen_16),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          TranslationConstants.payoutHistory,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: Sizes.dimen_18,
                                  color: AppColor.black),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: AppColor.black,
                          size: Sizes.dimen_32,
                        ),
                      ),
                      const XMargin(Sizes.dimen_12),
                      Padding(
                        padding: const EdgeInsets.only(right: Sizes.dimen_4),
                        child: Builder(
                          builder: (context) => IconButton(
                              icon:
                                  SvgAssetConstant.rightMenuSVG(AppColor.black),
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
                                      ? Color(0xFFFD8D3C)
                                      : null,
                                  border: Border.all(
                                      color: _title[index].selected
                                          ? Color(0xFFFD8D3C)
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
                  const YMargin(Sizes.dimen_24),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_16),
                      child: TransactionAndAmountCard("200,000.00", "80")),

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
                                  color:
                                      AppColor.redLightColor.withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.circular(Sizes.dimen_16)),
                              child: SvgAssetConstant.upArrowSVG,
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
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "N50,0000",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF1D2121),
                                          fontSize: Sizes.dimen_18),
                                ),
                                Text(
                                  index % 2 == 0
                                      ? TranslationConstants.success
                                      : TranslationConstants.failed,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: index % 2 == 0
                                              ? AppColor.greenLightColor
                                              : AppColor.redLightColor,
                                          fontSize: Sizes.dimen_10),
                                ),
                              ],
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
                          TranslationConstants.payout,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: Sizes.dimen_22),
              child: SizedBox(
                width: Sizes.dimen_230,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Sizes.dimen_20),
                  child: Button2(
                    text: TranslationConstants.viewMore,
                    onPressed: () =>
                        navigator.pushTo(TransactionHistoryScreen()),
                  ),
                ),
              ),
            ),
          ),
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
