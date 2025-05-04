import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/banner_controllers/fetch_banner_controller.dart';
import 'package:post_app/data/info_repository/info_repository.dart';
import 'package:post_app/models/bannerModel.dart';

class UpdateBannerController extends GetxController {
  static UpdateBannerController get instance => Get.find();

  // variables
  final isLoading = false.obs;
  final title = TextEditingController();
  final body = TextEditingController();
  final _infoRepo = InfoRepository.instance;
  final fetchBannerController = FetchBannerController.instance;
  GlobalKey<FormState> updateBannerFormKey = GlobalKey<FormState>();

  void initialBannerData(BannerModel banner) {
    title.text = banner.title;
    body.text = banner.body;
  }

  Future<void> updateBanner(bannerId) async {
    try {
      isLoading.value = true;
      await _infoRepo.updateBanner(
          title: title.text.trim(), body: body.text.trim(), bannerId: bannerId);

      await fetchBannerController.fetchAllBanners();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onClose() {
    title.dispose();
    body.dispose();
    updateBannerFormKey = GlobalKey<FormState>(); // Reset the key
    super.onClose();
  }
}
