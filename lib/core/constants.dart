import 'package:flutter_app/views/screens/home/home_screen.dart';
import 'package:flutter_app/views/screens/notification/noti_screen.dart';
import 'package:flutter_app/views/screens/profile/user_profile.dart';
import 'package:flutter_app/views/screens/search/search_screen.dart';
// import 'package:flutter_app/views/screens/uploadpost_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
final screens = [
  HomeScreen(),
  SearchScreen(),
  // UploadPost(),
  NotificationScreen(),
  ProfileScreen()
];
final googleSignIn= GoogleSignIn();