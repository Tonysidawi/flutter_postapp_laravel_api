import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:post_app/data/authentication/authentication_repository.dart';

class LoginController extends GetxController {
  // variables
  final isLoading = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final authController = Get.find<AuthenticationRepository>();

  @override
  void onInit() {
    email.text = localStorage.read('remember_my_email') ?? '';
    password.text = localStorage.read('remember_my_password') ?? '';
    super.onInit();
  }

  Future<void> login() async {
    try {
      isLoading.value = true;

      if (rememberMe.value) {
        localStorage.write('remember_my_email', email.text.trim());
        localStorage.write('remember_my_password', password.text.trim());
      }
      await authController.authLogin(
          email: email.text.trim(), password: password.text.trim());
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
