import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DilaacTextField extends StatefulWidget {
  final String? labelText, labelTitle, prefix;
  final TextEditingController? controller;
  final Color? textColor;
  final Widget? suffix, suffixIcon, prefixWidget;
  final bool? isEmail, isPhone, readOnly, isPassword;
  final bool? autovalidate, isMoney, isDark;
  // final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final double? margin;
  final int? maxLength, maxLines;
  final Function()? onEditingComplete;
  const DilaacTextField({
    Key? key,
    this.prefix,
    this.controller,
    this.labelTitle,
    this.readOnly = false,
    // this.hintText,
    this.labelText,
    this.isEmail = false,
    this.isPhone = false,
    this.isPassword = false,
    this.autovalidate = false,
    this.isDark = false,
    this.isMoney = false,
    this.textColor = Colors.black,
    this.maxLength = 1,
    this.maxLines,
    this.suffix,
    this.suffixIcon,
    this.prefixWidget,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
    this.margin = 0,
  }) : super(key: key);

  @override
  _DilaacTextField createState() => _DilaacTextField();
}

class _DilaacTextField extends State<DilaacTextField> {
  bool _isObscure = true;
  FocusNode myFocusNode = new FocusNode();
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.margin!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.labelTitle ?? '',
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: AppColor.black,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
                height: 2),
          ),
          Container(
            child: FocusScope(
              child: Focus(
                onFocusChange: (hasFocus) {
                  setState(() {
                    // we need call setState to Color update properly
                    // based on isValid property
                  });
                },
                child: TextFormField(
                  focusNode: myFocusNode,
                  textAlignVertical: TextAlignVertical.center,
                  autovalidateMode:
                      widget.autovalidate! ? AutovalidateMode.always : null,
                  controller: widget.controller,
                  enableInteractiveSelection: true,
                  obscureText: widget.isPassword! && _isObscure,
                  maxLines: widget.isPassword! ? 1 : widget.maxLines,
                  onChanged: widget.onChanged,
                  validator: (String? value) {
                    if (widget.validator == null) return null;

                    String? text = widget.validator!(value);
                    setState(() {
                      isValid = text == null;
                    });
                    return widget.validator!(value);
                  },
                  cursorColor: AppColor.black,
                  readOnly: widget.readOnly!,
                  onEditingComplete: widget.onEditingComplete,
                  keyboardType: widget.isEmail!
                      ? TextInputType.emailAddress
                      : widget.isPhone!
                          ? TextInputType.phone
                          : widget.isMoney!
                              ? TextInputType.numberWithOptions()
                              : TextInputType.text,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    errorMaxLines: 2,
                    // hintText: widget.hintText,
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: widget.isPassword! && _isObscure
                        ? EdgeInsets.fromLTRB(0, 15, 16, 15)
                        : EdgeInsets.fromLTRB(0, 15, 16, 15),
                    labelText: widget.labelText,
                    prefixText: widget.prefix,
                    prefixIcon: widget.prefixWidget,
                    suffix: widget.suffixIcon,
                    suffixIcon: widget.isPassword!
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            child: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColor.darkOrange,
                              size: Sizes.dimen_20,
                            ))
                        : widget.suffix,
                    errorStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: AppColor.darkOrange,
                        fontWeight: FontWeight.w300),
                    hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.w500),
                    labelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: myFocusNode.hasFocus && isValid
                            ? Colors.transparent
                            : !isValid
                                ? AppColor.textFormPlaceHolderColor
                                : AppColor.textFormPlaceHolderColor,
                        fontWeight: FontWeight.w500),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.textFormBorderColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.textFormBorderColor),
                    ),
                    border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.textFormBorderColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DilaacTextField2 extends StatefulWidget {
  final String? labelText, labelTitle, prefix;
  final TextEditingController? controller;
  final Color? textColor;
  final Widget? suffix, suffixIcon, prefixWidget;
  final bool? isEmail, isPhone, readOnly, isPassword;
  final bool? autovalidate, isMoney, isDark;
  // final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final double? margin;
  final int? maxLength, maxLines;
  final Function()? onEditingComplete;
  const DilaacTextField2({
    Key? key,
    this.prefix,
    this.controller,
    this.labelTitle,
    this.readOnly = false,
    // this.hintText,
    this.labelText,
    this.isEmail = false,
    this.isPhone = false,
    this.isPassword = false,
    this.autovalidate = false,
    this.isDark = false,
    this.isMoney = false,
    this.textColor = Colors.black,
    this.maxLength = 1,
    this.maxLines,
    this.suffix,
    this.suffixIcon,
    this.prefixWidget,
    this.onChanged,
    this.onEditingComplete,
    this.validator,
    this.margin = 0,
  }) : super(key: key);

  @override
  _DilaacTextField2 createState() => _DilaacTextField2();
}

