import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'package:flutter_app/views/widget/snackbar.dart';
import 'package:flutter_app/views/screens/addProfile/add_detail_screen.dart';
import 'package:flutter_app/views/screens/navbar/nav_bar.dart';
import 'package:logger/logger.dart';

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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              color: Colors.transparent,
              child: SpinKitRing(
                // duration: Duration(milliseconds: 500),
                color: Theme.of(context).primaryColor,
                size: 50,
              ),
            ),
          );
        },
      );
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        Navigator.of(context)
            .pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => AddDetails(),
                ),
                (route) => false)
            .onError((error, stackTrace) {
          return const SnackBar(content: Text('data'));
        });
        return value;
      });
      User? user = userCredential.user;
      var logger = Logger();
      logger.d('user: $user');
      if (user != null) {
        var url =
            Uri.https('sportscape.onrender.com', 'api/v1/auth/google-auth');
        var response = await post(url, body: {
          'email': user.email,
          'uid': user.uid,
        });
        final accessToken = jsonDecode(response.body)['data']['accessToken'];

        var logger = Logger();
        logger.d('response access token: $accessToken');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showSnackbar(context, e.message!);
    }
  }

  //Email login

  Future<void> loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              color: Colors.transparent,
              child: SpinKitRing(
                //  duration:  Duration(seconds: 1),
                color: Theme.of(context).primaryColor,
                size: 50,
              ),
            ),
          );
        },
      );
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BottomNavBar(),
            ),
            (route) => false);
        return value;
      });

      User? user = userCredential.user;
      var logger = Logger();
      logger.i(user?.email);
      logger.i(user?.uid);

      if (user != null) {
        var url =
            Uri.https('sportscape.onrender.com', 'api/v1/auth/google-auth');
        var response = await post(url, body: {
          'email': user.email,
          'username': user.uid,
        });

        final accessToken = jsonDecode(response.body)['data']['accessToken'];

        var logger = Logger();
        logger.d('response access token: $accessToken');
      }
      // if(_auth.currentUser!.emailVerified){
      //   showSnackbar(context, 'Email not verified');
      // }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
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
