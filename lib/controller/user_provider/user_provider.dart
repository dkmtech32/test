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
            imagePath: userSnapshot["image path"]);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
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
            timestamp: postDoc["timestamp"].toDate(),
            likes: List<String>.from(postDoc["likes"]),
            comments: []);
        posts.add(post);
      }
    } catch (e) {
      print(e);
    }
    return posts;
  }
}