class _DilaacTextField2 extends State<DilaacTextField2> {
  bool _isObscure = true;
  FocusNode myFocusNode = new FocusNode();
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.margin!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.labelTitle ?? '',
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: AppColor.black,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
                height: 2),
          ),
          const YMargin(Sizes.dimen_8),
          Container(
            child: FocusScope(
              child: Focus(
                onFocusChange: (hasFocus) {
                  setState(() {
                    // we need call setState to Color update properly
                    // based on isValid property
                  });
                },
                child: TextFormField(
                  focusNode: myFocusNode,
                  textAlignVertical: TextAlignVertical.center,
                  autovalidateMode:
                      widget.autovalidate! ? AutovalidateMode.always : null,
                  controller: widget.controller,
                  enableInteractiveSelection: true,
                  obscureText: widget.isPassword! && _isObscure,
                  maxLines: widget.isPassword! ? 1 : widget.maxLines,
                  onChanged: widget.onChanged,
                  validator: (String? value) {
                    if (widget.validator == null) return null;

                    String? text = widget.validator!(value);
                    setState(() {
                      isValid = text == null;
                    });
                    return widget.validator!(value);
                  },
                  cursorColor: AppColor.black,
                  readOnly: widget.readOnly!,
                  onEditingComplete: widget.onEditingComplete,
                  keyboardType: widget.isEmail!
                      ? TextInputType.emailAddress
                      : widget.isPhone!
                          ? TextInputType.phone
                          : widget.isMoney!
                              ? TextInputType.numberWithOptions()
                              : TextInputType.text,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: AppColor.black, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    errorMaxLines: 2,
                    // hintText: widget.hintText,
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: widget.isPassword! && _isObscure
                        ? EdgeInsets.fromLTRB(20, 22, 16, 22)
                        : EdgeInsets.fromLTRB(20, 22, 16, 22),
                    labelText: widget.labelText,
                    prefixText: widget.prefix,
                    prefixIcon: widget.prefixWidget,
                    suffix: widget.suffixIcon,
                    suffixIcon: widget.isPassword!
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            child: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColor.darkOrange,
                              size: Sizes.dimen_20,
                            ))
                        : widget.suffix,
                    errorStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: AppColor.darkOrange,
                        fontWeight: FontWeight.w300),
                    hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.w500),
                    labelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: myFocusNode.hasFocus && isValid
                            ? Colors.transparent
                            : !isValid
                                ? AppColor.textFormPlaceHolderColor
                                : AppColor.textFormPlaceHolderColor,
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.dimen_2),
                      borderSide: BorderSide(
                        color: AppColor.textFormPlaceHolderColor,
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.dimen_2),
                      borderSide: BorderSide(
                        color: AppColor.textFormPlaceHolderColor,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.dimen_2),
                      borderSide: BorderSide(
                        color: AppColor.textFormPlaceHolderColor,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.dimen_2),
                      borderSide: BorderSide(
                        color: AppColor.textFormPlaceHolderColor,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.dimen_2),
                      borderSide: BorderSide(
                        color:
                            AppColor.textFormPlaceHolderColor.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.dimen_2),
                      borderSide: BorderSide(
                        color: Colors.grey[700]!,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
