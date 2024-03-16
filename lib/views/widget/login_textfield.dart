import 'package:flutter/material.dart';
import 'package:flutter_app/core/color.dart';

Widget loginTextFeild(String hintText, bool obscureText,
    TextEditingController textController, String? validator(String? value),BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [ 
      BoxShadow(
        color: Colors.grey.withOpacity(0.2), // Shadow color
        spreadRadius: 2, // Spread radius
        blurRadius: 5, // Blur radius
        offset: Offset(0, 3), 
        blurStyle: BlurStyle.inner
      ),
    ],
      ),
    child: TextFormField(
      controller: textController,
      decoration: InputDecoration(
        fillColor: Theme.of(context).primaryColor,
        filled: true,
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
    ),
  );
}
