// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:imageapp/constant/app_style.dart';

class ProfileTile extends StatelessWidget {
  final void Function()? onTap;
  final String name;
  Icon? icon;
  ProfileTile({super.key, required this.onTap, required this.name, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppStyle.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                icon ?? Container(),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    name,
                    style: AppStyle.normalText().copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
