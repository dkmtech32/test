import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/color.dart';
import 'package:flutter_app/core/constants.dart';
import 'package:flutter_app/model/user/user_model.dart';
import 'package:flutter_app/services/users/user_profile.dart';

UserModel? userData;

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    getUserDataByEmail(FirebaseAuth.instance.currentUser!.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          // fixedColor: kWhiteColor,
          unselectedItemColor: kGreyColor,
          selectedItemColor: Color.fromARGB(255, 9, 104, 107),
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: '\u2022'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '\u2022'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined), label: '\u2022'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none), label: '\u2022'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '\u2022')
          ]),
      body: SafeArea(child: screens[_currentIndex]),
    );
  }
}
