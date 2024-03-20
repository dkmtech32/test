import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user/user_model.dart';
import 'package:flutter_app/model/post/post_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchUserDetailsFromFireStore(String email) async {
    try {
      DocumentSnapshot userSnapshot =
          await firestore.collection('Users').doc(email).get();

      if (userSnapshot.exists) {
        _currentUser = UserModel(
            email: email,
            fullName: userSnapshot["full name"],
            userName: userSnapshot["username"],
            // likedPosts: userSnapshot['liked posts'],
            coverImage: userSnapshot["cover image"],
            profilePic: userSnapshot["image path"]);

        notifyListeners();
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<UserModel?> fetchUserDetailsFromFireStoreByUsername(
      String username) async {
    try {
      QuerySnapshot userSnapshot = await firestore
          .collection('Users')
          .where('username', isEqualTo: username)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        _currentUser = UserModel(
            email: userSnapshot.docs[0].id,
            fullName: userSnapshot.docs[0]["full name"],
            userName: userSnapshot.docs[0]["username"],
            // likedPosts: userSnapshot.docs[0]['liked posts'],
            coverImage: userSnapshot.docs[0]["cover image"],
            profilePic: userSnapshot.docs[0]["image path"]);

        notifyListeners();
      }
      // ignore: empty_catches
    } catch (e) {}
    return _currentUser;
  }

  Future<List<PostModel>> fetchPostsFromFirebase() async {
    List<PostModel> posts = [];

    try {
      QuerySnapshot postSnapshot = await firestore.collection('posts').get();
      for (var postDoc in postSnapshot.docs) {
        PostModel post = PostModel(
            postId: postDoc.id,
            username: postDoc["username"],
            imagePath: postDoc["image path"],
            startTime: postDoc["startTime"].toDate(),
            endTime: postDoc["endTime"].toDate(),
            location: postDoc["location"],
            slotCount: postDoc["slotCount"],
            caption: postDoc["caption"],
            timestamp: postDoc["timestamp"].toDate(),
            likes: List<String>.from(postDoc["likes"]),
            comments: []);
        posts.add(post);
      }
      // ignore: empty_catches
    } catch (e) {}
    return posts;
  }

  Future<List<PostModel>> fetchCurrentUserPosts(String username) async {
    List<PostModel> posts = [];

    try {
      QuerySnapshot postSnapshot = await firestore
          .collection('posts')
          .where('username', isEqualTo: username)
          .get();
      for (var postDoc in postSnapshot.docs) {
        PostModel post = PostModel(
            postId: postDoc.id,
            username: postDoc["username"],
            imagePath: postDoc["image path"],
            caption: postDoc["caption"],
            startTime: postDoc["startTime"].toDate(),
            endTime: postDoc["endTime"].toDate(),
            location: postDoc["location"],
            slotCount: postDoc["slotCount"],
            timestamp: postDoc["timestamp"].toDate(),
            likes: List<String>.from(postDoc["likes"]),
            comments: []);
        posts.add(post);
      }
      // ignore: empty_catches
    } catch (e) {}
    return posts;
  }

  Future<String> getProfilePictureUrl(String username) async {
    String imageUrl;
    QuerySnapshot userSnapShot = await firestore
        .collection('Users')
        .where('username', isEqualTo: username)
        .get();
    if (userSnapShot.docs.isNotEmpty) {
      imageUrl = userSnapShot.docs[0]["image path"];
    } else {
      imageUrl = '';
    }
    return imageUrl;
  }
}
