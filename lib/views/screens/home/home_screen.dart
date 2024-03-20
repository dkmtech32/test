import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/screens/addProfile/add_detail_screen.dart';
import 'package:flutter_app/views/widget/image_banner.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/views/screens/auth/login_screen.dart';
import 'package:flutter_app/views/widget/post_card.dart';
import 'package:flutter_app/controller/user/user_provider.dart';
import 'package:flutter_app/services/users/user_detail.dart';
import 'package:flutter_app/model/post/post_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddDetails(),
                ));
              },
              icon: const Icon(Icons.messenger_outline_rounded),
            ),
          ],
        ),
        body:
        // Column(
        //   children: [
            // ImageBannerWidget(
            //   imageUrls: myImageUrls,
            //   height: 150,
            // ),
            FutureBuilder<List<PostModel>>(
              future: userProvider.fetchPostsFromFirebase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  List<PostModel>? posts = snapshot.data;
                  // print(snapshot.data);
                  return ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemCount: posts!.length,
                    itemBuilder: (context, index) =>
                        postCard(size, posts[index], context),
                  );
                }
              },
            )
        //   ],
        // )
        );
  }
}

List<String> myImageUrls = [
  'https://plus.unsplash.com/premium_photo-1681582960531-7b5de57fb276?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMnx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1707327956851-30a531b70cda?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwyMXx8fGVufDB8fHx8fA%3D%3D',
  'https://plus.unsplash.com/premium_photo-1686278851694-d1ab44635d03?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyN3x8fGVufDB8fHx8fA%3D%3D',
];
