import 'package:flutter/material.dart';
import 'package:flutter_app/model/user/user_model.dart';
import 'package:flutter_app/services/search/search.dart';
import 'package:get/get.dart';


class SearchQueryController extends GetxController {
  final RxList<UserModel> users = <UserModel>[].obs;
  final SearchService _searchService = SearchService();
  TextEditingController searchController = TextEditingController();

  void searchUser(String searchQuery) async {
    print(searchQuery);
    users.clear();

      _searchService.fetchSearchDetails(searchQuery, users);



  }
}