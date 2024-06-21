import 'package:flutter/material.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/home/screens/home_screen_mobile.dart';
import 'package:imageapp/feature/home/screens/home_screen_web.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: AppStyle.width(context) > 700
            ? const HomeScreenWeb()
            : const HomeScreenMobile(),
      ),
    );
  }
}
