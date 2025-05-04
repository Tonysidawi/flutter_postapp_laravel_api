import 'package:get/get.dart';
import 'package:post_app/controller/banner_controllers/fetch_banner_controller.dart';
import 'package:post_app/data/info_repository/info_repository.dart';

class DeletePostController extends GetxController {
  static DeletePostController get instance => Get.find();

  // varibles
  RxBool isLoading = false.obs;

  final _infoRepo = InfoRepository.instance;
  final fetchBannerController = FetchBannerController.instance;

  Future<void> deletePost(postId) async {
    try {
      isLoading.value = true;

      print(postId);

      await _infoRepo.deletePost(postId);

      await fetchBannerController.fetchAllBanners();

      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }
}
