import 'package:flutter/material.dart';
import 'package:flutter_app/core/color.dart';

Widget postCard(Size size) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: size.width,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.amber,
            ),
            title: const Text('username'),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                )),
          ),
          Container(
            height: 280,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/sachin.jpeg',
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20)),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_outline,
                    size: 28,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.comment_bank_outlined,
                    size: 28,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    size: 28,
                  )),
              //   SizedBox(
              //     width: 10,
              //   ),
              //   Icon(
              //     Icons.favorite_border,size: 30,
              //   ),
              //   SizedBox(
              //     width: 8,
              //   ),
              //   Icon(Icons.comment_bank_outlined,size: 30,),
              //   SizedBox(
              //     width: 8,
              //   ),
              //  Transform.rotate(
              //   angle: -45 * 0.0174533,
              //   child: Icon(Icons.send_rounded,size: 30,)),
              const Spacer(),
              // Icon(Icons.bookmark_border,size: 30,),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border,
                    size: 28,
                  )),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '200 likes',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Caption of the post',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '15 minutes ago',
              style: TextStyle(fontSize: 16, color: kGreyColor),
            ),
          )
        ],
      ),
    ),
  );
}
