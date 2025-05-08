import 'package:post_app/models/userModel.dart';

class PostModel {
  final int id;
  final int userId;
  final String title;
  final int bannerId;
  final String content;
  final User? user;

  PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.bannerId,
    required this.content,
    this.user,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      bannerId: json['banner_id'],
      content: json['body'],
      user: User.fromJson(json['user']),
    );
  }
}
