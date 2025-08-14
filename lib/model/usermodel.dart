class UserModel {
  final String userId;
  final String email;
  final String userType;
  final List<String> categories;
  final List<String> interests;

  UserModel({
    required this.userId,
    required this.email,
    required this.userType,
    required this.categories,
    required this.interests,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'userType': userType,
      'categories': categories,
      'interests': interests,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      userType: map['userType'] ?? '',
      categories: List<String>.from(map['categories'] ?? []),
      interests: List<String>.from(map['interests'] ?? []),
    );
  }
}
