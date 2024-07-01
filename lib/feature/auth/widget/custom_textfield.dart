// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool? showPassword;
  int? maxLines;
  int? maxLength;
  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.showPassword,
    this.maxLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: !(showPassword ?? true),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppStyle.white,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppStyle.black,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppStyle.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppStyle.error,
            width: 1,
          ),
        ),
        errorStyle: AppStyle.textFieldErrorStyle(),
        contentPadding: const EdgeInsets.only(top: 10, left: 10),
        fillColor: AppStyle.white,
        filled: true,
        hintText: hintText,
        hintStyle: AppStyle.textFieldHintStyle(),
      ),
      style: AppStyle.textFieldStyle(),
      textAlignVertical: TextAlignVertical.center,
      cursorColor: AppStyle.black,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: (value) {
        if (value == '') {
          return AppString.requiredField;
        }
        return null;
      },
    );
  }
}
