import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/auth_controllers/login_controller.dart';
import 'package:post_app/screens/login_register_screen/register_screen.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Form(
      key: loginController.loginFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 24,
        ),
        child: Column(
          children: [
            //! Email
            TextFormField(
              controller: loginController.email,
              validator: (value) => null,
              cursorColor: Colors.blueAccent,
              decoration: InputDecoration(
                focusColor: Colors.blueAccent,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15)),
                prefixIcon: const Icon(
                  null,
                ),
                labelText: 'Email',

                // suffixIcon: const Icon(
                //   Iconsax.eye_slash,
                // ),
              ),
            ),
            SizedBox(
              height: 24,
            ),

            Obx(
              () => TextFormField(
                controller: loginController.password,
                obscureText: loginController.hidePassword.value,
                decoration: InputDecoration(
                  focusColor: Colors.blue,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Password',
                  prefixIcon: const Icon(null),
                  suffixIcon: IconButton(
                    onPressed: () => loginController.hidePassword.value =
                        !loginController.hidePassword.value,
                    icon: Icon(loginController.hidePassword.value
                        ? Icons.password
                        : Icons.password_sharp),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 24 / 2,
            ),

            //! Remember me and forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.blueAccent,
                      value: true,
                      onChanged: (value) {},
                    ),
                    // Remember me
                    const Text('Remember Me'),
                  ],
                ),

                //! Forget Password
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forget Password',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24 / 2,
            ),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => loginController.login(),
                  child: loginController.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Sign In',
                        ),
                ),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            //! CREATE ACCOUNT BUTTON

            SizedBox(
              height: 56,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const RegisterScreen()),
                child: const Text(
                  'Create Account',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
