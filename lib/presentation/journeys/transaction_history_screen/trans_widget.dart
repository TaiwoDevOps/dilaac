import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../../common/constants/image_constants.dart';
import '../../../common/constants/size_constants.dart';
import '../../../models/trans_history_model.dart';
import '../../themes/theme_color.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget(
      {Key? key,
      required this.type,
      required this.narration,
      required this.amount,
      required this.date})
      : super(key: key);

  final String type, date, amount, narration;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Container(
        padding: const EdgeInsets.all(Sizes.dimen_12),
        width: Sizes.dimen_60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: type.toLowerCase() == "payin"
                ? AppColor.greenLightColor.withOpacity(0.2)
                : AppColor.redLightColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(Sizes.dimen_16)),
        child: type.toLowerCase() == "payin"
            ? SvgAssetConstant.downArrowSVG
            : SvgAssetConstant.upArrowSVG,
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$narration",
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.black,
                fontSize: Sizes.dimen_14),
          ),
          Text(
            Jiffy(date.split("T")[0]).format("MMM do yy"),
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontWeight: FontWeight.w400,
                color: Color(0xFF444444),
                fontSize: Sizes.dimen_12),
          ),
        ],
      ),
      trailing: Text(
        "N$amount",
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
            fontWeight: FontWeight.w500,
            color: Color(0xFF1D2121),
            fontSize: Sizes.dimen_18),
      ),
    );
  }
}
