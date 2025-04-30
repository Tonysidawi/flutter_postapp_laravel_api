import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(
              100,
            ),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Image(
              width: 24,
              height: 24,
              image: AssetImage('assets/images/facebook_icon.png'),
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(
              100,
            ),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Image(
              width: 24,
              height: 24,
              image: AssetImage('assets/images/google_icon.jpg'),
            ),
          ),
        ),
      ],
    );
  }
}
