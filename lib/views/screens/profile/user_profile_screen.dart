import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/controller/user/user_provider.dart';
import 'package:flutter_app/model/post/post_model.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/views/widget/profile_grid_view.dart';
import 'package:flutter_app/views/widget/user_detail.dart';
import 'package:flutter_app/views/screens/auth/login_screen.dart';
import 'package:flutter_app/services/users/user_profile.dart';

import 'package:flutter_app/core/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    // final user = context.read<FirebaseAuthMethods>().currentUser;
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder<DocumentSnapshot?>(
        future: getUserDataByEmail(FirebaseAuth.instance.currentUser!.email!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data != null) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: AppBar(
                title: Text(userData["username"]),
                actions: [
                  IconButton(
                      onPressed: () async {
                        googleSignIn.disconnect();
                        await FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false);
                        });
                      },
                      icon: const Icon(Icons.menu))
                ],
              ),
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return  [
                    SliverAppBar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      elevation: 0,
                      // pinned: true,
                      stretch: true,
                      expandedHeight: 300,
                      flexibleSpace: FlexibleSpaceBar(
                        stretchModes: const [StretchMode.zoomBackground],
                        background: Image(
                          image: NetworkImage(userData["cover image"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(90),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: (size.width / 7)),
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                      // color: ThemeData.from(colorScheme: ColorScheme.light()),
                                      // color: profilePageColordark,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black
                                          : Colors.white,

                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: size.width / 2 - size.width / 7,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(userData["image path"]),
                                    radius: size.width / 7,
                                  )),
                              Positioned(
                                bottom: 10,
                                child: SizedBox(
                                  width: size.width,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '210M',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            'Followers',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      SizedBox(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '500',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            'Following',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    UserDetails(
                        size: size,
                        userName: userData["full name"],
                        bio: userData["bio"],
                        buttonText: 'Edit profile'),
                  ];
                },
                body:  FutureBuilder<List<PostModel>>(
          future: userProvider.fetchCurrentUserPosts(userData["username"]),
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

              return 
                
                
                  Column(
                  children: [
                    Expanded(
                        child: DefaultTabController(
                            length: 1,
                            child: Column(
                              children: [
                                const TabBar(tabs: [
                                  Tab(
                                    text: 'Photos',
                                  ),
                                  // Tab(
                                  //   text: 'Videos',
                                  // )
                                ]),
                                Expanded(
                                    child: TabBarView(children: [
                                  ProfileGridView(posts: posts!,
                                    itemCount: posts.length,
                                  ),
                                  // const ProfileGridView(
                                  //   itemCount: 0,posts: [],
                                  // ),
                                ]))
                              ],
                            )))
                  ],
                );}})
              ),
            );
          } else {
            return const Text('data');
          }
        });
  }
}
