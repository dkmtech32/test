import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'widgets/detail_text_field.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/controller/user/user_controller.dart';
import 'package:flutter_app/model/user/user_model.dart';
import 'package:flutter_app/services/users/user_detail.dart';
import 'package:flutter_app/services/users/add_image.dart';
import 'package:flutter_app/services/auth/firebase_auth_methods.dart';

// ignore: must_be_immutable
class AddDetails extends StatefulWidget {
  const AddDetails({super.key});

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController bioController = TextEditingController();

  final UserController userController = Get.put(UserController());

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? imagePath;
  String? imageUrl;

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   fullNameController.dispose();
  //   userController.dispose();
  //   bioController.dispose();
  //   userController.dispose();
  // }

  Future<void> imagePick() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        imagePath = imagePicked.path;
      });

      //  Reference referenceRoot = FirebaseStorage.instance.ref();
      //  Reference referenceDirImages = referenceRoot.child('images');

      //  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

      //  Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

      //   try {
      //    await referenceImageToUpload.putFile(File(imagePicked.path));
      //     imageUrl =await referenceImageToUpload.getDownloadURL();
      //   } catch (e) {

      //   }
      imageUrl = await addProfileImage(imagePicked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signeduser = context.read<FirebaseAuthMethods>().currentUser;
    Size size = MediaQuery.sizeOf(context);
    return Form(
      key: _formkey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add profile'),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    final user = UserModel(
                        email: signeduser!.email!,
                        profilePic: imageUrl != null ? imageUrl! : profileImage,
                        coverImage: coverImage,
                        fullName: fullNameController.text.trim(),
                        userName: userNameController.text.trim(),
                        // likedPosts: [],
                        bio: bioController.text.isNotEmpty
                            ? bioController.text.trim()
                            : '');
                    saveUserData(user, context);
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(size.width / 16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: imagePath == null
                            ? const AssetImage('assets/images/download.png')
                                as ImageProvider
                            : FileImage(File(imagePath!)),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              imagePick();
                            },
                            child: Icon(
                              Icons.add_a_photo,
                              size: 30,
                            ),
                          ))

                      //          CircleAvatar(
                      //   radius: 70,
                      //   backgroundImage: imagePath == null
                      //       ? const AssetImage('assets/images/download.png')
                      //           as ImageProvider
                      //       : FileImage(File(imagePath!)),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  DetailsTextFeild(
                      nameController: fullNameController,
                      hintText: 'Full name',
                      obscureText: false,
                      maxLines: 1,
                      validate: validateFullName),
                  const SizedBox(
                    height: 25,
                  ),
                  DetailsTextFeild(
                    nameController: userNameController,
                    hintText: 'username',
                    obscureText: false,
                    maxLines: 1,
                    validate: validateUsername,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  DetailsTextFeild(
                    nameController: bioController,
                    hintText: 'Bio',
                    obscureText: false,
                    maxLines: 6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
