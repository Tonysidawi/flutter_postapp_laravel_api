import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:post_app/routes/route_name.dart';
import 'package:post_app/screens/login_register_screen/login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Hero image (replace with your actual image asset)
                    SvgPicture.asset(
                      'assets/onboarding_illustration.svg',
                      height: 250,
                    ),
                    SizedBox(height: 40),
                    // Title
                    Text(
                      'Welcome to AppName',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Description
                    Text(
                      'Discover amazing features that will make your life easier and more productive.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              // Get Started Button
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Get.to(LoginScreen());
                      // Get.toNamed("/login");
                      // Get.toNamed(RouteName.getLogin());
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
