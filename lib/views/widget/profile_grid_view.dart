import 'package:flutter/material.dart';
import 'package:flutter_app/model/post/post_model.dart';

class ProfileGridView extends StatelessWidget {
  final int itemCount;
  final List<PostModel> posts;
  const ProfileGridView({
    super.key, required this.itemCount, required this.posts, 
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
              image:  DecorationImage(
                  image:NetworkImage(posts[index].imagePath),
                  fit: BoxFit.cover)),
        );
      },
    );
  }
}