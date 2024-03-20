import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/controller/notification/notification_controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/core/themes.dart';
import 'package:flutter_app/services/auth/firebase_auth_methods.dart';
import 'package:flutter_app/views/screens/auth/auth_wrapper.dart';
import 'package:flutter_app/controller/text_field/text_field_controller.dart';
import 'package:flutter_app/controller/text_field/text_field_validator_controller.dart';
import 'package:flutter_app/controller/user/user_provider.dart';

void main() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white)
  ], channelGroups: [
    NotificationChannelGroup(
      channelGroupKey: 'grouped',
      channelGroupName: 'Grouped notifications',
    )
  ]);
  bool isNotificationAllowed =
      await AwesomeNotifications().isNotificationAllowed();
      if (!isNotificationAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
        
      }

  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyCE37Xv7aORInMRDPwDiiIgkT7bH5BTfeQ',
              appId: '1:327956457228:android:0694fbf7ee68644a550b29',
              messagingSenderId: '327956457228',
              projectId: 'sportscape-e529c',
              storageBucket: 'gs://sportscape-e529c.appspot.com'))
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
@override
State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 @override
 void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );
    super.initState();
   }
  

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
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
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
