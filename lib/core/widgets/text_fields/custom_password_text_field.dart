import 'package:flutter/material.dart';
import 'custom_text_form_field.dart';

class CustomPasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? upperText;

  const CustomPasswordTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.upperText,
  });

  @override
  State<CustomPasswordTextField> createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: widget.hintText,
      controller: widget.controller,
      validator: widget.validator,
      upperText: widget.upperText,
      isObscureText: isObscure,
      suffixIcon: isObscure ? Icons.visibility_off : Icons.visibility,
      suffixIconTap: () {
        setState(() {
          isObscure = !isObscure;
        });
      },
    );
  }
}
