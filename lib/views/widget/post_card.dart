import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/controller/post/post_controller.dart';
import 'package:flutter_app/controller/user/user_provider.dart';
import 'package:flutter_app/core/color.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/model/comment/comment_model.dart';
import 'package:flutter_app/model/post/post_model.dart';
import 'package:flutter_app/controller/datetime/date_time_format.dart';
import 'package:flutter_app/views/screens/viewProfile/other_profile.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';

Widget postCard(Size size, PostModel post, BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);
  final TextEditingController commentController = TextEditingController();
  final PostController postController = PostController();
  postController.fetchIsLiked(post, FirebaseAuth.instance.currentUser!.email!);
  List<String> startDateTime = post.startTime.toString().split(' ');
  String startDate =
      startDateTime[0].split("-")[2] + "/" + startDateTime[0].split("-")[1];
  String startTime =
      startDateTime[1].split(":")[0] + ":" + startDateTime[1].split(":")[1];
  List<String> endDateTime = post.endTime.toString().split(' ');
  String endDate =
      endDateTime[0].split("-")[2] + "/" + endDateTime[0].split("-")[1];
  String endTime =
      endDateTime[1].split(":")[0] + ":" + endDateTime[1].split(":")[1];

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: size.width,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            // onTap: () async => Get.to(() => OtherUserProfile(profile: await userProvider.fetchUserDetailsFromFireStoreByUsername(post.username))),
            child: ListTile(
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
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.username,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      formatDateTime(post.timestamp),
                      style: const TextStyle(fontSize: 16, color: kGreyColor),
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                  )),
            ),
          ),

          // Container(
          //   height: 280,
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: NetworkImage(post.imagePath), fit: BoxFit.cover),
          //       borderRadius: BorderRadius.circular(20)),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          Row(
            children: [
              Column(
                children: [
                  const SizedBox(height: 10.0),
                  Container(
                    width: 170, // Set the desired width here
                    child: Text(
                      post.caption != null ? post.caption.toString() : "",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      post.imagePath,
                      fit: BoxFit.cover,
                      height: 100.0,
                      width: size.height * 0.21,
                    ),
                  ),
                ],
              ),

              // const SizedBox(height: 10.0),

              // Column(
              //   children: [
              //     const SizedBox(
              //       height: 10,
              //     ),
              //     const Icon(Icons.location_on, color: kGreyColor, size: 30),
              //     const SizedBox(
              //       height: 10,
              //     ),
              //     Text(
              //       post.location,
              //       style: const TextStyle(fontSize: 16, color: kGreyColor),
              //     ),
              //   ],
              // ),
              // Column(
              //   children: [
              //     const SizedBox(
              //       height: 10,
              //     ),
              //     const Icon(Icons.people, color: kGreyColor, size: 30),
              //     const SizedBox(
              //       height: 10,
              //     ),
              //     Text(
              //       post.slotCount.toString() + ' slots',
              //       style: const TextStyle(fontSize: 16, color: kGreyColor),
              //     ),
              //   ],
              // ),
              // Column(
              //   children: [
              //     const SizedBox(
              //       height: 10,
              //     ),
              //     const Icon(Icons.watch, color: kGreyColor, size: 30),
              //     const SizedBox(
              //       height: 10,
              //     ),
              //     Text(
              //       post.startTime.toString() + ' - ' + post.endTime.toString(),
              //       style: const TextStyle(fontSize: 16, color: kGreyColor),
              //     ),
              //   ],
              // ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // Row for details icons and text
                      children: [
                        // People icon and text
                        Row(
                          children: [
                            const Icon(Icons.group,
                                color: Colors.black, size: 16.0),
                            Text(post.slotCount.toString() + ' slots',
                                style: const TextStyle(fontSize: 12.0)),
                          ],
                        ),
                        const SizedBox(width: 5.0),
                        // Location icon and text
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.black, size: 16.0),
                            Text(post.location.toString(),
                                style: TextStyle(fontSize: 12.0)),
                          ],
                        ),
                        const SizedBox(width: 5.0),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const Icon(Icons.access_time,
                        color: Color.fromARGB(255, 0, 0, 0), size: 16.0),
                    Text(
                      startDate +
                          " " +
                          startTime +
                          ' - ' +
                          endDate +
                          " " +
                          endTime,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                    const SizedBox(width: 5.0),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Obx(
                () => IconButton(
                    onPressed: () {
                      AwesomeNotifications().createNotification(
                          content: NotificationContent(
                              id: 10,
                              channelKey: 'basic_channel',
                              title: 'You liked a post',
                              body: 'You liked ${post.username}\'s post'));
                      postController.likeButtonClicked(post.postId!,
                          FirebaseAuth.instance.currentUser!.email!, post);
                    },
                    icon: postController.isFavourite.value
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 28,
                          )
                        : const Icon(
                            Icons.favorite_outline,
                            size: 28,
                          )),
              ),
              IconButton(
                  onPressed: () {
                    postController.commentButtonClicked(post.postId!);
                    commentBottomSheet(size, context, commentController,
                        post.postId!, postController);
                  },
                  icon: const Icon(
                    Icons.comment_bank_outlined,
                    size: 28,
                  )),
              // IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.send,
              //       size: 28,
              //     )),
              //
              const Spacer(),
              // Icon(Icons.bookmark_border,size: 30,),
              postController.appliersCount.value < post.slotCount
                  ? Obx(
                      () => IconButton(
                          onPressed: () {
                            AwesomeNotifications().createNotification(
                                content: NotificationContent(
                                    id: 10,
                                    channelKey: 'basic_channel',
                                    title: 'You applied to a session',
                                    body:
                                        'You applied to ${post.username}\'s post'));
                            postController.applyButtonClicked(
                                post.postId!,
                                FirebaseAuth.instance.currentUser!.email!,
                                post);
                          },
                          icon: postController.isApplied.value
                              ? const Icon(
                                  Icons.playlist_add,
                                  color: Colors.blueAccent,
                                  size: 28,
                                )
                              : const Icon(
                                  Icons.playlist_add_outlined,
                                  size: 28,
                                )),
                    )
                  : const SizedBox(),

              const SizedBox(
                width: 10,
              ),
              Obx(
                () => Text(
                  "${postController.appliersCount.value}" +
                      '/' +
                      post.slotCount.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Obx(
                () => Text(
                  '${postController.likesCount.value} likes',
                  style: const TextStyle(fontSize: 18),
                ),
              )),
          const SizedBox(
            height: 7,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: Text(
          //     post.caption != null ? post.caption.toString() : "",
          //     style: const TextStyle(fontSize: 16),
          //   ),
          // ),
          // const SizedBox(
          //   height: 7,
          // ),
        ],
      ),
    ),
  );
}

