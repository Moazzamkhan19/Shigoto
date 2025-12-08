class UserModel {
  final String userId;
  final String username;
  final String email;
  final String? photoUrl;   

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    this.photoUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      username: map['username'],
      email: map['email'],
      photoUrl: map['photoUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}
