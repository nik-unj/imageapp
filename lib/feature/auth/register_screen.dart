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
      body: SafeArea(
        child: Obx(() {
          if (authController.loginFormzStatus.value.isInProgress) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: AppStyle.height(context) * 0.45),
                  const CircularProgressIndicator(
                    color: AppStyle.primary,
                  ),
                  Text(
                    AppString.settingUp,
                    style: AppStyle.primaryHeading(size: 25),
                  )
                ],
              ),
            );
          } else {
            return Form(
              key: authController.registerFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: SizedBox(
                        width: AppStyle.width(context) > 700
                            ? 400
                            : AppStyle.width(context),
                        child: Card(
                          color: AppStyle.primary,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  AppString.register,
                                  style: AppStyle.whiteHeading(fontSize: 25),
                                ),
                                const SizedBox(height: 30),
                                CustomTextField(
                                  controller: authController.emailController,
                                  hintText: "Email",
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller: authController.passwordController,
                                  hintText: "Password",
                                  showPassword:
                                      authController.showPassword.value,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller:
                                      authController.passwordConfirmController,
                                  hintText: "Re-enter Password",
                                  showPassword:
                                      authController.showPassword.value,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: authController.showPassword.value,
                                      onChanged: (value) {
                                        authController.showPassword.value =
                                            !authController.showPassword.value;
                                      },
                                      checkColor: AppStyle.primary,
                                      activeColor: AppStyle.white,
                                      side: const BorderSide(
                                        color: AppStyle.white,
                                      ),
                                    ),
                                    Text(
                                      AppString.showPassword,
                                      style: AppStyle.textFieldStyle()
                                          .copyWith(color: AppStyle.white),
                                    )
                                  ],
                                ),
                                authController.errorMessage.isEmpty
                                    ? const Text("")
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${AppString.alreadyUser} ',
                                      style: AppStyle.normalText(),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        authController.emailController.clear();
                                        authController.passwordConfirmController
                                            .clear();
                                        authController.passwordController
                                            .clear();
                                        authController.errorMessage.value = '';
                                        Get.offAll(() => const LoginScreen());
                                      },
                                      child: Text(
                                        AppString.login,
                                        style: AppStyle.normalText().copyWith(
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppStyle.white,
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
                  )
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
