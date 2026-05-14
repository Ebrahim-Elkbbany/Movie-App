import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'upper_text_field_text.dart';
import 'text_field_suffix_icon.dart';
import 'text_field_prefix_icon.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? isObscureText;
  final bool isReadOnly;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Function()? suffixIconTap;
  final String? upperText;
  final Color? backgroundColor;
  final Color? upperTextColor;
  final double? upperTextFontSize;
  final FontWeight? upperTextFontWeight;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String? initialValue;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.isObscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconTap,
    this.upperText,
    this.isReadOnly = false,
    this.backgroundColor,
    this.upperTextColor,
    this.upperTextFontSize,
    this.upperTextFontWeight,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (upperText != null)
          UpperTextFieldText(
            text: upperText!,
            textColor: upperTextColor,
            fontWeight: upperTextFontWeight,
            fontSize: upperTextFontSize,
          ),
        TextFormField(
          readOnly: isReadOnly,
          controller: controller,
          initialValue: initialValue,
          obscureText: isObscureText ?? false,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          maxLength: maxLength,
          style: inputTextStyle,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle,
            fillColor: backgroundColor,
            contentPadding: contentPadding,
            focusedBorder: focusedBorder,
            enabledBorder: enabledBorder,
            suffixIcon: suffixIcon != null
                ? TextFieldSuffixIcon(
                    icon: suffixIcon!,
                    onTap: suffixIconTap,
                  )
                : null,
            prefixIcon: prefixIcon != null
                ? TextFieldPrefixIcon(
                    icon: prefixIcon!,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
