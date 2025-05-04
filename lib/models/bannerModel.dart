import 'package:post_app/models/postModel.dart';

class BannerModel {
  final int id;
  final int userId;
  final String title;
  final String body;
  final List<PostModel> posts;

  BannerModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.posts,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      posts: json['posts'] != null
          ? List<PostModel>.from(
              json['posts'].map((x) => PostModel.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'title': title,
      'body': body,
    };
  }
}
