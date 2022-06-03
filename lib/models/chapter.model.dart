import 'package:jii_comic_mobile/models/comic.model.dart';

class Chapter {
  Chapter({
    required this.chapterId,
    required this.name,
    this.pages,
    required this.createdAt,
    required this.updatedAt,
    this.comic,
  });
  late final String chapterId;
  late final String name;
  late final List<String>? pages;
  late final DateTime createdAt;
  late final DateTime updatedAt;
  Comic? comic;

  Chapter.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapter_id'];
    name = json['name'];
    pages = List.castFrom<dynamic, String>(json['pages'] ?? []);
    createdAt = DateTime.parse(json['created_at'] ?? "");
    updatedAt = DateTime.parse(json['updated_at'] ?? "");
    if (json["comic"] != null) {
      comic = Comic.fromJson(json["comic"]);
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['chapter_id'] = chapterId;
    _data['name'] = name;
    _data['pages'] = pages;
    _data['created_at'] = createdAt.toString();
    _data['updated_at'] = updatedAt.toString();
    _data['comic'] = comic?.toJson();
    return _data;
  }
}
