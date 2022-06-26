import 'package:jii_comic_mobile/models/user.model.dart';

class Rating {
  String? ratingId;
  double? ratingScore;
  late DateTime createdAt;
  late DateTime updatedAt;
  late User user;
  String? content;

  Rating(
      {this.ratingId,
      this.ratingScore,
      required this.createdAt,
      required this.updatedAt,
      required this.content,
      required this.user});

  Rating.fromJson(Map<String, dynamic> json) {
    content = json["content"];
    ratingId = json['rating_id'];
    ratingScore = double.parse(json['rating_score'].toString());
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    user = User.fromJson(json['user']);
  }
}
