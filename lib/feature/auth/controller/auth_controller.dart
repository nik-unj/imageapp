import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:imageapp/constant/app_string.dart';
import 'package:imageapp/feature/bottombar/bottom_bar.dart';

class AuthController extends GetxController {
  Rx<FormzSubmissionStatus> loginFormzStatus =
      FormzSubmissionStatus.initial.obs;
  RxString errorMessage = ''.obs;
  var loginFormKey = GlobalKey<FormState>();
  var registerFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  RxBool showPassword = false.obs;

  Future<void> doRegister() async {
    loginFormzStatus.value = FormzSubmissionStatus.inProgress;
    try {
      if (registerFormKey.currentState!.validate()) {
        if (passwordController.text == passwordConfirmController.text) {
          UserCredential userCred =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          emailController.clear();
          passwordController.clear();
          passwordConfirmController.clear();
          errorMessage.value = '';
          FirebaseFirestore.instance
              .collection("Users")
              .doc(userCred.user?.uid)
              .set({'images': []}).then(
            (value) => Get.offAll(
              () => const BottomBarScreen(),
            ),
          );
          loginFormzStatus.value = FormzSubmissionStatus.success;
        } else {
          loginFormzStatus.value = FormzSubmissionStatus.failure;
          errorMessage.value = AppString.samePass;
        }
      } else {
        loginFormzStatus.value = FormzSubmissionStatus.failure;
      }
    } on FirebaseAuthException catch (e) {
      loginFormzStatus.value = FormzSubmissionStatus.failure;
      errorMessage.value = e.message ?? AppString.wentWrong;
    }
  }

  Future<void> doLogin() async {
    loginFormzStatus.value = FormzSubmissionStatus.inProgress;
    try {
      if (loginFormKey.currentState!.validate()) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Get.offAll(() => const BottomBarScreen());
        loginFormzStatus.value = FormzSubmissionStatus.success;
        emailController.clear();
        passwordController.clear();
        passwordConfirmController.clear();
        errorMessage.value = '';
      } else {
        loginFormzStatus.value = FormzSubmissionStatus.failure;
      }
    } on FirebaseAuthException catch (e) {
      loginFormzStatus.value = FormzSubmissionStatus.failure;
      errorMessage.value = e.message ?? AppString.wentWrong;
    }
  }
}
