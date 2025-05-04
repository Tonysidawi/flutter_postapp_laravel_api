import 'package:get/get.dart';
import 'package:post_app/controller/banner_controllers/fetch_banner_controller.dart';
import 'package:post_app/data/info_repository/info_repository.dart';

class DeleteBannerController extends GetxController {
  static DeleteBannerController get instance => Get.find();

  // varibles
  RxBool isLoading = false.obs;

  final _infoRepo = InfoRepository.instance;
  final fetchBannerController = FetchBannerController.instance;

  Future<void> deleteBanner(bannerId) async {
    try {
      isLoading.value = true;

      await _infoRepo.deleteBanner(bannerId);

      await fetchBannerController.fetchAllBanners();

      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }
}
