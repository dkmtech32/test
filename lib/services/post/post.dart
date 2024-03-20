import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FireBasePostService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> addPostImage(XFile imagePicked, String username) async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('posts');

    String uniqueFileName =
        username + DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(imagePicked.path));
      String imageUrl = await referenceImageToUpload.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return "";
    }
  }

  Future<int> postLiked(String postId, String emailId) async {
    try {
      final docSnapshot =
          await _firebaseFirestore.collection('posts').doc(postId).get();

      List likes = docSnapshot.data()!['likes'];
      likes.add(emailId);

      await _firebaseFirestore.collection('posts').doc(postId).update({
        'likes': likes,
      });

      print("List field updated successfully.");
      return likes.length;
    } catch (e) {
      print("Error updating list field: $e");
    }
    return 0;
  }

  Future<int> postUnliked(String postId, String emailId) async {
    try {
      final docSnapshot =
          await _firebaseFirestore.collection('posts').doc(postId).get();

      List likes = docSnapshot.data()!['likes'];
      likes.remove(emailId);

      await _firebaseFirestore.collection('posts').doc(postId).update({
        'likes': likes,
      });

      print("List field updated successfully.");
      return likes.length;
    } catch (e) {
      print("Error updating list field: $e");
    }
    return 0;
  }
}
