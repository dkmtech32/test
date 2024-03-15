import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/widget/snackbar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  //Email Sign Up

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
    }
  }

  //Email login

  Future<void> loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // if(_auth.currentUser!.emailVerified){
      //   showSnackbar(context, 'Email not verified');
      // }
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
    }
  }

  //Email verification

  // Future<void> sendEmailVerification(BuildContext context) async {
  //   try {
  //     _auth.currentUser!.sendEmailVerification();
  //     showSnackbar(context, 'Email verification sent!');
  //   } on FirebaseAuthException catch (e) {
  //     showSnackbar(context, e.message!);
  //   }
  // }
}

String? validateEmail(String? value) {
  if (value!.isEmpty) {
    return 'Please enter your Email';
  } else if (value.isEmpty ||
      !RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$')
          .hasMatch(value)) {
    return 'Enter valid Email';
  } else {
    return null;
  }
}
String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return 'Please enter your password';
  } else if (value.length < 6 && value.isNotEmpty) {
    return 'Minimum 6 characters requiered';
  } else {
    return null;
  }
}