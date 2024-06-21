import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/auth/login_screen.dart';
import 'package:imageapp/feature/home/controller/home_controller.dart';
import 'package:imageapp/feature/home/model/image_model.dart';
import 'package:imageapp/feature/home/screens/feedback_screen.dart';
import 'package:imageapp/feature/home/screens/image_screen_mobile.dart';
import 'package:imageapp/feature/home/screens/report_screen.dart';
import 'package:imageapp/feature/home/widgets/custom_network_image.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppStyle.primary,
        title: Text(
          AppString.appname,
          style: AppStyle.whiteHeading(fontSize: 25),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: drawer(),
      floatingActionButton: GestureDetector(
        onTap: () {
          homeController.selectImages();
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppStyle.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.add,
            color: AppStyle.white,
            size: 30,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(AppString.userCollection)
            .doc(homeController.user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            if (snapshot.data!.data()!['images'].length == 0) {
              return Center(
                child: Text(
                  AppString.noImages,
                  style: AppStyle.primaryHeading(size: 25),
                ),
              );
            } else {
              List<dynamic> imagesList = snapshot.data!
                  .data()!['images']
                  .map((image) => ImageModel.fromMap(image))
                  .toList();
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 5 / 5,
                ),
                itemCount: snapshot.data!.data()!['images'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2),
                    child: GestureDetector(
                      onLongPress: () {
                        showAlertDialog(context, index, imagesList);
                      },
                      onTap: () {
                        homeController.selectedIndex.value = index;
                        Get.to(() => ImageScreenMobile(
                              imagesList: imagesList,
                            ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CustomNetworkImage(url: imagesList[index].url),
                      ),
                    ),
                  );
                },
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppStyle.primary,
              ),
            );
          }
          return Text('Error ${snapshot.error}');
        },
      ),
    );
  }

  showAlertDialog(BuildContext context, int index, List imagesList) {
    Widget cancelButton = GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Text(
        "Cancel",
        style: AppStyle.normalText().copyWith(
          color: AppStyle.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
    Widget deleteButton = GestureDetector(
      onTap: () {
        Get.back();
        homeController.deleteImage(imagesList[index]);
      },
      child: Text(
        "Delete",
        style: AppStyle.normalText().copyWith(
          color: AppStyle.error,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "Delete Image",
        style: AppStyle.headingBlack(),
      ),
      content: Text(
        "Are you sure you to delete the image",
        style: AppStyle.normalText().copyWith(color: AppStyle.black),
      ),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget drawer() {
    return Drawer(
      backgroundColor: AppStyle.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppStyle.primary,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: AppStyle.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const Icon(
                  Icons.email,
                  size: 25,
                  color: AppStyle.black,
                ),
                const SizedBox(width: 5),
                Text(
                  "${AppString.email}: ",
                  style: AppStyle.headingBlack(size: 15),
                ),
                Text(
                  homeController.user?.email ?? 'N/A',
                  style: AppStyle.normalText().copyWith(color: AppStyle.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(
                  Icons.account_box,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  "${AppString.userName}: ",
                  style: AppStyle.headingBlack(size: 15),
                ),
                Text(
                  homeController.user?.displayName ?? 'N/A',
                  style: AppStyle.normalText().copyWith(color: AppStyle.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.to(() => const ReportScreen());
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.bug_report,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    AppString.reportIssue,
                    style: AppStyle.headingBlack(size: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.to(() => const FeedbackScreen());
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.feedback,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    AppString.feedback,
                    style: AppStyle.headingBlack(size: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.offAll(() => const LoginScreen());
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.logout,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    AppString.logout,
                    style: AppStyle.headingBlack(size: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
