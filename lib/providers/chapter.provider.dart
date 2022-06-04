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

class ChaptersProvider extends ChangeNotifier {
  ComicsService comicsService = ComicsService();
  String? _nextChapterId;
  String? _prevChapterId;

  String? get prevChapterId => _prevChapterId;
  String? get nextChapterId => _nextChapterId;

  Future<List<Chapter>> getChapters({required String comicId}) async {
    final res = await comicsService.getChapters(comicId: comicId);

    final resData = json.decode(res.body);

    return List.from(resData).map((e) => Chapter.fromJson(e)).toList();
  }

  Future<dynamic> getChapter(context,
      {required String comicId, required String chapterId}) async {
    final res = await comicsService.getChapter(context,
        comicId: comicId, chapterId: chapterId);
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

    _nextChapterId = resData["nextChapter"]?["chapter_id"];
    _prevChapterId = resData["prevChapter"]?["chapter_id"];
    notifyListeners();

    return Chapter.fromJson(resData["currentChapter"]);
  }
}
