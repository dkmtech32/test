import 'package:flutter/material.dart';
import 'package:flutter_app/sport_scape_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  @override
  NavBarBottom createState() => NavBarBottom();
}
