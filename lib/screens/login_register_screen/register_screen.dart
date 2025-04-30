import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/screens/login_register_screen/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // First & last Name
            children: [
              Text(
                "Let’s create your account",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 24,
              ),
              const RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
