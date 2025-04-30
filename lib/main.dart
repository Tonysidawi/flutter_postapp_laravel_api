import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:post_app/app.dart';

import 'data/authentication/authentication_repository.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

// GetX Local Storage
  await GetStorage.init();

// Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

// Initialize the API client or other services

  Get.put(AuthenticationRepository());

  runApp(const App());
}
