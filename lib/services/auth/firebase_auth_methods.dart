// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glitzup/core/colors.dart';
import 'package:glitzup/core/constants.dart';
import 'package:glitzup/views/screens/add%20profile/add_details_screen.dart';
import 'package:glitzup/views/screens/bottom%20nav/bottom_nav_bar.dart';
import 'package:glitzup/views/widgets/snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

      // await emailVerification(email, context);

      // Wait for the user to verify their email before proceeding
      // await _auth
      //     .authStateChanges()
      //     .firstWhere((user) => user?.emailVerified == true);

      // The user's email is now verified, proceed with creating the user
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
      showSnackbar(context, e.message!,kRedColor);
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

      // await Future.delayed(Duration(milliseconds: 500));
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
      

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showSnackbar(context, e.message!,kRedColor);
    }
    // finally{
    //   Navigator.of(context,rootNavigator: true).pop();
    // }
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
     await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
          (route) => false);
    });
   // ignore: empty_catches
   } catch (e) {
     
   }

  }
}

final emailAuth = EmailOTP();

void sendOTP(String email, BuildContext context) async {
  emailAuth.setConfig(
      appEmail: "me@rohitchouhan.com",
      appName: "GlitsUp",
      userEmail: email,
      otpLength: 6,
      otpType: OTPType.digitsOnly);
  // var res = await emailAuth.sendOtp(recipientMail: email);
  if (await emailAuth.sendOTP() == true) {
    // ignore: use_build_context_synchronously
    showSnackbar(context, 'OTP send succesfully',Colors.green);
  } else {
    // ignore: use_build_context_synchronously
    showSnackbar(context, 'Please try again',kRedColor);
  }
}

bool verifyOTP(String email, String userOtp, BuildContext context) {
// var res = emailAuth.validateOtp(recipientMail: email, userOtp: userOtp);

  if (emailAuth.verifyOTP(otp: userOtp) == true) {
    showSnackbar(context, 'Otp verified',Colors.green);
    return true;
  } else {
    showSnackbar(context, 'Invalid OTP',kRedColor);
    return false;
  }
}

void clearText(TextEditingController textController) {
  textController.clear();
}
