import 'package:flutter/material.dart';

import 'profile_page_button.dart';

class UserDetails extends StatelessWidget {
  final String userName;
  final String bio;
  final String buttonText;
  const UserDetails({
    super.key,
    required this.size, required this.userName, required this.bio, required this.buttonText,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration:  BoxDecoration(
          
          // color: Brightness==Brightness.light? profilePageColorLight : profilePageColordark,
          color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
        ),
        // height: size.height,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
             Text(
              userName,
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width * .7,
              child:  Center(
                child: Text(bio)
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ProfilePageButton(text: buttonText)
          ],
        ),
      ),
    );
  }
}
