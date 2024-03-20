import 'package:flutter/material.dart';
import 'package:flutter_app/core/color.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        // shape: BorderRadius.circular(10),
        backgroundColor: kCyanColor,
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
          style: TextStyle(fontSize: 15),
        )),
  );
}
