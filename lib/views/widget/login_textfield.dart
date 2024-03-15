import 'package:flutter/material.dart';
import 'package:flutter_app/core/color.dart';

Widget loginTextFeild(String hintText, bool obscureText,
    TextEditingController textController, String? validator(String? value)) {
  return TextFormField(
    controller: textController,
    decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: kCyanColor)),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        //   borderSide: const BorderSide(color:kBlackColor),
        // ),
        labelText: hintText
        // hintText: hintText,
        ),
    obscureText: obscureText,
    validator: validator,
  );
}
