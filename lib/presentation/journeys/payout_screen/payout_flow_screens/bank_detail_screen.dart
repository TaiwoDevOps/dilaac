import 'dart:io';
import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/common/screenutil/screenutil.dart';
import 'package:dilaac/core/providers.dart';
import 'package:dilaac/presentation/journeys/payout_screen/payout_flow_screens/payout_details_screen.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/bank_list_widget.dart';
import 'package:dilaac/presentation/widgets/button.dart';
import 'package:dilaac/presentation/widgets/dilaac.dart';
import 'package:dilaac/presentation/widgets/dilaac_input_dropdown.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:dilaac/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../common/extensions/size_extensions.dart';
import 'bvn_pin_screen.dart';

class RecipientDetailsSreen extends StatefulHookWidget {
  @override
  _RecipientDetailsSreenState createState() => _RecipientDetailsSreenState();
}

class _RecipientDetailsSreenState extends State<RecipientDetailsSreen> {
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
    var payoutProvider = useProvider(payoutVM);

    var profileProvider =
        useProvider(userProfileVM.select((value) => value.userProfileModel));
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Stack(
        children: [
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.9,
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const YMargin(Sizes.dimen_100),
                  DilaacTextField2(
                    labelText: "Bank Name",
                    labelTitle: "Bank Name",
                    controller: payoutProvider.bankNameTEC,
                    margin: Sizes.dimen_16,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else if (value.isEmpty) {
                        return "Bank name is required";
                      } else {
                        return "Please enter a valid bank name";
                      }
                    },
                    onEditingComplete: () {},
                    onChanged: (val) {},
                  ),
                  const YMargin(Sizes.dimen_20),
                  DilaacTextField2(
                    labelText: "Account Number",
                    labelTitle: "Account Number",
                    controller: payoutProvider.acctNumberTEC,
                    margin: Sizes.dimen_16,
                    isPhone: true,
                    validator: (value) {
                      if (value!.isNotEmpty &&
                          Validator.containSpecialChars(value)) {
                        return null;
                      } else if (value.isEmpty) {
                        return "Account Number is required";
                      } else {
                        return "Please enter a valid number";
                      }
                    },
                    onEditingComplete: () {},
                    onChanged: (val) {},
                  ),
                  DilaacTextField2(
                    labelText: "Account holder name",
                    labelTitle: "Account holder Name",
                    margin: Sizes.dimen_16,
                    controller: payoutProvider.acctNameTEC,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else if (value.isEmpty) {
                        return "Account holder name is required";
                      } else {
                        return "Please enter a valid Account holder name";
                      }
                    },
                    onEditingComplete: () {},
                    onChanged: (val) {},
                  ),
                  const YMargin(Sizes.dimen_20),
                  DilaacTextField2(
                    labelText: "Amount",
                    labelTitle: "Amount",
                    controller: payoutProvider.amountTEC,
                    margin: Sizes.dimen_16,
                    isMoney: true,
                    validator: (value) {
                      if (value!.isNotEmpty &&
                          Validator.containSpecialChars(value)) {
                        return null;
                      } else if (value.isEmpty) {
                        return "Amount is required";
                      } else {
                        return "Please enter a valid number";
                      }
                    },
                    onEditingComplete: () {},
                    onChanged: (val) {},
                  ),
                  const YMargin(Sizes.dimen_20),
                  DilaacTextField2(
                    labelText: "Description",
                    labelTitle: "Description",
                    margin: Sizes.dimen_16,
                    controller: payoutProvider.descTEC,
                    maxLines: 4,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else if (value.isEmpty) {
                        return "Description is required";
                      } else {
                        return "";
                      }
                    },
                    onEditingComplete: () {},
                    onChanged: (val) {},
                  ),
                  const YMargin(Sizes.dimen_60),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
                    child: Button(
                        text: TranslationConstants.next,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (profileProvider!.data!.hasPin!)
                              navigator.pushTo(PayoutDetailsScreen());
                            else
                              navigator.pushTo(BvnPinPayoutSreen());
                          }
                        }),
                  ),
                ],
              ),
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
