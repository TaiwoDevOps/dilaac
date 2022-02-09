import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:flutter/material.dart';

class InputDropdown extends StatelessWidget {
  const InputDropdown(
      {this.labelText,
      this.valueText,
      this.valueStyle,
      this.hintText,
      this.onPressed,
      required this.suffixIcon});

  final String? labelText;
  final String? valueText;
  final String? hintText;
  final TextStyle? valueStyle;
  final VoidCallback? onPressed;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.dimen_10),
          color: Colors.white,
        ),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: AppColor.black,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
                height: 2),
            hintText: hintText,
            fillColor: Colors.white,
            border: InputBorder.none,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: suffixIcon,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColor.textFormBorderColor, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: AppColor.textFormBorderColor,
                width: 1.0,
              ),
            ),
          ),
          baseStyle: valueStyle,
          child: Text(valueText ?? hintText!, style: valueStyle),
        ),
      ),
    );
  }
}
