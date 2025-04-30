import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/register_controller.dart';
import 'package:post_app/screens/login_register_screen/widgets/social_buttons.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());
    return Form(
        key: registerController.regiterFormKey,
        child: Column(children: [
          // First & Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: registerController.firstName,
                  validator: (value) => null,
                  decoration: InputDecoration(
                    focusColor: Colors.blueAccent,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Frist Name',
                    prefixIcon: const Icon(null),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextFormField(
                  controller: registerController.lastName,
                  decoration: InputDecoration(
                    focusColor: Colors.blueAccent,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Last Name',
                    prefixIcon: const Icon(null),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 24,
          ),

          SizedBox(
            height: 24,
          ),

          // Email
          TextFormField(
            controller: registerController.email,
            decoration: InputDecoration(
              focusColor: Colors.blueAccent,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(15)),
              labelText: 'E-mail',
              prefixIcon: const Icon(Icons.email_outlined),
            ),
          ),
          SizedBox(
            height: 24,
          ),

          // Phone Number
          TextFormField(
            controller: registerController.phoneNumber,
            decoration: InputDecoration(
              focusColor: Colors.blueAccent,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(15)),
              labelText: 'Phone Number',
              suffixIcon: const Icon(Icons.text_snippet),
              prefixIcon: const Icon(Icons.numbers),
            ),
          ),
          SizedBox(
            height: 24,
          ),

          // Password

          Obx(
            () => TextFormField(
              controller: registerController.password,
              obscureText: registerController.hidePassword.value,
              decoration: InputDecoration(
                focusColor: Colors.blueAccent,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15)),
                labelText: 'Password',
                prefixIcon: const Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                  onPressed: () => registerController.hidePassword.value =
                      !registerController.hidePassword.value,
                  icon: registerController.hidePassword.value
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Obx(
            () => TextFormField(
              controller: registerController.confirmPassword,
              obscureText: registerController.hidePassword2.value,
              decoration: InputDecoration(
                focusColor: Colors.blueAccent,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15)),
                labelText: 'confirm Password',
                prefixIcon: const Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                  onPressed: () => registerController.hidePassword2.value =
                      !registerController.hidePassword2.value,
                  icon: registerController.hidePassword2.value
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              ),
            ),
          ),

          // Terms&Conditions Checkbox

          SizedBox(
            height: 24,
          ),

          //  Sign Up Button

          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => registerController.register(),
                child: registerController.isLoading.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'create account',
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 16,
          ),
          const SocialButton(),
        ]));
  }
}
