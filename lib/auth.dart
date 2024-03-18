import 'package:firebase_auth/firebase_auth.dart';
class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signinWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signupWithEmailAndPassword(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signout() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> changePassword(String password) async {
    await user!.updatePassword(password);
  }


}
