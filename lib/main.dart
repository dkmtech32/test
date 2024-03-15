import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/themes.dart';
import 'package:flutter_app/views/screens/auth/login_screen.dart';
import 'package:flutter_app/views/screens/navbar/nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCE37Xv7aORInMRDPwDiiIgkT7bH5BTfeQ', 
      appId: '1:327956457228:android:0694fbf7ee68644a550b29', 
      messagingSenderId: '327956457228', 
      projectId: 'sportscape-e529c')
   ) : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? darkTheme
          : lightTheme,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (context, snapshot) {
            if(snapshot.hasData){
              return BottomNavBar();
            }else{
              return LoginScreen();
            }
          },) ,
    );
  }
}
