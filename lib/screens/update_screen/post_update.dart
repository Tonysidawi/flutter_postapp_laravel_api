import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/banner_controllers/bannerController.dart';
import 'package:post_app/controller/banner_controllers/update_banner.dart';
import 'package:post_app/controller/post_controllers/update_post.dart';
import 'package:post_app/controller/user_controller/user_controller.dart';
import 'package:post_app/models/bannerModel.dart';
import 'package:post_app/models/postModel.dart';

class UpdatePostPage extends StatelessWidget {
  const UpdatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final updatePostController = Get.put(UpdatePostController());

    // Get arguments
    final args = Get.arguments;
    final int? bannerId = args?['banner_id'];
    final int? postId = args?['post_id'];
    final String? title = args?['title'];
    final String? body = args?['body'];
    final userId = UserController.instance.user.value.id;

    updatePostController.initialPostData(
      PostModel(
        id: bannerId!,
        title: title!,
        content: body!,
        userId: 0,
        bannerId: 0,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Post"),
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
            Text("Let’s update your Post",
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 24),
            Form(
              key: updatePostController.updatePostFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: updatePostController.title,
                    decoration: InputDecoration(
                      labelText: 'Title of your Banner',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: updatePostController.body,
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
                          onPressed: () => updatePostController.updatePost(
                              postId, userId, bannerId),
                          // return to previous page

                          child: updatePostController.isLoading.value
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
