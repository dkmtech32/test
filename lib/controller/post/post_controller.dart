import 'package:flutter_app/model/post/post_model.dart';
import 'package:get/get.dart';
import 'package:flutter_app/services/post/post.dart';
import 'package:flutter_app/model/comment/comment_model.dart';

class PostController extends GetxController {
  final FireBasePostService _fireBasePostService = FireBasePostService();
  List<CommentModel> comments = <CommentModel>[].obs;
  List<PostModel> userPosts = <PostModel>[].obs;

  var isFavourite = false.obs;
  var likesCount = 0.obs;

  void fetchIsLiked(PostModel post, String emailId) {
    isFavourite.value = post.likes.contains(emailId);
    likesCount.value = post.likes.length;
  }

  void likeButtonClicked(
      String postId, String currentUserEmailId, PostModel post) async {
    // isFavourite.value = post.likes.contains(currentUserEmailId);
    if (isFavourite.value) {
      isFavourite.value = !isFavourite.value;
      likesCount.value =
          await _fireBasePostService.postUnliked(postId, currentUserEmailId);
      // updateLikesCount(likesCount.value);
      print('controller called');
    } else {
      isFavourite.value = !isFavourite.value;
      likesCount.value =
          await _fireBasePostService.postLiked(postId, currentUserEmailId);
      // updateLikesCount(likesCount.value);
      print('controller called');
    }
  }

  void commentButtonClicked(String postId) {
    // List<CommentModel> comments =
    _fireBasePostService.fetchComments(postId, comments);
    // return comments;
  }

  void postComment(CommentModel comment, String postId) async {
    await _fireBasePostService.addComment(comment, postId);
    commentButtonClicked(postId);
  }
   void otherUserPosts(String username)async{

   await _fireBasePostService.fetchUserPosts(username, userPosts);
  }
}
