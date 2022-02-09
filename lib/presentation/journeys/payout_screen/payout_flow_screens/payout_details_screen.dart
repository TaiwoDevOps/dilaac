import 'dart:async';
import 'dart:io';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/core/providers.dart';
import 'package:dilaac/presentation/journeys/home_page/home_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/button.dart';
import 'package:dilaac/presentation/widgets/dialog_box_widget.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PayoutDetailsScreen extends StatefulHookWidget {
  @override
  _PayoutDetailsScreenState createState() => _PayoutDetailsScreenState();
}

class _PayoutDetailsScreenState extends State<PayoutDetailsScreen> {
  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  bool dialog = false;
  String currentText = "";
  String? selectedBank;
  String? selectedBankBranch;
  String? selectedBankCode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var payoutProvider = useProvider(payoutVM);
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Stack(
        children: [
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.9,
            child: ListView(
              children: [
                const YMargin(Sizes.dimen_100),
                Center(
                  child: Text(
                    "To",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: AppColor.textFormPlaceHolderColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                        height: 2),
                  ),
                ),
                const YMargin(Sizes.dimen_16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Sizes.dimen_100),
                  child: Text(
                    "Kunle Emeka Johnson",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.dimen_20,
                        letterSpacing: 0.5,
                        height: 1.5),
                  ),
                ),
                const YMargin(Sizes.dimen_16),
                Center(
                  child: Text(
                    TranslationConstants.amount,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: AppColor.textFormPlaceHolderColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                        height: 2),
                  ),
                ),
                const YMargin(Sizes.dimen_16),
                Center(
                  child: Text(
                    "50,300.20",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.dimen_16,
                        ),
                  ),
                ),
                const YMargin(Sizes.dimen_32),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${TranslationConstants.description}:",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.normal,
                              fontSize: Sizes.dimen_16,
                            ),
                      ),
                      Text(
                        "For 50 bags of sugar",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.normal,
                              fontSize: Sizes.dimen_16,
                            ),
                      ),
                    ],
                  ),
                ),
                const YMargin(Sizes.dimen_8),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TranslationConstants.beneficiaryBank,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.normal,
                              fontSize: Sizes.dimen_16,
                            ),
                      ),
                      Text(
                        "Zenith Bank",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.dimen_16,
                            ),
                      ),
                    ],
                  ),
                ),
                const YMargin(Sizes.dimen_36),
                Center(
                  child: Text(
                    TranslationConstants.transactionPin,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.w700,
                          fontSize: Sizes.dimen_16,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Sizes.dimen_24),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil.screenWidth! * 0.2),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldHeight: Sizes.dimen_50,
                          fieldWidth: Sizes.dimen_50,
                          fieldOuterPadding: const EdgeInsets.all(0),
                          activeColor: Colors.grey.shade300,
                          inactiveFillColor: Colors.transparent,
                          activeFillColor:
                              hasError ? Colors.black87 : Colors.transparent,
                          inactiveColor: AppColor.textFormBorderColor,
                          selectedColor: Colors.black.withOpacity(0.5),
                          selectedFillColor: Colors.transparent,
                          disabledColor: Colors.grey),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) async {
                        int pin = int.parse(v);
                        var res = await showDialog(
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
                                        onTap: () =>
                                            Navigator.pop(context, true),
                                        child: DialogBoxWidget(
                                            TranslationConstants
                                                .paymentSuccessful)),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        if (res)
                          navigator.context!.navigateReplace(DashBoardScreen());
                      },
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                    ),
                  ),
                ),
                const YMargin(Sizes.dimen_36),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
                    child: Button(
                        text: TranslationConstants.payout, onPressed: () {}),
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
                                onPressed: () => navigator.context!.popView()),
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
        ],
      ),
    );
  }
}
