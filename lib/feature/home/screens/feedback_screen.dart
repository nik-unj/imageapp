import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/home/controller/home_controller.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyle.primary,
        iconTheme: const IconThemeData(color: AppStyle.white),
        title: Text(
          AppString.feedback,
          style: AppStyle.whiteHeading(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: homeController.feedbackFormKey,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'Share your Experience',
                            style: AppStyle.primaryHeading(),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: homeController.feedbackController,
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 8,
                            maxLength: 250,
                            decoration: AppStyle.textFieldPrimary(
                              hintText: 'My Experience ...',
                            ),
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
                          const SizedBox(height: 30),
                          Align(
                            child: Align(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: GestureDetector(
                                  onTap: () {
                                    homeController.postFeedback();
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
                          ),
                        ],
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
