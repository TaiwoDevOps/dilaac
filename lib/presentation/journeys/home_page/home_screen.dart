import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/core/providers.dart';
import 'package:dilaac/models/trans_history_model.dart';
import 'package:dilaac/presentation/journeys/drawer/drawer_screen.dart';
import 'package:dilaac/presentation/journeys/payment_link_screen/payment_link_screen.dart';
import 'package:dilaac/presentation/journeys/transaction_history_screen/transaction_history_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/app_bar_widget.dart';
import 'package:dilaac/presentation/widgets/button.dart';
import 'package:dilaac/presentation/widgets/transaction_amount_cards.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '../transaction_history_screen/trans_widget.dart';

class DashBoardScreen extends StatefulHookWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with AfterLayoutMixin<DashBoardScreen> {
  bool? profile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read(userProfileVM).getProfile();
    context.read(transHistoryVM).getTransHist();
    context.read(paymentLinkVM).getPaymentLink();
  }

  @override
  Widget build(BuildContext context) {
    var profileProvider =
        useProvider(userProfileVM.select((value) => value.userProfileModel));
    var transProvider =
        useProvider(transHistoryVM.select((value) => value.transHistoryModel));
    var paymentLinkProvider =
        useProvider(paymentLinkVM.select((value) => value.paymentLinkModel));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Sizes.dimen_40),
            bottomRight: Radius.circular(Sizes.dimen_40),
          ),
          child: Container(
            width: ScreenUtil.screenWidth! * 0.9,
            height: ScreenUtil.screenHeight,
            decoration: BoxDecoration(
              color: AppColor.white,
            ),
            child: DrawerScreen(),
          ),
        ),
        body: profileProvider == null || transProvider == null
            ? Container()
            : Stack(
                fit: StackFit.expand,
                children: [
                  //bottom
                  FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          paymentLinkProvider == null ||
                                  paymentLinkProvider.data!.url!.isEmpty
                              ? YMargin(Sizes.dimen_40)
                              : SizedBox.shrink(),
                          paymentLinkProvider!.data!.url!.isEmpty
                              ? InkWell(
                                  onTap: () {
                                    navigator.pushTo(PaymentLinkScreen());
                                  },
                                  splashColor:
                                      AppColor.lightOrange.withOpacity(0.2),
                                  focusColor:
                                      AppColor.lightOrange.withOpacity(0.2),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: Sizes.dimen_10),
                                    height: Sizes.dimen_80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor
                                                .textFormPlaceHolderColor
                                                .withOpacity(0.4)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Sizes.dimen_10))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const XMargin(Sizes.dimen_16),
                                        SvgAssetConstant.chainSVG,
                                        const XMargin(Sizes.dimen_24),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                TranslationConstants
                                                    .generatePaymentLink,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColor.black),
                                              ),
                                              Text(
                                                TranslationConstants
                                                    .generatePaymentLinkDesc,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColor.black,
                                                        letterSpacing: 1.5,
                                                        fontSize:
                                                            Sizes.dimen_12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Sizes.dimen_30),
                                  child: Container(
                                    height: Sizes.dimen_50,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF9933),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(Sizes.dimen_4),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const XMargin(Sizes.dimen_16),
                                        SvgAssetConstant.blackChainSVG,
                                        const XMargin(Sizes.dimen_8),
                                        Expanded(
                                          child: Text(
                                            "${paymentLinkProvider.data!.url}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: Sizes.dimen_12,
                                                    color: AppColor.white),
                                          ),
                                        ),
                                        const XMargin(Sizes.dimen_24),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Sizes.dimen_8,
                                              vertical: Sizes.dimen_4),
                                          margin: const EdgeInsets.only(
                                              right: Sizes.dimen_12),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Sizes.dimen_30),
                                              color: AppColor.deepDarkOrange
                                                  .withOpacity(0.4)),
                                          child: Text(
                                            TranslationConstants.view,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFFBFBFB),
                                                    letterSpacing: 1,
                                                    fontSize: Sizes.dimen_14),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          paymentLinkProvider.data!.url!.isEmpty
                              ? YMargin(Sizes.dimen_32)
                              : SizedBox.shrink(),
                          Text(
                            TranslationConstants.transactionHistory,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: AppColor.black,
                                    letterSpacing: 1,
                                    fontSize: Sizes.dimen_14),
                          ),
                          YMargin(paymentLinkProvider.data!.url!.isEmpty
                              ? Sizes.dimen_16
                              : 0),
                          transProvider.data != null
                              ? //Transaction histories
                              Expanded(
                                  child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return TransactionWidget(
                                          type: transProvider.data
                                                  ?.transactions?[index].type ??
                                              '',
                                          narration: transProvider
                                                  .data
                                                  ?.transactions?[index]
                                                  .narration ??
                                              '',
                                          date: transProvider.data
                                                  ?.transactions?[index].date ??
                                              '',
                                          amount: transProvider.data
                                                  ?.transactions?[index].amount
                                                  .toString() ??
                                              '');
                                    },
                                    separatorBuilder: (context, index) =>
                                        Container(height: Sizes.dimen_16),
                                    itemCount: transProvider.data != null
                                        ? transProvider
                                            .data!.transactions!.length
                                        : 0,
                                  ),
                                )
                              : Container(
                                  height: Sizes.dimen_200,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Sizes.dimen_10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor
                                              .textFormPlaceHolderColor
                                              .withOpacity(0.4)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Sizes.dimen_10))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Spacer(),
                                      Image.asset(
                                        ImageConstant.paperPng,
                                        height: Sizes.dimen_60,
                                      ),
                                      const YMargin(Sizes.dimen_24),
                                      Text(
                                        TranslationConstants
                                            .noInformationAvailable,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                                fontWeight: FontWeight.w900,
                                                fontSize: Sizes.dimen_16,
                                                color: AppColor.black),
                                      ),
                                      const YMargin(Sizes.dimen_8),
                                      Text(
                                        TranslationConstants
                                            .noInformationAvailableDesc,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.black,
                                                letterSpacing: 1.5,
                                                fontSize: Sizes.dimen_12),
                                      ),
                                      const YMargin(Sizes.dimen_24),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.dimen_16),
                        decoration: BoxDecoration(
                          gradient: kHomeLinearGrad,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Sizes.dimen_30),
                            bottomRight: Radius.circular(Sizes.dimen_30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SafeArea(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Builder(
                                    builder: (context) => IconButton(
                                        icon: SvgAssetConstant.menuSVG,
                                        padding: const EdgeInsets.all(0),
                                        alignment: Alignment.centerLeft,
                                        onPressed: () {
                                          Scaffold.of(context).openDrawer();
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: Sizes.dimen_12),
                                    child: Container(
                                      height: Sizes.dimen_40,
                                      width: Sizes.dimen_40,
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(
                                            Sizes.dimen_100),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const YMargin(Sizes.dimen_20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      TranslationConstants.walletBalance,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.white),
                                    ),
                                    Text(
                                      "N${profileProvider.data?.transactionCount?.walletBalance.toString() ?? '0.0'}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w900,
                                              color: AppColor.white,
                                              letterSpacing: 1.5,
                                              fontSize: Sizes.dimen_28),
                                    ),
                                  ],
                                ),
                                SvgAssetConstant.walletSVG
                              ],
                            ),
                            const YMargin(Sizes.dimen_26),
                            TransactionAndAmountCard(
                                "${profileProvider.data?.transactionCount?.totalAmount.toString() ?? '0.0'}",
                                "${profileProvider.data?.transactionCount?.totalCount.toString() ?? '0'}"),
                            Spacer()
                          ],
                        ),
                      )),
                  profileProvider.data != null &&
                          profileProvider.data!.transactionCount!.totalCount! <
                              8
                      ? SizedBox.shrink()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: Sizes.dimen_22),
                            child: SizedBox(
                              width: Sizes.dimen_230,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.dimen_20),
                                child: Button2(
                                  text: TranslationConstants.viewMore,
                                  onPressed: () => navigator
                                      .pushTo(TransactionHistoryScreen()),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
