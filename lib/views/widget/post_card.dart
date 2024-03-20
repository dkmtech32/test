import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/post/post_controller.dart';
import 'package:flutter_app/controller/user/user_provider.dart';
import 'package:flutter_app/core/color.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/model/post/post_model.dart';
import 'package:flutter_app/controller/datetime/date_time_format.dart';
import 'package:provider/provider.dart';

Widget postCard(Size size, PostModel post, BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);
  final TextEditingController commentController = TextEditingController();
  final PostController postController = PostController();

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: size.width,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: FutureBuilder<String>(
              future: userProvider.getProfilePictureUrl(post.username),
              builder: (context, snapshot) {
                String? imageUrl = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircleAvatar(
                    backgroundImage: NetworkImage(profileImage),
                  );
                } else if (snapshot.hasError) {
                  return const CircleAvatar(
                    backgroundColor: kGreyColor,
                  );
                } else {
                  return CircleAvatar(
                    // radius: 20,
                    backgroundImage: NetworkImage(imageUrl!),
                  );
                }
              },
            ),
            title: Text(post.username),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                )),
          ),

          Container(
            height: 280,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(post.imagePath), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20)),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    print(FirebaseAuth.instance.currentUser!.email!);
                    postController.likeButtonClicked(post.postId!,
                        FirebaseAuth.instance.currentUser!.email!);
                  },
                  icon: const Icon(
                    Icons.favorite_outline,
                    size: 28,
                  )),
              IconButton(
                  onPressed: () {
                    commentBottomSheet(
                        size, context, commentController, post.postId!);
                  },
                  icon: const Icon(
                    Icons.comment_bank_outlined,
                    size: 28,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    size: 28,
                  )),
              //
              const Spacer(),
              // Icon(Icons.bookmark_border,size: 30,),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border,
                    size: 28,
                  )),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              '${post.likes.length} likes',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              post.caption != null ? post.caption.toString() : "",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              formatDateTime(post.timestamp),
              style: const TextStyle(fontSize: 16, color: kGreyColor),
            ),
          )
        ],
      ),
    ),
  );
}

Future<dynamic> commentBottomSheet(Size size, BuildContext context,
    TextEditingController commentController, String postId) {
  return showModalBottomSheet(
    constraints:
        BoxConstraints.expand(height: size.height * .7, width: size.width),
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    // clipBehavior: Clip.hardEdge,
    // barrierColor: Colors.red,
    // enableDrag: false,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(size.width / 16),
        child: Column(
          children: [
            const Text(
              'comments',
              style: TextStyle(fontSize: 18),
            ),
            const Divider(
              // height: 3,
              color: Colors.white,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 50,
                    itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(),
                          title: RichText(
                            text: TextSpan(children: [
                              TextSpan(text: postId),
                              TextSpan(text: '  '),
                              TextSpan(
                                  text: '5d',
                                  style: TextStyle(color: kGreyColor))
                            ]),
                          ),
                          subtitle: Text('commment'),
                        ))),
            SizedBox(
              height: size.width / 20,
            ),
            SizedBox(
              height: size.width * .12,
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.send),
                    hintText: 'Add a comment...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            )
          ],
        ),
      );
    },
  );
}
