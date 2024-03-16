import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_app/views/widget/profile_grid_view.dart';
import 'package:flutter_app/views/widget/user_detail.dart';
import 'package:flutter_app/views/screens/auth/login_screen.dart';

import 'package:flutter_app/core/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'username',
        ),
        actions: [
          IconButton(
              onPressed: () async {
                googleSignIn.disconnect();

                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              // pinned: true,
              stretch: true,
              expandedHeight: 300,
              flexibleSpace: const FlexibleSpaceBar(
                stretchModes: [StretchMode.zoomBackground],
                background: Image(
                  image: AssetImage('assets/images/sachin.jpeg'),
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
                          padding: EdgeInsets.only(top: (size.width / 7)),
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
                            backgroundColor: Colors.red,
                            radius: size.width / 7,
                          )),
                      Positioned(
                        bottom: 10,
                        child: SizedBox(
                          width: size.width,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                userName: 'userName',
                bio: 'bio',
                buttonText: 'Edit profile'),
          ];
        },
        body: const Column(
          children: [
            Expanded(
                child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(tabs: [
                          Tab(
                            text: 'Photos',
                          ),
                          Tab(
                            text: 'Videos',
                          )
                        ]),
                        Expanded(
                            child: TabBarView(children: [
                          ProfileGridView(
                            itemCount: 30,
                          ),
                          ProfileGridView(
                            itemCount: 30,
                          ),
                        ]))
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
