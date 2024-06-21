// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:imageapp/constant/app_style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool? showPassword;
  CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.showPassword});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: !(showPassword ?? true),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppStyle.white,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppStyle.white,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppStyle.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppStyle.error,
            width: 1,
          ),
        ),
        errorStyle: AppStyle.textFieldStyle().copyWith(color: AppStyle.error),
        contentPadding: const EdgeInsets.only(top: 10, left: 10),
        fillColor: AppStyle.white.withOpacity(0.2),
        filled: true,
        hintText: hintText,
        hintStyle: AppStyle.textFieldStyle().copyWith(color: AppStyle.white),
      ),
      style: AppStyle.textFieldStyle().copyWith(color: AppStyle.white),
      textAlignVertical: TextAlignVertical.center,
      cursorColor: AppStyle.white,
      validator: (value) {
        if (value == '') {
          return "Enter value";
        }
        return null;
      },
    );
  }
}
