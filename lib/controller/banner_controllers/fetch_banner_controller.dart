import 'package:get/get.dart';
import 'package:post_app/data/info_repository/info_repository.dart';
import 'package:post_app/models/bannerModel.dart';

class FetchBannerController extends GetxController {
  static FetchBannerController get instance => Get.find();
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  RxBool isLoading = false.obs;
  final infoRepo = Get.put(InfoRepository());

  @override
  void onInit() {
    fetchAllBanners();
    super.onInit();
  }

  Future<void> fetchAllBanners() async {
    try {
      isLoading.value = true;
      final List<BannerModel> fetchedBanners = await infoRepo.fetchAllBanners();

      // Update the banners list
      banners.assignAll(fetchedBanners);
      isLoading(false);
    } catch (e) {
      isLoading.value = false;
    }
  }
}
