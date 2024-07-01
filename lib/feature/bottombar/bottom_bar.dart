import 'package:flutter/material.dart';
import 'package:imageapp/feature/bottombar/bottom_navigation.dart';
import 'package:imageapp/feature/home/home_screen.dart';
import 'package:imageapp/feature/profile/profile_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int selectedIndex = 0;
  List widgetList = [const HomeScreen(), const ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widgetList[selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigation(
              selectedIndex: selectedIndex,
              onTabTapped: (p0) {
                setState(() {
                  selectedIndex = p0;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
