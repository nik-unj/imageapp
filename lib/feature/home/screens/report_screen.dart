import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/home/controller/home_controller.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyle.primary,
        iconTheme: const IconThemeData(color: AppStyle.white),
        title: Text(
          AppString.reportIssue,
          style: AppStyle.whiteHeading(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: AppStyle.width(context) > 700
                      ? 400
                      : AppStyle.width(context),
                  child: Material(
                    borderRadius: BorderRadius.circular(12),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: homeController.reportFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'Describe the issue',
                              style: AppStyle.primaryHeading(),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: homeController.reportController,
                              keyboardType: TextInputType.emailAddress,
                              maxLines: 7,
                              maxLength: 250,
                              decoration: AppStyle.textFieldPrimary(
                                  hintText: 'Issue...'),
                              style: AppStyle.textFieldStyle(
                                  textColor: const Color.fromRGBO(0, 0, 0, 1)),
                              textAlignVertical: TextAlignVertical.center,
                              cursorColor: AppStyle.primary,
                              validator: (value) {
                                if (value == '') {
                                  return "Required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Include Images',
                              style: AppStyle.primaryHeading(),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                homeController.selectedReportImages =
                                    await ImagePicker().pickMultiImage();
                              },
                              child: Container(
                                width: 130,
                                decoration: BoxDecoration(
                                  color: AppStyle.primary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: AppStyle.primary,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.add,
                                        color: AppStyle.primary,
                                      ),
                                      Text(
                                        "Images",
                                        style: AppStyle.normalText(
                                            textColor: AppStyle.primary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Align(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: GestureDetector(
                                  onTap: () {
                                    homeController.postReport();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: AppStyle.primary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Text(
                                        AppString.submit,
                                        textAlign: TextAlign.center,
                                        style:
                                            AppStyle.whiteHeading(fontSize: 25),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
