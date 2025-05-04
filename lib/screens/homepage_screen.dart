import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/banner_controllers/bannerController.dart';
import 'package:post_app/controller/banner_controllers/delete_banner.dart';
import 'package:post_app/controller/banner_controllers/fetch_banner_controller.dart';
import 'package:post_app/controller/auth_controllers/logout_controller.dart';
import 'package:post_app/controller/post_controllers/delete_post.dart';
import 'package:post_app/controller/user_controller/user_controller.dart';
import 'package:post_app/routes/route_name.dart';
import 'package:post_app/screens/update_screen/banner_update.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logoutController = Get.put(LogoutController());
    final bannerController = Get.put(FetchBannerController());
    final userController = Get.put(UserController());
    final deleteBannerController = Get.put(DeleteBannerController());
    final deletePostController = Get.put(DeletePostController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(() =>
            Text('Welcome ${userController.user.value.capitalisedFirstName}')),
        actions: [
          Obx(
            () => IconButton(
              icon: bannerController.isLoading.value
                  ? Icon(Icons.get_app)
                  : const Icon(Icons.refresh),
              onPressed: () => bannerController.fetchAllBanners(),
            ),
          ),
          Obx(
            () => IconButton(
              icon: logoutController.isLoading.value
                  ? CircularProgressIndicator()
                  : const Icon(Icons.logout),
              onPressed: () => logoutController.logout(),
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (bannerController.isLoading.value) {
            return Center(child: const CircularProgressIndicator());
          } else if (bannerController.banners.isEmpty) {
            return Text('there is no Banners available, Please create one');
          } else {
            return PageView.builder(
              itemCount: bannerController.banners.length,
              itemBuilder: (context, index) {
                final banner = bannerController.banners[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner section
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    banner.title,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => deleteBannerController
                                            .deleteBanner(banner.id),
                                        icon: Icon(Icons.delete),
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
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                banner.body,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Posts/comments under the banner
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Posts:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () =>
                                  Get.toNamed(RouteName.createPost, arguments: {
                                    'banner_id': banner.id,
                                  }),
                              icon: Icon(Icons.comment))
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: ListView.builder(
                        itemCount: banner.posts!.length,
                        itemBuilder: (context, commentIndex) {
                          final post = banner.posts![commentIndex];
                          return ListTile(
                            title: Text(
                                '${post.user.capitalisedFirstName} ${post.user.capitalisedLastName}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.title,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(post.content),
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () =>
                                    deletePostController.deletePost(post.id),
                                icon: Icon(Icons.delete)),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteName.createBanner),
        child: Icon(Icons.add),
      ),
    );
  }
}
