// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:imageapp/constant/app_style.dart';

class CustomButton extends StatelessWidget {
  final String name;
  void Function()? onTap;
  double? width;
  Color? color;
  CustomButton({
    super.key,
    required this.name,
    this.onTap,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width ?? AppStyle.width(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: color ?? AppStyle.white,
          ),
          child: Padding(
            padding: AppStyle.smallEdgeInsets,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: AppStyle.primaryHeading(size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