Future<dynamic> commentBottomSheet(
    Size size,
    BuildContext context,
    TextEditingController commentController,
    String postId,
    PostController postController) {
  return showModalBottomSheet(
    constraints:
        BoxConstraints.expand(height: size.height * .6, width: size.width),
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
                child: Obx(() => ListView.builder(
                    itemCount: postController.comments.length,
                    itemBuilder: (context, index) => ListTile(
                          leading: const CircleAvatar(),
                          title: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: postController.comments[index].username,
                                  style: const TextStyle(color: kCyanColor)),
                              const TextSpan(text: '  '),
                              TextSpan(
                                  text: formatDateTime(
                                      postController.comments[index].timestamp),
                                  style: const TextStyle(color: kGreyColor))
                            ]),
                          ),
                          subtitle: Text(postController.comments[index].text),
                        )))),

            SizedBox(
              height: size.width / 20,
            ),
            SizedBox(
              height: size.width * .12,
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          CommentModel comment = CommentModel(
                              postId: postId,
                              email: FirebaseAuth.instance.currentUser!.email!,
                              username:
                                  FirebaseAuth.instance.currentUser!.email!,
                              text: commentController.text,
                              timestamp: DateTime.now());
                          commentController.clear();
                          postController.postComment(comment, postId);
                        },
                        icon: const Icon(Icons.send)),
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
