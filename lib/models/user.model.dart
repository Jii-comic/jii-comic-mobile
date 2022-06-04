class User {
  String? userId;
  String? email;
  String? name;
  String? avatarUrl;

  User({this.userId, this.email, this.name, this.avatarUrl});

  factory User.fromJson(dynamic json) {
    return User(
      userId: json["user_id"],
      email: json["email"],
      name: json["name"],
      avatarUrl: json["avatarUrl"],
    );
  }
}
