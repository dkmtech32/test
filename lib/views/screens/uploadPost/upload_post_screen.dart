import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class UploadPost extends StatefulWidget {
  const UploadPost({super.key});
  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  String? imagePath;
  String? imageUrl;

  Future<void> selectImage(String clicked) async {
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

      // imageUrl =await addProfileImge(imagePicked);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
                        selectImage('camera');
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
                        selectImage('gallery');
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
                    onPressed: () {},
                    child: const Text(
                      'Post',
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            )),
      )),
    );
  }
}
