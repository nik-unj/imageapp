import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/auth/login_screen.dart';
import 'package:imageapp/feature/home/controller/home_controller.dart';
import 'package:imageapp/feature/feedback/feedback_screen.dart';
import 'package:imageapp/feature/report/report_screen.dart';
import 'package:imageapp/feature/profile/widget/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'asset/images/bg3.jpg',
            height: AppStyle.height(context),
            width: AppStyle.width(context),
            fit: BoxFit.fill,
            filterQuality: FilterQuality.low,
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'asset/images/bg5.jpg',
                            height: AppStyle.height(context) / 3,
                            width: AppStyle.width(context),
                            fit: BoxFit.fill,
                            filterQuality: FilterQuality.low,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 30,
                        ),
                        child: Column(
                          children: [
                            Text(
                              AppString.userInfo,
                              style: AppStyle.headingBlack(size: 25),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                Text(
                                  "${AppString.email}: ",
                                  style: AppStyle.normalText(),
                                ),
                                Text(
                                  homeController.user?.email ?? 'N/A',
                                  style: AppStyle.normalText()
                                      .copyWith(color: AppStyle.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "${AppString.userName}: ",
                                  style: AppStyle.normalText(),
                                ),
                                Text(
                                  homeController.user?.displayName ?? 'N/A',
                                  style: AppStyle.normalText()
                                      .copyWith(color: AppStyle.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "${AppString.totalImages}: ",
                                  style: AppStyle.normalText(),
                                ),
                                Text(
                                  homeController.user?.displayName ?? 'N/A',
                                  style: AppStyle.normalText()
                                      .copyWith(color: AppStyle.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ProfileTile(
                  onTap: () {
                    Get.to(() => const ReportScreen());
                  },
                  name: AppString.reportIssue,
                  icon: const Icon(Icons.bug_report_outlined),
                ),
                ProfileTile(
                  onTap: () {
                    Get.to(() => const FeedbackScreen());
                  },
                  name: AppString.feedback,
                  icon: const Icon(Icons.feedback_outlined),
                ),
                ProfileTile(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Get.offAll(() => const LoginScreen());
                  },
                  name: AppString.logout,
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
