import 'package:flutter/material.dart';

import '../../common/constants/size_constants.dart';
import '../../common/extensions/size_extensions.dart';
import '../themes/theme_color.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isEnabled;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        gradient: kLinearGrad,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFD8D3C).withOpacity(0.3),
            blurRadius: 70,
            offset: Offset(0, 20),
            spreadRadius: 0,
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.dimen_50),
        ),
      ),
      height: Sizes.dimen_60.sp,
      child: TextButton(
        key: const ValueKey('main_button'),
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          text,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}

class Button2 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isEnabled;

  const Button2({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: Color(0xFFFD8D3C)),
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.dimen_50),
        ),
      ),
      height: Sizes.dimen_60.sp,
      child: TextButton(
        key: const ValueKey('main_button_2'),
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          text,
          style: Theme.of(context).textTheme.button?.copyWith(
              color: Color(0xFF993333), fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
