import 'package:flutter/material.dart';
import 'package:flutter_app/views/widget/profile_page_button.dart';

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
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: CustomScrollView(
        slivers: [
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
                          decoration:  BoxDecoration(
                            // color: ThemeData.from(colorScheme: ColorScheme.light()),
                            // color: profilePageColordark,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,

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
          SliverToBoxAdapter(
            child: Container(
              decoration:  BoxDecoration(
                
                // color: Brightness==Brightness.light? profilePageColorLight : profilePageColordark,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
              ),
              height: size.height,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'UserName',
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width * .7,
                    child: const Center(
                      child: Text(
                          'Your Instagram bio is a short description on your profile that tells people about you. This description is the Instagram equivalent to a 30-second elevator pitch '),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ProfilePageButton(text: 'Edit profile')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

