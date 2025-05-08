import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/banner_controllers/fetch_banner_controller.dart';
import 'package:post_app/data/info_repository/info_repository.dart';
import 'package:post_app/models/bannerModel.dart';
import 'package:post_app/models/postModel.dart';

class UpdatePostController extends GetxController {
  static UpdatePostController get instance => Get.find();

  // variables
  final isLoading = false.obs;
  final title = TextEditingController();
  final body = TextEditingController();
  final _infoRepo = InfoRepository.instance;
  final fetchBannerController = FetchBannerController.instance;
  GlobalKey<FormState> updatePostFormKey = GlobalKey<FormState>();

  void initialPostData(PostModel post) {
    title.text = post.title;
    body.text = post.content;
  }

  Future<void> updatePost(postId, userId, bannerId) async {
    try {
      isLoading.value = true;
      await _infoRepo.updatePost(
          title: title.text.trim(),
          body: body.text.trim(),
          bannerId: bannerId,
          postId: postId,
          userId: userId);

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
    updatePostFormKey = GlobalKey<FormState>(); // Reset the key
    super.onClose();
  }
}
