import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/core/providers.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/app_bar_widget.dart';
import 'package:dilaac/presentation/widgets/button.dart';
import 'package:dilaac/utils/helper_functions.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentLinkScreen extends StatefulHookWidget {
  @override
  _PaymentLinkScreenState createState() => _PaymentLinkScreenState();
}

class _PaymentLinkScreenState extends State<PaymentLinkScreen>
    with AfterLayoutMixin<PaymentLinkScreen> {
  bool _showCopy = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    var paymentLinkProvider = useProvider(paymentLinkVM);
    var provider =
        useProvider(paymentLinkVM.select((value) => value.paymentLinkModel));
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          //bottom
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.9,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageConstant.chainPng,
                    height: Sizes.dimen_60,
                  ),
                  const YMargin(Sizes.dimen_40),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.dimen_60),
                    child: Text(
                      _showCopy
                          ? TranslationConstants.linkGenerated
                          : TranslationConstants.paymentLinkTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: Sizes.dimen_18,
                          color: AppColor.black),
                    ),
                  ),
                  const YMargin(Sizes.dimen_12),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.dimen_30),
                    child: Text(
                      _showCopy
                          ? TranslationConstants.linkGeneratedDesc
                          : TranslationConstants.paymentLinkDesc,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: Sizes.dimen_12,
                          color: AppColor.black),
                    ),
                  ),
                  _showCopy
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Sizes.dimen_30),
                          child: Tooltip(
                            key: CopyKeys.paymentLink,
                            message: "${provider?.data?.url} copied",
                            preferBelow: false,
                            child: GestureDetector(
                              onTap: () {
                                final dynamic tooltip =
                                    CopyKeys.paymentLink.currentState;

                                tooltip?.ensureTooltipVisible();

                                Clipboard.setData(
                                    ClipboardData(text: provider?.data?.url));
                              },
                              child: Container(
                                height: Sizes.dimen_40,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF9933).withOpacity(0.2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(Sizes.dimen_4),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const XMargin(Sizes.dimen_22),
                                    Text(
                                      "COPY",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                              fontWeight: FontWeight.w900,
                                              fontSize: Sizes.dimen_12,
                                              color: AppColor.black),
                                    ),
                                    const XMargin(Sizes.dimen_12),
                                    SvgAssetConstant.copySVG,
                                    const XMargin(Sizes.dimen_22),
                                    Expanded(
                                      child: Text(
                                        "${provider?.data?.url ?? ''}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                                fontWeight: FontWeight.w900,
                                                fontSize: Sizes.dimen_12,
                                                color: Color(0xFFFF9933)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const YMargin(Sizes.dimen_70),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_20),
                      child: Button(
                        text: _showCopy
                            ? TranslationConstants.share
                            : TranslationConstants.yesCreate,
                        onPressed: () async {
                          if (!_showCopy) {
                            await paymentLinkProvider.getPaymentLink();
                            if (provider != null && provider.data!.url != null)
                              setState(() {
                                _showCopy = !_showCopy;
                              });
                          } else {
                            share(provider!.data!.url!);
                          }
                        },
                      ),
                    ),
                  ),
                  const YMargin(Sizes.dimen_16),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_20),
                      child: Button2(
                        text: _showCopy
                            ? TranslationConstants.done
                            : TranslationConstants.cancel,
                        onPressed: () {
                          navigator.context!.popView();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
                decoration: BoxDecoration(
                  gradient: kHomeLinearGrad,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Sizes.dimen_30),
                    bottomRight: Radius.circular(Sizes.dimen_30),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
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
                      Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          TranslationConstants.paymentLink,
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
