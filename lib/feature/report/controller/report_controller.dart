import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/bottombar/bottom_bar.dart';
import 'package:imageapp/feature/home/controller/home_controller.dart';
import 'package:intl/intl.dart';

class ReportController extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final ImagePicker imagePicker = ImagePicker();
  final TextEditingController reportController = TextEditingController();
  List<XFile> selectedReportImages = [];
  var reportFormKey = GlobalKey<FormState>();

  Future<void> postReport() async {
    if (reportFormKey.currentState!.validate()) {
      String date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      List<String> imagesName = [];
      if (selectedReportImages.isNotEmpty) {
        selectedReportImages.map((file) async {
          var path = File(file.path);
          var imageName = HomeController().getFileName(path);
          imagesName.add(imageName);
          await file.readAsBytes().then((value) async {
            Reference reference =
                storage.ref().child("${user?.uid}/$imageName");
            reference.putString(base64Encode(value),
                format: PutStringFormat.base64,
                metadata: SettableMetadata(contentType: 'image/png'));
          });
        }).toList();
      }

      FirebaseFirestore.instance
          .collection(AppString.reportCollection)
          .doc(Timestamp.now().toDate().toString())
          .set({
        'report': {
          'sumarry': reportController.text,
          'date': date,
          'user': user?.email,
          'image': imagesName,
        }
      }).then((value) {
        Get.offAll(
          () => const BottomBarScreen(),
        );
        Get.snackbar(
          "Sucess",
          "Reported Successfully",
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
