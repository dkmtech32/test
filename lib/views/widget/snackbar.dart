import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        // shape: BorderRadius.circular(10),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
          style: const TextStyle(fontSize: 15),
        )),
  );
}
