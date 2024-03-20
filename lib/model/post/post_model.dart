import 'package:flutter_app/model/comment/comment_model.dart';

class PostModel {
  final String? postId;
  final String username;
  final String imagePath;
  final String? caption;
  final DateTime timestamp;
  final List<String> likes;
  final List<CommentModel> comments;

  PostModel({
    this.postId,
    required this.username,
    required this.imagePath,
    this.caption,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });

  toJson() {
    return {
      "username": username,
      "caption": caption,
      "image path": imagePath,
      "likes": likes,
      "timestamp": timestamp,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        postId: json['postId'],
        username: json["username"],
        imagePath: json["image path"],
        caption: json["caption"],
        timestamp: json["timestamp"].toDate(),
        likes: List<String>.from(json["likes"]),
        comments: []);
  }
}
