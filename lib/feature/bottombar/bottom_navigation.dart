import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/home/controller/home_controller.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  const BottomNavigation({
    required this.selectedIndex,
    required this.onTabTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.08,
        vertical: size.height * 0.02,
      ),
      height: size.height * 0.08,
      decoration: BoxDecoration(
        color: AppStyle.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iconDesign(IconlyBold.home, 0),
          GestureDetector(
            onTap: () {
              HomeController().selectImages();
            },
            child: const Icon(
              Icons.cloud_upload,
              size: 35,
              color: Colors.white,
            ),
          ),
          iconDesign(IconlyBold.profile, 1),
        ],
      ),
    );
  }

  Widget iconDesign(IconData icon, int index) {
    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: AnimatedOpacity(
        opacity: selectedIndex == index ? 1 : 0.5,
        duration: const Duration(milliseconds: 500),
        child: Icon(
          icon,
          size: 35,
          color: Colors.cyan,
        ),
      ),
    );
  }
}
