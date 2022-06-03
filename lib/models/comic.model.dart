import 'package:jii_comic_mobile/models/chapter.model.dart';
import 'package:jii_comic_mobile/models/genre.model.dart';

class Comic {
  Comic(
      {required this.comicId,
      required this.name,
      this.description,
      this.thumbnailUrl,
      this.coverUrl,
      required this.createdAt,
      required this.updatedAt,
      required this.genres,
      this.chapters});

  late final List<Chapter>? chapters;
  late final String comicId;
  late final String name;
  late final String? description;
  late final String? thumbnailUrl;
  late final String? coverUrl;
  late final DateTime createdAt;
  late final DateTime updatedAt;
  List<Genre>? genres;

  Comic.fromJson(Map<String, dynamic> json) {
    comicId = json['comic_id'];
    name = json['name'];
    description = json['description'];
    thumbnailUrl = json['thumbnailUrl'];
    coverUrl = null;
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);

    print(json["genres"]);
    if (json['genres'] != null) {
      genres = List.from(json['genres']).map((e) => Genre.fromJson(e)).toList();
    }

    if (json["chapters"] != null) {
      chapters =
          List.from(json['chapters']).map((e) => Chapter.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['comic_id'] = comicId;
    _data['name'] = name;
    _data['description'] = description;
    _data['thumbnailUrl'] = thumbnailUrl;
    _data['coverUrl'] = coverUrl;
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    _data['genres'] = genres?.map((e) => e.toJson()).toList();
    _data['chapters'] = chapters?.map((e) => e.toJson()).toList();
    return _data;
  }
}
