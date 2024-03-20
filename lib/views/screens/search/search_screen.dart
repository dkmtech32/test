import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controller/search/search_controller.dart';
import 'package:flutter_app/model/user/user_model.dart';

import 'package:flutter_app/views/widget/user_title.dart';
import 'package:get/get.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchQueryController searchQueryController =
        Get.put(SearchQueryController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            CupertinoSearchTextField(
              controller: searchQueryController.searchController,
              onChanged: (value) => searchQueryController.searchUser(value),
              backgroundColor: Color.fromARGB(255, 65, 64, 64),
              
            ),
            Expanded(
              child: SizedBox(child: Obx(() {
                List<UserModel> searchResults =
                    searchQueryController.users.toList();
                return ListView.builder(
                  itemCount:searchResults.length,
                  itemBuilder: (context, index) {
                    return UserTitle(
                      text: searchResults[index].userName,
                    );
                  },
                );
              })),
            )
          ],
        ),
      ),
    );
  }
}