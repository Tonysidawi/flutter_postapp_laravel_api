import 'package:get/get.dart';
import 'package:post_app/data/authentication/authentication_repository.dart';

class LogoutController extends GetxController {
  // variables
  final authController = Get.find<AuthenticationRepository>();
  final isLoading = false.obs;

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await authController.logout();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
