import 'package:get/get.dart';
import 'package:post_app/screens/create_screen/banner_create_screen.dart';
import 'package:post_app/screens/create_screen/post_create_screen.dart';
import 'package:post_app/screens/homepage_screen.dart';
import 'package:post_app/screens/login_register_screen/login_screen.dart';
import 'package:post_app/screens/login_register_screen/register_screen.dart';
import 'package:post_app/screens/onBoarding.dart/onBoarding_screen.dart';
import 'package:post_app/screens/update_screen/banner_update.dart';
import 'package:post_app/screens/update_screen/post_update.dart';

class RouteName {
  static const String initial = '/home';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String createBanner = '/bannerPage';
  static const String updateBanner = '/updateBannerPage';
  static const String createPost = '/createPostPage';
  static const String updatePost = '/updatePostPage';

  // static String getInitial() => initial;
  // static String getOnBoarding() => onBoarding;
  // static String getLogin() => login;
  // static String getRegister() => register;
  // static String getBanner() => createBanner;
  // static String getUpdateBanner() => updateBanner;

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomepageScreen()),
    GetPage(name: onBoarding, page: () => OnBoardingScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: createBanner, page: () => CreateBannerPage()),
    GetPage(name: updateBanner, page: () => UpdateBannerPage()),
    GetPage(name: createPost, page: () => CreatePostPage()),
    GetPage(name: updatePost, page: () => UpdatePostPage()),
  ];
}
