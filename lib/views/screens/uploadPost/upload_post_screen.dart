import 'package:flutter/material.dart';
import 'package:flutter_app/services/post/post.dart';
import 'package:flutter_app/services/users/user_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/model/post/post_model.dart';
import 'package:flutter_app/controller/user_provider/user_provider.dart';
import 'package:flutter_app/model/user/user_model.dart';
import 'package:flutter_app/services/post/upload_post.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  String? imagePath;
  String? imageUrl;
  final TextEditingController _captionController = TextEditingController();

  Future<void> selectImage(String clicked, String username) async {
    final XFile? imagePicked;
    if (clicked == 'gallery') {
      imagePicked = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else {
      imagePicked = await ImagePicker().pickImage(source: ImageSource.camera);
    }
    if (imagePicked != null) {
      setState(() {
        imagePath = imagePicked!.path;
      });

      imageUrl = await addPostImage(imagePicked, username);
    }
  }

  // void addPostToFirestore(String username) async {
  //   print("image $imageUrl");

  //   PostModel newPost = PostModel(
  //       username: username,
  //       caption: _captionController.text,
  //       imagePath: imageUrl!,
  //       timestamp: DateTime.now(),
  //       likes: [],
  //       comments: []);

  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .add(newPost.toJson())
  //       .then((value) {
  //     print('post added');
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(
  //           builder: (context) => BottomNavBar(),
  //         ),
  //         (route) => false);
  //   }).onError((error, stackTrace) {
  //     print(error.toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder(
      future: getUserDataByEmail(FirebaseAuth.instance.currentUser!.email!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else if (snapshot.hasData && snapshot.data != null) {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: const Text('upload'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(size.width / 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * .7,
                        height: size.width * .8,
                        decoration: imagePath != null
                            ? BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(File(imagePath!)),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              )
                            : BoxDecoration(
                                color: const Color.fromARGB(255, 21, 21, 21),
                                borderRadius: BorderRadius.circular(10),
                              ),
                      ),
                      SizedBox(
                        height: size.width * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              selectImage('camera', userData["username"]);
                            },
                            child: const CircleAvatar(
                              // backgroundColor: kRedColor,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 35,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width / 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              selectImage('gallery', userData["username"]);
                            },
                            child: const CircleAvatar(
                              // backgroundColor: kRedColor,
                              child: Icon(
                                Icons.photo_library_outlined,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width / 16,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: size.width * .15,
                        child: TextField(
                          controller: _captionController,
                          maxLines: 100,
                          decoration: InputDecoration(
                              fillColor: const Color.fromARGB(255, 30, 29, 29)
                                  .withOpacity(.6),
                              filled: true,
                              hintText: 'Caption',
                              // hin,

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      SizedBox(
                        height: size.width / 16,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            addPostToFirestore(userData["username"],
                                _captionController.text, imageUrl!);
                          },
                          child: const Text(
                            'Post',
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Text('data');
        }
      },
    );
  }
}
