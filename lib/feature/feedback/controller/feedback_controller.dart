import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/bottombar/bottom_bar.dart';
import 'package:intl/intl.dart';

class FeedbackController extends GetxController {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController feedbackController = TextEditingController();
  var feedbackFormKey = GlobalKey<FormState>();

  void postFeedback() {
    if (feedbackFormKey.currentState!.validate()) {
      String date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      FirebaseFirestore.instance
          .collection(AppString.feedbackCollection)
          .doc(Timestamp.now().toDate().toString())
          .set({
        'feedback': {
          'sumarry': feedbackController.text,
          'date': date,
          'user': user?.email
        }
      }).then((value) {
        Get.offAll(() => const BottomBarScreen());
        Get.snackbar(
          "Sucess",
          "Thanks for the feedback",
          colorText: AppStyle.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          icon: const Icon(
            Icons.check_circle,
            color: AppStyle.white,
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: AppStyle.success,
        );
      });
    }
  }
}
