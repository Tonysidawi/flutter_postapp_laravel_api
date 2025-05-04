import 'package:get/get.dart';
import 'package:post_app/data/authentication/authentication_repository.dart';
import 'package:post_app/models/userModel.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final authController = AuthenticationRepository.instance;

  Rx<User> user = User.empty().obs;

  @override
  void onInit() {
    super.onInit();
    initializeUser();
  }

  void initializeUser() {
    user.value = authController.user.value;
  }
}
