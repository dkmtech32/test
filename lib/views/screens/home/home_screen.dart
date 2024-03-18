import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/views/screens/auth/login_screen.dart';

import 'package:flutter_app/views/widget/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: Image.asset(
            'assets/images/logo.png',
            width: size.width * 0.33,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.messenger_outline_rounded),
          ),
          IconButton(onPressed: () async{
             googleSignIn.disconnect();
           await FirebaseAuth.instance.signOut().then((value) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  LoginScreen(),), (route) => false);
           });
    
          }, icon: const Icon(Icons.logout))
        ],
       
      ),
      body: SafeArea(
          child: ListView.builder(
        // scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => postCard(size),
      )),
    );
  }
}