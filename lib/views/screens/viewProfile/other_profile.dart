import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/post/post_controller.dart';
import 'package:flutter_app/model/user/user_model.dart';
import 'package:flutter_app/views/widget/profile_grid_view.dart';
import 'package:flutter_app/views/widget/user_detail.dart';
import 'package:get/get.dart';

class OtherUserProfile extends StatelessWidget {
  OtherUserProfile({
    Key? key,
    required this.profile,
  }) : super(key: key);
  final UserModel profile;

  PostController postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    postController.otherUserPosts(profile.userName);
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(profile.userName),
      //   centerTitle: true,
      // ),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                // pinned: true,
                stretch: true,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Image(
                    image: NetworkImage(profile.coverImage),
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
                              backgroundImage: NetworkImage(profile.profilePic),
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
                  userName: profile.userName,
                  bio: profile.bio!,
                  buttonText: 'Follow'),
            ];
          },
          body: Column(
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
                            Obx(
                              () => ProfileGridView(
                                posts: postController.userPosts,
                                itemCount: postController.userPosts.length,
                              ),
                            )
                          ]))
                        ],
                      )))
            ],
          )),
    );
  }
}
