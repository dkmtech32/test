import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/controller/user_controller.dart';
import 'package:flutter_app/model/user/user_model.dart';
import 'package:flutter_app/views/screens/navbar/nav_bar.dart';

final userRepo = Get.put(UserController());
Future<void> saveUserData(UserModel user, BuildContext context) async {
  await userRepo.createUser(user);

  Get.offAll(() =>  const BottomNavBar());
}

String? validateFullName(String? value) {
  if (value!.isEmpty) {
    return 'Please enter your name';
  } else {
    return null;
  }
}

String? validateUsername(String? value) {
  if (value!.isEmpty) {
    return 'Username cannot be empty';
  } else if (value.length < 4) {
    return 'Username must be at least 4 characters long';
  } else if (value.contains(' ')) {
    return 'Username cannot contain spaces';
  }
  return null; // Return null if the validation passes
}
