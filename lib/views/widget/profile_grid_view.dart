import 'package:flutter/material.dart';

class ProfileGridView extends StatelessWidget {
  final int itemCount;
  const ProfileGridView({
    super.key, required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 9,
              crossAxisSpacing: 9),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: const DecorationImage(
                  image: AssetImage(
                      'assets/images/sachin.jpeg'),
                  fit: BoxFit.cover)),
        );
      },
    );
  }
}