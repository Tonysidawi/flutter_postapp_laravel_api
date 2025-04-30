import 'package:get/get.dart';
import 'package:post_app/screens/homepage_screen.dart';
import 'package:post_app/screens/login_register_screen/login_screen.dart';
import 'package:post_app/screens/login_register_screen/register_screen.dart';
import 'package:post_app/screens/onBoarding.dart/onBoarding_screen.dart';

class RouteName {
  static const String initial = '/home';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String register = '/register';

  static String getInitial() => initial;
  static String getOnBoarding() => onBoarding;
  static String getLogin() => login;
  static String getRegister() => register;

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomepageScreen()),
    GetPage(name: onBoarding, page: () => OnBoardingScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
  ];
}
