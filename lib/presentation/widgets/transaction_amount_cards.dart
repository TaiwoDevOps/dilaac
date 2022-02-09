import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/material.dart';

import '../journeys/transaction_history_screen/transaction_list.dart';

class TransactionAndAmountCard extends StatelessWidget {
  final String amount, transCount;
  const TransactionAndAmountCard(this.amount, this.transCount);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.dimen_110,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: Sizes.dimen_200,
              padding: const EdgeInsets.only(left: Sizes.dimen_16),
              decoration: BoxDecoration(
                color: Color(0xff265AFF),
                borderRadius: BorderRadius.circular(Sizes.dimen_6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YMargin(Sizes.dimen_16),
                  Text(
                    TranslationConstants.totalAmountRec,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColor.white,
                        letterSpacing: 1.5,
                        fontSize: Sizes.dimen_14),
                  ),
                  Spacer(),
                  Text(
                    "N$amount",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColor.white,
                        letterSpacing: 1.5,
                        fontSize: Sizes.dimen_16),
                  ),
                  const YMargin(Sizes.dimen_16),
                ],
              ),
            ),
          ),
          const XMargin(Sizes.dimen_16),
          InkWell(
            onTap: () {
              navigator.context!.navigate(TransactionListScreen());
            },
            child: Container(
              width: Sizes.dimen_140,
              padding: const EdgeInsets.only(left: Sizes.dimen_16),
              decoration: BoxDecoration(
                color: Color(0xffFF5326),
                borderRadius: BorderRadius.circular(Sizes.dimen_6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YMargin(Sizes.dimen_16),
                  Text(
                    TranslationConstants.noOfTransaction,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColor.white,
                        letterSpacing: 1.5,
                        fontSize: Sizes.dimen_14),
                  ),
                  Spacer(),
                  Text(
                    "$transCount",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColor.white,
                        letterSpacing: 1.5,
                        fontSize: Sizes.dimen_16),
                  ),
                  const YMargin(Sizes.dimen_16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
