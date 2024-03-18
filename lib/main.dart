import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/controller/text_field_validator_controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/core/themes.dart';
import 'package:flutter_app/services/auth/firebase_auth_methods.dart';
import 'package:flutter_app/views/screens/auth/auth_wrapper.dart';
import 'package:flutter_app/controller/text_field_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyCE37Xv7aORInMRDPwDiiIgkT7bH5BTfeQ',
              appId: '1:327956457228:android:0694fbf7ee68644a550b29',
              messagingSenderId: '327956457228',
              projectId: 'sportscape-e529c'))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider(
          create: (_) => ShowTextFeildProvider(),
        ),
        ChangeNotifierProvider<TextfieldValidatorProvider>(
          create: (_) => TextfieldValidatorProvider(),
        ),
        StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null)
      ],
      child: GetMaterialApp(
          theme: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? darkTheme
              : lightTheme,
          debugShowCheckedModeBanner: false,
          home: const AuthWrapper()),
    );
  }
}
