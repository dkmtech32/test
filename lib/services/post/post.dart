import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<String> addPostImage(XFile imagePicked, String username) async {
  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference referenceDirImages = referenceRoot.child('posts');

  String uniqueFileName =
      username + DateTime.now().millisecondsSinceEpoch.toString();

  Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

  try {
    await referenceImageToUpload.putFile(File(imagePicked.path));
    String imageUrl = await referenceImageToUpload.getDownloadURL();
    return imageUrl;
  } catch (e) {
    return "";
  }
}
