import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String postId;
  final String username;
  final String email;
  final String text;
  final DateTime timestamp;

  CommentModel(
      {required this.postId,
      required this.email,
      required this.username,
      required this.text,
      required this.timestamp});

  toJson() {
    return {
      'postId': postId,
      'username': username,
      'email': email,
      'comment': text,
      'time': timestamp,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        postId: json['postId'],
        email: json['email'],
        username: json['username'],
        text: json['comment'],
        timestamp: (json['time'] as Timestamp).toDate());
  }
}
