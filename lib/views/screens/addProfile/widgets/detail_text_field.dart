
import 'package:flutter/material.dart';

import 'package:flutter_app/core/color.dart';

class DetailsTextFeild extends StatelessWidget {
  const DetailsTextFeild({
    super.key,
    required this.nameController, required this.hintText, required this.obscureText, required this.maxLines,  this.validate,
  });

  final TextEditingController nameController;
  final String hintText;
  final bool obscureText;
  final int maxLines;
  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
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
        maxLines: maxLines,
        controller: nameController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).primaryColor,
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
        validator: validate,
      ),
    );
  }
}
