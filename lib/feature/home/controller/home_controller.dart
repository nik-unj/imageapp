import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/home/home_screen.dart';
import 'package:imageapp/feature/home/model/image_model.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final ImagePicker imagePicker = ImagePicker();
  final TextEditingController feedbackController = TextEditingController();
  final TextEditingController reportController = TextEditingController();
  List<XFile> selectedReportImages = [];
  var reportFormKey = GlobalKey<FormState>();
  var feedbackFormKey = GlobalKey<FormState>();

  RxInt selectedIndex = 0.obs;

  void uploadImages(dynamic selectedImages) async {
    try {
      selectedImages.map((file) async {
        var path = File(file.path);
        print(path);
        var imageName = getFileName(path);
        print(imageName);
        file.readAsBytes().then((value) async {
          Reference reference =
              storage.ref().child("${user?.uid}/${imageName.toString()}");
          reference.getMetadata().then((value) {
            Get.snackbar(
              "Error",
              "Image alreay exist",
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(10),
              icon: const Icon(Icons.cancel),
            );
          }, onError: (error) async {
            await reference
                .putString(base64Encode(value),
                    format: PutStringFormat.base64,
                    metadata: SettableMetadata(contentType: 'image/png'))
                .then((p0) async {
              var imageUrl = await reference.getDownloadURL();
              DocumentReference postRef = FirebaseFirestore.instance
                  .collection(AppString.userCollection)
                  .doc(user?.uid);
              String date =
                  DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

              postRef.update({
                'images': FieldValue.arrayUnion([
                  {"name": imageName, "url": imageUrl, "date": date}
                ])
              });
            });
          });
        });
      }).toList();
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  void deleteImage(ImageModel data) async {
    DocumentReference postRef = FirebaseFirestore.instance
        .collection(AppString.userCollection)
        .doc(user?.uid);

    postRef.update({
      'images': FieldValue.arrayRemove([data.toMap()])
    });

    Reference reference = storage.ref().child("${user?.uid}/${data.name}");
    await reference.delete();
  }

  String getFileName(File file) {
    return file.path.split('/').last;
  }

  void selectImages() async {
    try {
      List<XFile> selectedImages = await imagePicker.pickMultiImage();
      // MOBILE
      if (!kIsWeb && selectedImages.isNotEmpty) {
        //show snackbar
        Get.snackbar(
          "Progress",
          "Image is being uploaded",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          icon: const Icon(Icons.hourglass_empty),
        );
        uploadImages(selectedImages);
      }
      // WEB
      else if (kIsWeb && selectedImages.isNotEmpty) {
        Get.snackbar(
          "Progress",
          "Image is being uploaded",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          icon: const Icon(Icons.hourglass_empty),
          maxWidth: 300,
        );
        uploadImages(selectedImages);
      } else {
        Get.snackbar(
          "Info",
          "No image selected",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          icon: const Icon(Icons.hourglass_empty),
        );
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> postReport() async {
    if (reportFormKey.currentState!.validate()) {
      print(selectedReportImages);
      String date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      List<String> imagesName = [];
      if (selectedReportImages.isNotEmpty) {
        selectedReportImages.map((file) async {
          var path = File(file.path);
          var imageName = getFileName(path);
          imagesName.add(imageName);
          print(imagesName);
          await file.readAsBytes().then((value) async {
            Reference reference =
                storage.ref().child("${user?.uid}/${getFileName(path)}");
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
          () => const HomeScreen(),
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

  void postFeedback() {
    if (feedbackFormKey.currentState!.validate()) {
      String date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      FirebaseFirestore.instance
          .collection(AppString.feedbackCollection)
          .doc(Timestamp.now().toDate().toString())
          .set({
        'feedback': {
          'sumarry': reportController.text,
          'date': date,
          'user': user?.email
        }
      }).then((value) {
        Get.offAll(
          () => const HomeScreen(),
        );
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
