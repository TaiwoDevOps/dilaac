import 'package:dilaac/domain/entities/app_error.dart';
import 'package:flutter/material.dart';

import '../../common/constants/size_constants.dart';
import '../../common/constants/translation_constants.dart';
import '../../common/extensions/size_extensions.dart';
import 'button.dart';

class AppErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final Function() onPressed;

  const AppErrorWidget({
    Key? key,
    required this.errorType,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorType == AppErrorType.api
                ? TranslationConstants.somethingWentWrong
                : TranslationConstants.checkNetwork,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          ButtonBar(
            children: [
              Button(
                onPressed: onPressed,
                text: TranslationConstants.retry,
              ),
              Button(
                onPressed: () {},
                text: TranslationConstants.feedback,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
