class PostModel {
  final String? postId;
  final String username;
  final String imageUrl;
  final String? caption;
  final DateTime timestamp;
  final List<String> likes;
  final List<Comment> comments;

  PostModel({
    this.postId,
    required this.username,
    required this.imageUrl,
    this.caption,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });
}

class Comment {
  final String postId;
  final String username;
  final String text;
  final DateTime timestamp;

  Comment(
      {required this.postId,
      required this.username,
      required this.text,
      required this.timestamp});
}