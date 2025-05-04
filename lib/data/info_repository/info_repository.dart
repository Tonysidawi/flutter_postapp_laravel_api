import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:post_app/models/bannerModel.dart';

class InfoRepository extends GetxController {
  static InfoRepository get instance => Get.find();
  // varianles
  final localstorage = GetStorage();

  Future<List<BannerModel>> fetchAllBanners() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/banners/'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> bannerData = responseData['data'];
        print(bannerData);
        final List<BannerModel> banners =
            bannerData.map((e) => BannerModel.fromJson(e)).toList();
        return banners;
      } else {
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch banners: $e');
    }
  }

  Future<void> createBanner(
      {required String title,
      required String body,
      required int userId}) async {
    try {
      final token = localstorage.read('bearer_token');
      print('this is the token: $token');
      var data = {
        'title': title,
        'body': body,
        'user_id': userId,
      };
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/banners'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        print("Banner created: $responseBody");

        Get.toNamed('/home');
      } else if (response.statusCode == 401) {
        final responseBody = json.decode(response.body);
        print('error:response $responseBody');
      } else {
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch banners: $e');
    }
  }

  Future<void> deleteBanner(int bannerId) async {
    try {
      final token = localstorage.read('bearer_token');
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/api/banners/$bannerId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        // print(responseBody);
      } else {
        final responseBody = json.decode(response.body);
        // print(responseBody);
      }
    } catch (e) {
      throw Exception('Failed to fetch banners: $e');
    }
  }

  Future<void> updateBanner(
      {required String title,
      required String body,
      required int bannerId}) async {
    try {
      final token = localstorage.read('bearer_token');

      var data = {
        'title': title,
        'body': body,
      };
      final response = await http.put(
        Uri.parse('http://10.0.2.2:8000/api/banners/$bannerId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        print("Banner created: $responseBody");
        await fetchAllBanners();

        Get.toNamed('/home');
      } else {
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch banners: $e');
    }
  }

  Future<void> createPost({
    required String title,
    required String body,
    required int bannerId,
    required int userId,
  }) async {
    try {
      final token = localstorage.read('bearer_token');
      print('this is the token: $token');
      print(title);
      print(body);
      print(bannerId);
      print(userId);
      var data = {
        'title': title,
        'body': body,
        'banner_id': bannerId,
        'user_id': userId,
      };
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/posts'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        print("Post created: $responseBody");

        Get.toNamed('/home');
      } else if (response.statusCode == 401) {
        final responseBody = json.decode(response.body);
        print('error:response $responseBody');
      } else {
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch banners: $e');
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      final token = localstorage.read('bearer_token');
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/api/posts/$postId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        print(responseBody);
      } else {
        final responseBody = json.decode(response.body);
        final error = responseBody['message'];
        Get.snackbar('Caution', '$error to delete it',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      throw Exception('Failed to fetch banners: $e');
    }
  }

  Future<void> updatePost(
      {required String title,
      required String body,
      required int bannerId}) async {
    try {
      final token = localstorage.read('bearer_token');

      var data = {
        'title': title,
        'body': body,
      };
      final response = await http.put(
        Uri.parse('http://10.0.2.2:8000/api/banners/$bannerId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        print("Banner created: $responseBody");
        await fetchAllBanners();

        Get.toNamed('/home');
      } else {
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch banners: $e');
    }
  }
}
