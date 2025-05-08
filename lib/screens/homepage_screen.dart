import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/banner_controllers/delete_banner.dart';
import 'package:post_app/controller/banner_controllers/fetch_banner_controller.dart';
import 'package:post_app/controller/auth_controllers/logout_controller.dart';
import 'package:post_app/controller/post_controllers/delete_post.dart';
import 'package:post_app/controller/user_controller/user_controller.dart';
import 'package:post_app/routes/route_name.dart';

class HomepageScreen extends StatelessWidget {
  HomepageScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final logoutController = Get.put(LogoutController());
    final bannerController = Get.put(FetchBannerController());
    final userController = Get.put(UserController());
    final deleteBannerController = Get.put(DeleteBannerController());
    final deletePostController = Get.put(DeletePostController());

    _pageController.addListener(() {
      final currentPage = _pageController.page?.round() ?? 0;
      bannerController.updateCurrentPage(currentPage);
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(() =>
            Text('Welcome ${userController.user.value.capitalisedFirstName}')),
        actions: [
          Obx(() => IconButton(
                icon: bannerController.isLoading.value
                    ? Icon(Icons.get_app)
                    : const Icon(Icons.refresh),
                onPressed: () => bannerController.fetchAllBanners(),
              )),
          Obx(() => IconButton(
                icon: logoutController.isLoading.value
                    ? CircularProgressIndicator()
                    : const Icon(Icons.logout),
                onPressed: () => logoutController.logout(),
              )),
        ],
      ),
      body: Obx(() {
        if (bannerController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (bannerController.banners.isEmpty) {
          return const Center(
              child: Text('There are no Banners available, Please create one'));
        } else {
          return PageView.builder(
            controller: _pageController,
            itemCount: bannerController.banners.length,
            itemBuilder: (context, index) {
              final banner = bannerController.banners[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    banner.title,
                                    maxLines: 3,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                userController.user.value.id == banner.userId
                                    ? Row(
                                        children: [
                                          IconButton(
                                            onPressed: () =>
                                                deleteBannerController
                                                    .deleteBanner(banner.id),
                                            icon: const Icon(Icons.delete),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.update),
                                            onPressed: () => Get.toNamed(
                                              RouteName.updateBanner,
                                              arguments: {
                                                'id': banner.id,
                                                'title': banner.title,
                                                'body': banner.body,
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(banner.body),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Obx(() {
                      final current = bannerController.currentPage.value + 1;
                      final total = bannerController.banners.length;
                      return Center(child: Text('Page $current of $total'));
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Posts:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () =>
                              Get.toNamed(RouteName.createPost, arguments: {
                            'banner_id': banner.id,
                          }),
                          icon: const Icon(Icons.comment),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      itemCount: banner.posts.length ?? 0,
                      itemBuilder: (context, commentIndex) {
                        final post = banner.posts![commentIndex];
                        return ListTile(
                          title: Text(
                              '${post.user!.capitalisedFirstName} ${post.user!.capitalisedLastName}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  )),
                              Text(post.content),
                            ],
                          ),
                          trailing: userController.user.value.id == post.userId
                              ? SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => deletePostController
                                            .deletePost(post.id),
                                        icon: deletePostController
                                                .isLoading.value
                                            ? const CircularProgressIndicator()
                                            : const Icon(Icons.delete),
                                      ),
                                      IconButton(
                                        onPressed: () => Get.toNamed(
                                            RouteName.updatePost,
                                            arguments: {
                                              'post_id': post.id,
                                              'banner_id': banner.id,
                                              'title': post.title,
                                              'body': post.content,
                                            }),
                                        icon: const Icon(
                                            Icons.system_security_update),
                                      ),
                                    ],
                                  ),
                                )
                              : null,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteName.createBanner),
        child: const Icon(Icons.add),
      ),
    );
  }
}
