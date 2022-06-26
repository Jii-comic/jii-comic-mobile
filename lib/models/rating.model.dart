import 'package:jii_comic_mobile/models/user.model.dart';

class Rating {
  String? ratingId;
  int? ratingScore;
  String? createdAt;
  String? updatedAt;
  User? user;

  Rating(
      {this.ratingId,
      this.ratingScore,
      this.createdAt,
      this.updatedAt,
      this.user});

  Rating.fromJson(Map<String, dynamic> json) {
    ratingId = json['rating_id'];
    ratingScore = json['rating_score'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}
