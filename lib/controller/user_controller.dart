import 'package:get/get.dart';
import 'package:post_app/data/authentication/authentication_repository.dart';
import 'package:post_app/models/userModel.dart';

class UserController extends GetxController {
  // variable
  final authController = Get.find<AuthenticationRepository>;
  Rx<UserModel> user = UserModel.empty().obs;

  @override
  void onInit() {
    initializeUser();
    super.onInit();
  }

  Future<void> initializeUser() async {
    // final user =authController.user.value;
    // this.user(user);
  }
}
