class UserModel {
  final String? id;
  final String fullName;
  final String userName;
  final String profilePic;
  final String coverImage;
  final String address;
  final DateTime? dob; 
  final String? bio;
  // final List<String> likedPosts;

  UserModel({
    this.id,
    required this.fullName,
    required this.userName,
    required this.profilePic,
    required this.coverImage,
    required this.address,
    required this.dob,
    // required this.likedPosts,
    this.bio,
  });

  toJson() {
    return {
      "full name": fullName,
      "username": userName,
      "bio": bio,
      "image path": profilePic,
      "cover image": coverImage,
      // "liked posts": likedPosts,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        bio: json['bio'],
        fullName: json['full name'],
        userName: json['username'],
        profilePic: json['image path'],
        coverImage: json['cover image'],
        address: json['address'],
        dob: json['dob'],
      );
  }
}
