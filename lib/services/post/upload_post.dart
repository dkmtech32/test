import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/post/post_model.dart';
import 'package:flutter_app/views/screens/navbar/nav_bar.dart';
import 'package:get/get.dart';


void addPostToFirestore(String username,String caption, String imageUrl, int slotCount, DateTime startTime, DateTime endTime, String location) async {
    PostModel newPost = PostModel(
        username: username,
        caption: caption,
        slotCount: slotCount,
        endTime: endTime,
        startTime: startTime, 
        location: location,
        imagePath: imageUrl,
        timestamp: DateTime.now(),
        likes: [],
        comments: []);

    FirebaseFirestore.instance
        .collection('posts')
        .add(newPost.toJson())
        .then((value) {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       builder: (context) => BottomNavBar(),
          // ),
          // (route) => false);
          Get.offAll(const BottomNavBar());
    }).onError((error, stackTrace) {
    });
  }