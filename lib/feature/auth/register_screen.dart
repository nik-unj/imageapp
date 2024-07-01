import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/constant/app_style.dart';
import 'package:imageapp/feature/auth/controller/auth_controller.dart';
import 'package:imageapp/feature/auth/login_screen.dart';
import 'package:imageapp/feature/auth/widget/custom_button.dart';
import 'package:imageapp/feature/auth/widget/custom_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: AppStyle.white,
      body: Obx(() {
        if (authController.loginFormzStatus.value.isInProgress) {
          return Center(
            child: Column(
              children: [
                SizedBox(height: AppStyle.height(context) * 0.45),
                const CircularProgressIndicator(
                  color: AppStyle.black,
                ),
                const SizedBox(height: 10),
                Text(
                  AppString.settingUp,
                  style: AppStyle.headingBlack(size: 25),
                )
              ],
            ),
          );
        } else {
          return Stack(
            children: [
              Image.asset(
                'asset/images/bg4.jpg',
                height: AppStyle.height(context),
                width: AppStyle.width(context),
                fit: BoxFit.fill,
              ),
              Form(
                key: authController.registerFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  color: AppStyle.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        AppString.register,
                                        style: AppStyle.headingBlack(size: 40),
                                      ),
                                      const SizedBox(height: 30),
                                      CustomTextField(
                                        controller:
                                            authController.emailController,
                                        hintText: "Email",
                                      ),
                                      const SizedBox(height: 10),
                                      CustomTextField(
                                        controller:
                                            authController.passwordController,
                                        hintText: "Password",
                                        showPassword:
                                            authController.showPassword.value,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 10),
                                      CustomTextField(
                                        controller: authController
                                            .passwordConfirmController,
                                        hintText: "Re-enter Password",
                                        showPassword:
                                            authController.showPassword.value,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: authController
                                                .showPassword.value,
                                            onChanged: (value) {
                                              authController
                                                      .showPassword.value =
                                                  !authController
                                                      .showPassword.value;
                                            },
                                            checkColor: AppStyle.white,
                                            activeColor: AppStyle.black,
                                            side: const BorderSide(
                                              color: AppStyle.black,
                                              width: 2,
                                            ),
                                          ),
                                          Text(
                                            AppString.showPassword,
                                            style: AppStyle.textFieldStyle(),
                                          )
                                        ],
                                      ),
                                      authController.errorMessage.isEmpty
                                          ? Container()
                                          : Text(
                                              authController.errorMessage.value,
                                              style: AppStyle.errorText(),
                                            ),
                                      const SizedBox(height: 10),
                                      CustomButton(
                                        name: AppString.register,
                                        onTap: () {
                                          authController.doRegister();
                                        },
                                        width: AppStyle.width(context) / 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${AppString.alreadyUser} ',
                                            style: AppStyle.normalText(),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              authController.emailController
                                                  .clear();
                                              authController
                                                  .passwordConfirmController
                                                  .clear();
                                              authController.passwordController
                                                  .clear();
                                              authController
                                                  .errorMessage.value = '';
                                              Get.offAll(
                                                  () => const LoginScreen());
                                            },
                                            child: Text(
                                              AppString.login,
                                              style: AppStyle.normalText()
                                                  .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
            ],
          );
        }
      }),
    );
  }
}
