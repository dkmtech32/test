import 'package:flutter/material.dart';
import 'package:flutter_app/core/color.dart';
import 'package:flutter_app/services/auth/firebase_auth_methods.dart';
import 'package:flutter_app/views/screens/auth/signup_screen.dart';

Widget loginTextField(String hintText, bool obscureText,
    TextEditingController textController, String? Function(String? value) validator,BuildContext context,Widget suffix,[String? email]) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [ 
      BoxShadow(
        color: Colors.grey.withOpacity(0.2), // Shadow color
        spreadRadius: 2, // Spread radius
        blurRadius: 5, // Blur radius
        offset: const Offset(0, 3), 
        blurStyle: BlurStyle.inner
      ),
    ],
      ),
    child: TextFormField(
      controller: textController,
      decoration: InputDecoration(
        fillColor: Theme.of(context).primaryColor,
        filled: true,
        suffix:InkWell(

          onTap: () {
            if(hintText == 'Email' || hintText == 'Password' ){
              clearText(textController);
            }else if(hintText == 'otp'){
             hiddentextField = verifyOTP(email!, textController.text, context);
            }else if(hintText == 'Email Address'){
              sendOTP(textController.text, context);
            }

          },
          child: suffix),
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
