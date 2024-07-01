import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/auth/widget/custom_button.dart';
import 'package:imageapp/feature/auth/widget/custom_textfield.dart';
import 'package:imageapp/feature/report/controller/report_controller.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());
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
          Form(
            key: controller.reportFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: SizedBox(
                      width: AppStyle.width(context),
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppStyle.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    AppString.reportIssue,
                                    style: AppStyle.headingBlack(size: 30),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: controller.reportController,
                                    hintText: AppString.describeIssue,
                                    maxLines: 5,
                                    maxLength: 250,
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () async {
                                        controller.selectedReportImages =
                                            await ImagePicker()
                                                .pickMultiImage();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppStyle.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                            color: AppStyle.black,
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.add,
                                                color: AppStyle.black,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6.0),
                                                child: Text(
                                                  AppString.addImage,
                                                  style: AppStyle.normalText(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomButton(
                                    name: AppString.submit,
                                    onTap: () {
                                      controller.postReport();
                                    },
                                    width: AppStyle.width(context) / 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          appBar(),
        ],
      ),
    );
  }

  Widget appBar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: AppStyle.white.withOpacity(0.4),
          padding: const EdgeInsets.only(top: 20, left: 5),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppStyle.black,
                ),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
