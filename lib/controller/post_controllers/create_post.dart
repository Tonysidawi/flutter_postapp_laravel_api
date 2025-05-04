import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/banner_controllers/fetch_banner_controller.dart';
import 'package:post_app/data/info_repository/info_repository.dart';

class CreatePostController extends GetxController {
  static CreatePostController get instance => Get.find();

  // varibles
  RxBool isLoading = false.obs;
  final title = TextEditingController();
  final body = TextEditingController();
  final _infoRepo = InfoRepository.instance;
  final fetchBannerController = FetchBannerController.instance;
  GlobalKey<FormState> createPostFormKey = GlobalKey<FormState>();

  Future<void> createPost(userId, bannerId) async {
    try {
      isLoading.value = true;
      print(bannerId);
      print(userId);

      await _infoRepo.createPost(
          title: title.text.trim(),
          body: body.text.trim(),
          userId: userId,
          bannerId: bannerId);
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
    super.onClose();
  }
}
