// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glitzup/core/colors.dart';
import 'package:glitzup/views/widgets/snackbar.dart';

Future passwordReset(String email, BuildContext context) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // ignore: use_build_context_synchronously
    showSnackbar(context, 'Password reset link sent succefully!', kGreyColor);
  } on FirebaseAuthException catch (e) {
    showSnackbar(context, e.message!, kRedColor);
  }
}
