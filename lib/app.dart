import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/routes/route_name.dart';
import 'package:post_app/screens/login_register_screen/register_screen.dart';
import 'package:post_app/screens/onBoarding.dart/onBoarding_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Doku',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        // initialBinding: GeneralBindings(),
        home: const Scaffold(
          backgroundColor: Color.fromARGB(255, 225, 194, 235),
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ),
        initialRoute: "/home",
        getPages: RouteName.routes);
  }
}
