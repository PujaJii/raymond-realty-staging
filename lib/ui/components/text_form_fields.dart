import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';

class TextFormFields extends StatefulWidget {
  const TextFormFields({
    this.textAlign = TextAlign.start,
    this.enabled = true,
    this.textEditingController,
    this.contentPadding = const EdgeInsets.only(bottom: 12.0, top: -5),
    this.initialValue = '',
    this.autoFocus = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.obscureText = false,
    this.textInputAction = TextInputAction.continueAction,
    this.label = '',
    this.labelStyle = const TextStyle(
      //fontFamily: AppFonts.mpRegular,
      fontSize: 20,
      color: AppColors.cTextColor,
    ),
    this.hintText = '',
    this.hintStyle = const TextStyle(
        //fontFamily: AppFonts.mpRegular,
        fontSize: 20,
        color: AppColors.cTextLightColor,
        fontWeight: FontWeight.normal),
    this.fieldStyle = const TextStyle(
        //fontFamily: AppFonts.mpRegular,
        fontSize: 20,
        color: AppColors.cTextColor,
        fontWeight: FontWeight.normal),
    this.errorStyle = const TextStyle(
        //fontFamily: AppFonts.mpRegular,
        fontSize: 10,
        height: 1.5,
        fontWeight: FontWeight.normal),
    this.borderColor = AppColors.cBorderColor,
    this.focusColor = AppColors.cTextColor,
    this.cursorColor = AppColors.cTextColor,
    this.focusBorderColor = AppColors.cBorderColor,
    this.focusNode,
    this.textInputType = TextInputType.text,
    this.isIcon = false,
    this.isSuffixIcon = false,
    this.isPrefixIcon = false,
    this.icon,
    this.image,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
    this.inputFormatter,
    this.onEditingComplete,
    this.onTap,
    this.obscuringCharacter = '•',
    this.filled = true,
    this.isBorder = true,
    this.fillColor = AppColors.cPrimaryColor,
  });

  final TextAlign textAlign;
  final bool enabled;
  final TextEditingController? textEditingController;
  final EdgeInsets contentPadding;
  final String initialValue;
  final bool autoFocus;
  final int maxLines;
  final int minLines;
  final bool obscureText;
  final TextInputAction textInputAction;
  final String label;
  final TextStyle labelStyle;
  final String hintText;
  final TextStyle hintStyle;
  final TextStyle fieldStyle;
  final TextStyle errorStyle;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final bool isIcon;
  final bool isSuffixIcon;
  final bool isPrefixIcon;
  final Widget? icon;
  final Widget? image;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final Color borderColor;
  final Color focusColor;
  final Color focusBorderColor;
  final Color cursorColor;
  final Function(String s)? onChanged;
  final String? Function(String? s)? validator;
  final Function(String? s)? onSaved;
  final Function(String s)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final String obscuringCharacter;
  final List<TextInputFormatter>? inputFormatter;
  final bool filled;
  final bool isBorder;
  final Color fillColor;

  @override
  State<StatefulWidget> createState() {
    return _TextFormFieldsState();
  }
}

class _TextFormFieldsState extends State<TextFormFields> {
  final FocusNode focusPass = FocusNode();
  TextStyle? labelStyle;

  @override
  void initState() {
    super.initState();
    focusPass.addListener(onFocusChange);
  }

  void onFocusChange() {
    setState(() {
      labelStyle = focusPass.hasFocus
          ? const TextStyle(
              color: AppColors.cTextColor,
              fontSize: 16.0,
              //fontFamily: AppFonts.mpRegular,
              fontWeight: FontWeight.bold)
          : null;
    });
  }

  @override
  void dispose() {
    focusPass.removeListener(onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          cursorColor: widget.cursorColor,
          textAlign: widget.textAlign,
          enabled: widget.enabled,
          controller: widget.textEditingController,
          initialValue: widget.initialValue,
          maxLines: widget.maxLines,
          minLines: widget.maxLines,
          obscureText: widget.obscureText,
          autofocus: widget.autoFocus,
          focusNode: focusPass,
          keyboardType: widget.textInputType,
          style: widget.fieldStyle,
          decoration: InputDecoration(
            filled: widget.filled,
            fillColor: widget.fillColor,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            errorStyle: widget.errorStyle,
            prefixIcon: (widget.isPrefixIcon) ? widget.prefixIcon : null,
            icon: (widget.isIcon) ? widget.icon : null,
            contentPadding: widget.contentPadding,
            suffixIcon: (widget.isSuffixIcon) ? widget.suffixIcon : null,
            focusColor: widget.focusColor,
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: widget.borderColor,
                  style:
                      widget.isBorder ? BorderStyle.solid : BorderStyle.none),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: widget.borderColor,
                  style:
                      widget.isBorder ? BorderStyle.solid : BorderStyle.none),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: widget.borderColor,
                  style:
                      widget.isBorder ? BorderStyle.solid : BorderStyle.none),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: widget.borderColor,
                  style:
                      widget.isBorder ? BorderStyle.solid : BorderStyle.none),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: widget.borderColor,
                  style:
                      widget.isBorder ? BorderStyle.solid : BorderStyle.none),
            ),
            labelText: widget.label,
            labelStyle: focusPass.hasFocus ? labelStyle : null,
          ),
          obscuringCharacter: widget.obscuringCharacter,
          validator: widget.validator,
          onSaved: widget.onSaved,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatter,
          onEditingComplete: widget.onEditingComplete,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
