import 'package:flutter/material.dart';
import 'package:flutter_app/core/color.dart';

class UserTitle extends StatelessWidget {
  final String text;
  final String? time;
  final String profilePicUrl;

  const UserTitle({
    super.key,
    required this.text,
    this.time,
    required this.profilePicUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(profilePicUrl),
          ),
          title: RichText(
              text: TextSpan(children: [
            TextSpan(text: text,
            style: const TextStyle(color: kBlackColor, fontSize: 15)),
            TextSpan(
                text: '  ${time ?? ''}',
                style: const TextStyle(color: kBlackColor, fontSize: 12))
          ]))),
    );
  }
}
