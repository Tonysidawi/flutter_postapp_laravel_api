import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_app/controller/banner_controllers/bannerController.dart';
import 'package:post_app/controller/user_controller/user_controller.dart';

class CreateBannerPage extends StatelessWidget {
  const CreateBannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final bannerController = Get.put(CreateBannerController());
    final userId = userController.user.value.id;
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
                "Let’s create your Banner",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                key: bannerController.createBannerFormKey,
                child: Column(
                  children: [
                    // First & Last Name
                    TextFormField(
                      controller: bannerController.title,
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
                      controller: bannerController.body,
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

                    Obx(
                      () => SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () =>
                                bannerController.createBanner(userId),
                            child: bannerController.isLoading.value
                                ? CircularProgressIndicator()
                                : const Text(
                                    'Add Your Banner',
                                  )),
                      ),
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
