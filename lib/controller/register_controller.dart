import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/data/authentication/authentication_repository.dart';
import 'package:post_app/models/userModel.dart';

class RegisterController extends GetxController {
  // variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final isLoading = false.obs;
  final hidePassword = true.obs;
  final hidePassword2 = true.obs;

  final authController = Get.find<AuthenticationRepository>();
  GlobalKey<FormState> regiterFormKey = GlobalKey<FormState>();

  Future<void> register() async {
    try {
      isLoading.value = true;
      await authController.authRegister(
        firtsName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        email: email.text.trim(),
        password: password.text.trim(),
        confirmPassword: confirmPassword.text.trim(),
      );
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }
}
