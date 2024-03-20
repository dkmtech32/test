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
            coverImage: userSnapshot["cover image"],
            profilePic: userSnapshot["image path"]);

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
            caption: postDoc["caption"],
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

  Future<String> getProfilePictureUrl(String username) async {
    String imageUrl;
    QuerySnapshot userSnapShot = await firestore
        .collection('Users')
        .where('username', isEqualTo: username)
        .get();
    if (userSnapShot.docs.isNotEmpty) {
      imageUrl = userSnapShot.docs[0]["image path"];
      print(imageUrl);
    } else {
      imageUrl = '';
    }
    print('object $imageUrl');
    return imageUrl;
  }
}
