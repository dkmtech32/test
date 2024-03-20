class UserModel {
  final String? id;
  final String email;
  final String fullName;
  final String userName;
  final String profilePic;
  final String coverImage;
  final String? bio;
  final List<String> likedPosts;

  UserModel({
    required this.email,
    this.id,
    required this.fullName,
    required this.userName,
    required this.profilePic,
    required this.coverImage,
    required this.likedPosts,
    this.bio,
  });

  toJson() {
    return {
      "email": email,
      "full name": fullName,
      "username": userName,
      "bio": bio,
      "image path": profilePic,
      "cover image": coverImage,
      "liked posts": likedPosts,
    };
  }
}
