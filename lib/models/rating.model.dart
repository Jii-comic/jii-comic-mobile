import 'package:jii_comic_mobile/models/user.model.dart';

class Rating {
  String? ratingId;
  int? ratingScore;
  String? createdAt;
  String? updatedAt;
  late User user;
  String? content;

  Rating(
      {this.ratingId,
      this.ratingScore,
      this.createdAt,
      this.updatedAt,
      required this.content,
      required this.user});

  Rating.fromJson(Map<String, dynamic> json) {
    content = json["content"];
    ratingId = json['rating_id'];
    ratingScore = json['rating_score'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = User.fromJson(json['user']);
  }
}
