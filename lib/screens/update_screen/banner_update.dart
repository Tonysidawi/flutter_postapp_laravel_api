import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/banner_controllers/bannerController.dart';
import 'package:post_app/controller/banner_controllers/update_banner.dart';
import 'package:post_app/controller/user_controller/user_controller.dart';
import 'package:post_app/models/bannerModel.dart';

class UpdateBannerPage extends StatelessWidget {
  const UpdateBannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final updateController = Get.put(UpdateBannerController());

    // Get arguments
    final args = Get.arguments;
    final int? bannerId = args?['id'];
    final String? title = args?['title'];
    final String? body = args?['body'];

    updateController.initialBannerData(BannerModel(
      id: bannerId!,
      title: title!,
      body: body!,
      userId: 0,
      posts: [],
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Banner"),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Let’s update your Banner",
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 24),
            Form(
              key: updateController.updateBannerFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: updateController.title,
                    decoration: InputDecoration(
                      labelText: 'Title of your Banner',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: updateController.body,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Description of your banner',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Obx(() => SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () =>
                              updateController.updateBanner(args?['id']),
                          // return to previous page

                          child: updateController.isLoading.value
                              ? CircularProgressIndicator()
                              : Text("Update Banner"),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
