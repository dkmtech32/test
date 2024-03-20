import 'package:flutter/material.dart';
import 'package:flutter_app/services/post/post.dart';
import 'package:flutter_app/services/users/user_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/model/post/post_model.dart';
import 'package:flutter_app/controller/user/user_provider.dart';
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
  String dropdownLocationValue = 'S1 Football Court';
  int dropdownNoValue = 1;
  List<DateTime>? startEndDateTime;

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

      imageUrl =
          await FireBasePostService().addPostImage(imagePicked, username);
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
                        width: size.width * .8,
                        height: size.width * .5,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          ElevatedButton(
                            child: const Text('Select Time Range'),
                            onPressed: () async {
                               startEndDateTime =
                                  await showOmniDateTimeRangePicker(
                                context: context,
                                startInitialDate: DateTime.now(),
                                startFirstDate: DateTime(1600)
                                    .subtract(const Duration(days: 3652)),
                                startLastDate: DateTime.now().add(
                                  const Duration(days: 3652),
                                ),
                                endInitialDate: DateTime.now(),
                                endFirstDate: DateTime(1600)
                                    .subtract(const Duration(days: 3652)),
                                endLastDate: DateTime.now().add(
                                  const Duration(days: 3652),
                                ),
                                is24HourMode: false,
                                isShowSeconds: false,
                                minutesInterval: 1,
                                secondsInterval: 1,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                constraints: const BoxConstraints(
                                  maxWidth: 350,
                                  maxHeight: 650,
                                ),
                                transitionBuilder:
                                    (context, anim1, anim2, child) {
                                  return FadeTransition(
                                    opacity: anim1.drive(
                                      Tween(
                                        begin: 0,
                                        end: 1,
                                      ),
                                    ),
                                    child: child,
                                  );
                                },
                                transitionDuration:
                                    const Duration(milliseconds: 200),
                                barrierDismissible: true,
                                selectableDayPredicate: (dateTime) {
                                  // Disable 25th Feb 2023
                                  if (dateTime == DateTime(2023, 2, 25)) {
                                    return false;
                                  } else {
                                    return true;
                                  }
                                },
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.width / 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.height * .25,
                            height: size.width * .15,
                            child: DropdownButton(
                              hint: const Text('Select Location'),
                              value: dropdownLocationValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownLocationValue = newValue!;
                                });
                              },
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'S1 Football Court',
                                  child: Text('S1 Football Court'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'S1 Basketball Court',
                                  child: Text('S1 Basketball Court'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'S1 Badminton Court',
                                  child: Text('S1 Badminton Court'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'S1 Volleyball Court',
                                  child: Text('S1 Volleyball Court'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'S1 Tennis Court',
                                  child: Text('S1 Tennis Court'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'S2 Basketball Court',
                                  child: Text('S2 Basketball Court'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'S2 Badminton Court',
                                  child: Text('S2 Badminton Court'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'S2 Volleyball Court',
                                  child: Text('S2 Volleyball Court'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'S2 Tennis Court',
                                  child: Text('S2 Tennis Court'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: size.width * .3,
                            height: size.width * .15,
                            child: DropdownButton(
                              isExpanded: true,
                              hint: const Text('Number of Players'),
                              value: dropdownNoValue,
                              onChanged: (Object? newValue) {
                                setState(() {
                                  dropdownNoValue = newValue as int;
                                });
                              },
                              items: const [
                                DropdownMenuItem<int>(
                                  value: 1,
                                  child: Text('1'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 2,
                                  child: Text('2'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 3,
                                  child: Text('3'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 4,
                                  child: Text('4'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 5,
                                  child: Text('5'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 6,
                                  child: Text('6'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 7,
                                  child: Text('7'),
                                ),
                                DropdownMenuItem<int>(
                                  value: 8,
                                  child: Text('8'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width / 16,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            addPostToFirestore(
                                userData["username"],
                                _captionController.text,
                                imageUrl!,
                                dropdownNoValue,
                                startEndDateTime![0],
                                startEndDateTime![1],
                                dropdownLocationValue);
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
