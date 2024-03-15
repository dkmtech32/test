import 'package:flutter/material.dart';
import 'package:flutter_app/core/color.dart';

class ProfilePageButton extends StatelessWidget {
  final text;
   const ProfilePageButton({
    super.key,required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
          color: kGreyColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,)),
      child:  Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: const TextStyle(fontSize: 17,color: kGreyColor),
        ),
      )),
    );
  }
}