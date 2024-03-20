import 'package:flutter/material.dart';
import 'package:flutter_app/model/comment/comment_model.dart';

class PostModel {
  final String? postId;
  final String username;
  final String imagePath;
  final String? caption;
  final int slotCount;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String location;
  final DateTime timestamp;
  final List<String> likes;
  final List<CommentModel> comments;

  PostModel({
    this.postId,
    required this.username,
    required this.imagePath,
    this.caption,
    required this.slotCount,
    required this.timestamp,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.likes,
    required this.comments,
  });

  toJson() {
    return {
      "username": username,
      "caption": caption,
      "image path": imagePath,
      "slotCount": slotCount, 
      "startTime": startTime,
      "endTime": endTime,
      "location": location,
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
        startTime: json["startTime"].toDate(),
        endTime: json["endTime"].toDate(),
        location: json["location"],
        slotCount: json["slotCount"],
        timestamp: json["timestamp"].toDate(),
        likes: List<String>.from(json["likes"]),
        comments: []);
  }
}
