import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<String> addProfileImage(XFile imagePicked) async{
   Reference referenceRoot = FirebaseStorage.instance.ref();
     Reference referenceDirImages = referenceRoot.child('images');

     String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

     Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);


      try {
       await referenceImageToUpload.putFile(File(imagePicked.path));
      String  imageUrl =await referenceImageToUpload.getDownloadURL();
      return imageUrl;
      } catch (e) {
        return "";

      }
    }