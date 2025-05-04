import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/data/authentication/authentication_repository.dart';

class LoginController extends GetxController {
  // variables
  final isLoading = false.obs;
  final email = TextEditingController();
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final authController =
      Get.find<AuthenticationRepository>(); //AuthenticationRepository();

  Future<void> login() async {
    try {
      isLoading.value = true;
      await authController.authLogin(
          email: email.text.trim(), password: password.text.trim());
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
