import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/user/user_model.dart';

class SearchService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> fetchSearchDetails(
      String searchQuery, List<UserModel> users) async {
    try {
      print('keri');
      final querySnapshot = await _firebaseFirestore
          .collection('Users')
          .where(
            'username'.toLowerCase(),
            isGreaterThanOrEqualTo: searchQuery.toLowerCase(),
          )
          .get();
      users.clear();
      // print(querySnapshot.docs.length);
      for (var data in querySnapshot.docs) {
        print('obt');
        Map<String, dynamic> user = data.data();
        users.add(UserModel.fromJson(user));
        print('jshdb');
        print(user);
      }

      // print(users.first.email);
      // return users;
    } catch (e) {
      // print(e.toString());
      // return users;
    }
  }
}