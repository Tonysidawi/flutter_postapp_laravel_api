import 'package:flutter/material.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:
          Text('HomePage', style: TextStyle(fontSize: 50, color: Colors.black)),
    );
  }
}
