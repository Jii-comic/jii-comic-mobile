class RatingProps {
  final String comicId;
  final String? ratingId;
  final double? ratingScore;
  final String? content;

  RatingProps(
      {required this.comicId, this.ratingId, this.ratingScore, this.content});
}
