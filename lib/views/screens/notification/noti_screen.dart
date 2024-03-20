import 'package:flutter/material.dart';
import 'package:flutter_app/views/widget/user_title.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('notifications',style: TextStyle(fontSize: 25),),),
      body:  ListView.builder(
                  itemCount: 20 ,itemBuilder: (context, index) {
                return    UserTitle(profilePicUrl: '',  text: 'atx.ul_ liked your post',time: '1h', );
                },) ,
    );
  }
}