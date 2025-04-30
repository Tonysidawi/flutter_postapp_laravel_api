import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:post_app/models/userModel.dart';
import 'package:post_app/routes/route_name.dart';
import 'package:post_app/screens/homepage_screen.dart';

import 'package:post_app/screens/login_register_screen/login_screen.dart';
import 'package:post_app/screens/onBoarding.dart/onBoarding_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final token = ''.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final email = ''.obs;
  final password = ''.obs;

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
      Get.offAllNamed(RouteName.getInitial());
    } else {
      deviceStorage.read('first_time') != true
          ? Get.offAllNamed(RouteName.getOnBoarding())
          : Get.offAllNamed(RouteName.getLogin());
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
          'Content-Type': 'application/json', // Important!
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userData = responseData['user'];
        user.value = UserModel.fromJson(userData);
        token.value = responseData['token'];
        deviceStorage.write('bearer_token', token.value);

        Get.toNamed(RouteName.getInitial());

        print('Login successful: $responseData');
        // You can handle token storage or navigation here
      } else {
        final errorData = json.decode(response.body);
        print('Login failed: ${errorData['message']}');
      }
    } catch (e) {
      print('An error occurred: $e');
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
      // You can handle token storage or navigation here
    } else {
      final errorData = json.decode(response.body);
      print('Register failed: ${errorData['message']}');
    }
  }
}
