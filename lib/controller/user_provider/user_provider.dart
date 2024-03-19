import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<void> fetchUserDetailsFromFireStore(String email) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

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
}
