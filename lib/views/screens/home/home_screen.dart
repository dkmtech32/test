import 'package:flutter/material.dart';

import 'package:flutter_app/views/widget/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: Image.asset(
            'assets/images/glitzUp logo.png',
            width: size.width * 0.33,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.messenger_outline_rounded),
          ),
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