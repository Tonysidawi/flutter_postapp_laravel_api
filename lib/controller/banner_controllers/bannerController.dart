import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/banner_controllers/fetch_banner_controller.dart';
import 'package:post_app/data/info_repository/info_repository.dart';
import 'package:post_app/models/bannerModel.dart';

class CreateBannerController extends GetxController {
  static CreateBannerController get instance => Get.find();

  // varibles
  RxBool isLoading = false.obs;
  final title = TextEditingController();
  final body = TextEditingController();
  final _infoRepo = InfoRepository.instance;
  final fetchBannerController = FetchBannerController.instance;
  GlobalKey<FormState> createBannerFormKey = GlobalKey<FormState>();

  Future<void> createBanner(userId) async {
    try {
      isLoading.value = true;

      await _infoRepo.createBanner(
          title: title.text.trim(), body: body.text.trim(), userId: userId);
      await fetchBannerController.fetchAllBanners();

      isLoading.value = false;
    } catch (err) {
      isLoading.value = false;
      throw Exception(err);
    }
  }

  @override
  void onClose() {
    title.dispose();
    body.dispose();
    createBannerFormKey = GlobalKey<FormState>(); // Reset the key
    super.onClose();
  }
}
