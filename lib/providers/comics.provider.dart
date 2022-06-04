import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jii_comic_mobile/models/chapter.model.dart';
import 'package:jii_comic_mobile/models/comic.model.dart';
import 'package:jii_comic_mobile/models/genre.model.dart';
import 'package:jii_comic_mobile/services/comics.service.dart';
import 'package:jii_comic_mobile/services/genres.service.dart';
import 'package:jii_comic_mobile/utils/api_constants.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';

class ComicsProvider extends ChangeNotifier {
  ComicsService comicsService = ComicsService();
  GenresService genresService = GenresService();

  Future<List<Comic>> getComics(
      {String? order, String? orderBy, int? limit, String? query}) async {
    final res = await comicsService.getComics(
        query: query, order: order, orderBy: orderBy, limit: limit);

    final resData = json.decode(res.body);

    return List.from(resData).map((e) => Comic.fromJson(e)).toList();
  }

  Future<dynamic> getComic(context, {required String comicId}) async {
    final res = await comicsService.getComic(comicId: comicId);
    final resData = json.decode(res.body);

    if (resData == "") {
      Navigator.of(context).pop();
      return showDialog(
        barrierDismissible: false, // prevent dismiss dialog
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Thông báo"),
          content: Text("Không tìm thấy truyện!"),
          actions: [
            TextButton(
              child: Text(
                'Quay lại',
                style: TextStyle(color: ColorConstants.solidColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
    return Comic.fromJson(resData);
  }

  Future<dynamic> getChapter(context,
      {required String comicId, required String chapterId}) async {
    final res =
        await comicsService.getChapter(comicId: comicId, chapterId: chapterId);
    final resData = json.decode(res.body);

    if (resData == "") {
      Navigator.of(context).pop();
      return showDialog(
        barrierDismissible: false, // prevent dismiss dialog
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Thông báo"),
          content: Text("Không tìm thấy tập!"),
          actions: [
            TextButton(
              child: Text(
                'Quay lại',
                style: TextStyle(color: ColorConstants.solidColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
    return Chapter.fromJson(resData);
  }

  Future<List<Genre>> getGenres() async {
    final res = await genresService.getGenres();

    final resData = json.decode(res.body);

    return List.from(resData).map((e) => Genre.fromJson(e)).toList();
  }
}
