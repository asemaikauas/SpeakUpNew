class UserModel {
  String userId;
  String displayName;
  String email;
  String password;
  String photoURL;

  UserModel({
    required this.displayName,
    required this.userId,
    required this.email,
    required this.password,
    required this.photoURL,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['displayName'],
      email: json['email'],
      password: json['password'],
      photoURL: json['photoURL'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['userId'] = userId;
    data['email'] = email;
    data['password'] = password;
    data['photoURL'] = photoURL;
    return data;
  }
}
