import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/post_controllers/create_post.dart';
import 'package:post_app/controller/user_controller/user_controller.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final postController = Get.put(CreatePostController());
    final userId = userController.user.value.id;

    final arg = Get.arguments;
    final int? bannerId = arg?['banner_id'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // First & last Name
            children: [
              Text(
                "Create a Post",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                key: postController.createPostFormKey,
                child: Column(
                  children: [
                    // First & Last Name
                    TextFormField(
                      controller: postController.title,
                      validator: (value) => null,
                      decoration: InputDecoration(
                        focusColor: Colors.blueAccent,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(15)),
                        labelText: 'Title of your Banner',
                        prefixIcon: const Icon(null),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: postController.body,
                      maxLines: 3,
                      decoration: InputDecoration(
                        focusColor: Colors.blueAccent,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(15)),
                        labelText: 'Desrciption of your banner',
                        prefixIcon: const Icon(null),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),

                    SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () =>
                              postController.createPost(userId, bannerId),
                          child: postController.isLoading.value
                              ? CircularProgressIndicator()
                              : Text('Add Your Post')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
