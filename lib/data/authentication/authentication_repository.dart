import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:post_app/models/userModel.dart';
import 'package:post_app/routes/route_name.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final token = ''.obs;
  Rx<User> user = User.empty().obs;

  @override
  void onReady() {
    // Remove the native splash screen

    // Redirect to the appropriate screen
    screenRedirect();
  }

  void screenRedirect() async {
    final storedtoken = deviceStorage.read('bearer_token');
    if (storedtoken != null) {
      token.value = storedtoken;
      Get.offAllNamed(RouteName.initial);
    } else {
      deviceStorage.read('first_time') != true
          ? Get.offAllNamed(RouteName.onBoarding)
          : Get.offAllNamed(RouteName.login);
      deviceStorage.write('first_time', true);
    }
    FlutterNativeSplash.remove();
  }

  // Login
  Future<void> authLogin({
    required String email,
    required String password,
  }) async {
    var data = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userData = responseData['user'];
        user.value = User.fromJson(userData);
        token.value = responseData['access_token'];
        print(token.value);
        deviceStorage.write('bearer_token', token.value);

        Get.toNamed(RouteName.initial);

        if (responseData['success'] == true) {
          Get.snackbar('Congratulations', 'Your are logged in successfully',
              colorText: Colors.white, backgroundColor: Colors.green);
        }

        // print('Login successful: $responseData');
        // You can handle token storage or navigation here
      } else if (response.statusCode == 401) {
        final errorData = json.decode(response.body);
        Get.snackbar('Error', 'Login failed: ${errorData['message']}',
            colorText: Colors.white, backgroundColor: Colors.redAccent);
      } else {
        final errorData = json.decode(response.body);
        Get.snackbar('Error', 'Login failed: ${errorData['message']}',
            colorText: Colors.white, backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      // print('An error occurred: $e');
    }
  }

  // register new user
  Future<void> authRegister({
    required String firtsName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    var data = {
      'first_name': firtsName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/register'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json', // Important!
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('Register successful: $responseData');
      await authLogin(email: email, password: password);
      // You can handle token storage or navigation here
    } else {
      final errorData = json.decode(response.body);
      print('Register failed: ${errorData['message']}');
    }
  }

  Future<void> logout() async {
    deviceStorage.remove('bearer_token');
    Get.offAllNamed(RouteName.login);
  }
}
