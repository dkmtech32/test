import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/color.dart';
import 'package:flutter_app/views/widget/snackbar.dart';

Future passwordReset(String email, BuildContext context) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // ignore: use_build_context_synchronously
    showSnackbar(context, 'Password reset link sent succefully!', kGreyColor);
  } on FirebaseAuthException catch (e) {
    showSnackbar(context, e.message!, kCyanColor);
  }
}