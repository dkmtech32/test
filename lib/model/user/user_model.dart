class UserModel {
  final String? id;
  final String fullName;
  final String userName;
  final String imagePath;
  final String? bio;

  UserModel({
    this.id,
    required this.fullName,
    required this.userName,
    required this.imagePath,
    this.bio,
  });


  toJson(){
    return {
      "full name": fullName,
      "username": userName,
      "bio": bio,
      "image path": imagePath,
    };
  }
}