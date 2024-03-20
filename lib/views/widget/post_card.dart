import 'package:flutter/material.dart';
import 'package:flutter_app/core/color.dart';
import 'package:flutter_app/model/post/post_model.dart';
import 'package:flutter_app/controller/datetime/date_time_format.dart';

Widget postCard(Size size, PostModel post) {
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
            title: Text(post.username),
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
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              '${post.likes.length} likes',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              post.caption != null ? post.caption.toString() : "",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              formatDateTime(post.timestamp),
              style: const TextStyle(fontSize: 16, color: kGreyColor),
            ),
          )
        ],
      ),
    ),
  );
}
