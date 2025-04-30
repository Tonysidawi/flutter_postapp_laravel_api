import 'package:flutter/material.dart';
import 'package:post_app/screens/login_register_screen/widgets/login_form.dart';
import 'package:post_app/screens/login_register_screen/widgets/social_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          children: [
            //! Logo
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                  height: 150,
                  image: AssetImage(
                    'assets/images/flutter_logo.png',
                  ),
                ),
                Text(
                  'Welcome To Post App',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Create Posts and comment on them',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                //! Form
                const LogInForm(),

                //! Divider

                SizedBox(
                  height: 24,
                ),

                // Footer
                const SocialButton()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
