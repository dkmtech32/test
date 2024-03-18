import 'package:flutter/material.dart';
import 'package:flutter_app/controller/text_field_validator_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/core/color.dart';
import 'package:flutter_app/services/auth/firebase_auth_methods.dart';
import 'package:flutter_app/views/screens/auth/signup_screen.dart';
import 'package:flutter_app/controller/text_field_controller.dart';


Widget loginTextField(String hintText, bool obscureText,
    TextEditingController textController,BuildContext context,Widget suffix,{required String? Function(String?) validator,String? email, }) {
  
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
    child: FormBuilderTextField(
      
      name: hintText,
      controller: textController,
      onChanged: (value) {
        if(hintText == 'otp' && textController.text.isEmpty){
           context.read<TextfieldValidatorProvider>().updateOTP(value!);
          if(textController.text.isEmpty){
            Provider.of<ShowTextFeildProvider>(context,listen: false).toggleVisbility(false);
          }
        }else if(hintText == 'email' && textController.text.isEmpty){
          context.read<TextfieldValidatorProvider>().updateEmail(value!);
        }else if(hintText == 'password' && textController.text.isEmpty){
          context.read<TextfieldValidatorProvider>().updatePassword(value!);
        }
      },
      decoration: InputDecoration(
        fillColor: Theme.of(context).primaryColor,
        filled: true,
        suffix:InkWell(
         
          onTap: () {
            if(hintText == 'Email' || hintText == 'Password' ){
              clearText(textController);
            }else if(hintText == 'otp'){
              
            hiddentextField = verifyOTP(email!, textController.text, context);
            if(hiddentextField){

              Provider.of<ShowTextFeildProvider>(context,listen: false).toggleVisbility(true);
            }
            

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
          
          labelText: hintText
          ),
      obscureText: obscureText,
      validator:validator
    ),
  );
}