
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