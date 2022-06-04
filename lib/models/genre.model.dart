class Genre {
  Genre({
    required this.genreId,
    required this.name,
    this.description,
  });
  late final String genreId;
  late final String name;
  late final String? description;

  Genre.fromJson(Map<String, dynamic> json) {
    genreId = json['genre_id'];
    name = json['name'];
    description = json['description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['genre_id'] = genreId;
    _data['name'] = name;
    _data['description'] = description ?? "";
    return _data;
  }
}
