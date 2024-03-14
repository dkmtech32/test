import 'package:flutter/material.dart';

Widget loginTextFeild(String hintText, bool obscureText) {
  return TextFormField(
    decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(10),
        //     borderSide: const BorderSide(
        //         color:
        //              kBlackColor)),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        //   borderSide: const BorderSide(color: Brightness == Brightness.dark ? kBlackColor : kWhiteColor),
        // ),
        labelText: hintText
        // hintText: hintText,
        ),
    obscureText: obscureText,
  );
}