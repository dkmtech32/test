import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:email_otp/email_otp.dart';

import 'package:flutter_app/views/widget/snackbar.dart';
import 'package:flutter_app/views/screens/addProfile/add_detail_screen.dart';
import 'package:flutter_app/views/screens/navbar/nav_bar.dart';
import 'package:logger/logger.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authState => _auth.authStateChanges();
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
      // UserCredential userCredential = await _auth
      //     .createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // )
      //     .then((value) {
      //   Navigator.of(context, rootNavigator: true)
      //       .pop(); // Close the loading dialog

      //   Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       builder: (context) => const AddDetails(),
      //     ),
      //     (route) => false,
      //   );
      //   return value;
      // });
      // User? user = userCredential.user;
      // var logger = Logger();
      // logger.d('user: $user');
      // if (user != null) {
      //   var url =
      //       Uri.https('sportscape.onrender.com', 'api/v1/auth/google-auth');
      //   var response = await post(url, body: {
      //     'email': user.email,
      //     'uid': user.uid,
      //   });
      //   final accessToken = jsonDecode(response.body)['data']['accessToken'];

      //   var logger = Logger();
      //   logger.d('response access token: $accessToken');
      // }
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        Navigator.of(context, rootNavigator: true)
            .pop(); // Close the loading dialog

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const AddDetails(),
          ),
          (route) => false,
        );
      });
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
      // UserCredential userCredential = await _auth
      //     .signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // )
      //     .then((value) {
      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(
      //         builder: (context) => BottomNavBar(),
      //       ),
      //       (route) => false);
      //   return value;
      // });

      // User? user = userCredential.user;
      // var logger = Logger();
      // logger.i(user?.email);
      // logger.i(user?.uid);

      // if (user != null) {
      //   var url =
      //       Uri.https('sportscape.onrender.com', 'api/v1/auth/google-auth');
      //   var response = await post(url, body: {
      //     'email': user.email,
      //     'username': user.uid,
      //   });

      //   final accessToken = jsonDecode(response.body)['data']['accessToken'];

      //   var logger = Logger();
      //   logger.d('response access token: $accessToken');
      // }
      // if(_auth.currentUser!.emailVerified){
      //   showSnackbar(context, 'Email not verified');
      // }
      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
            (route) => false);
      });

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showSnackbar(context, e.message!);
    }
  }

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin(BuildContext context) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
            (route) => false);
      });
      // ignore: empty_catches
    } catch (e) {}
  }
}


final emailAuth = EmailOTP();

void sendOTP(String email, BuildContext context) async {
  emailAuth.setConfig(
      appEmail: "sportscape@court.com",
      appName: "SportScape",
      userEmail: email,
      otpLength: 6,
      otpType: OTPType.digitsOnly);
  // var res = await emailAuth.sendOtp(recipientMail: email);
  if (await emailAuth.sendOTP() == true) {
    // ignore: use_build_context_synchronously
    showSnackbar(context, 'OTP send succesfully');
  } else {
    // ignore: use_build_context_synchronously
    showSnackbar(context, 'Please try again');
  }
}

bool verifyOTP(String email, String userOtp, BuildContext context) {
// var res = emailAuth.validateOtp(recipientMail: email, userOtp: userOtp);

  if (emailAuth.verifyOTP(otp: userOtp) == true) {
    showSnackbar(context, 'Otp verified');
    return true;
  } else {
    showSnackbar(context, 'Invalid OTP');
    return false;
  }
}

void clearText(TextEditingController textController) {
  textController.clear();
}
