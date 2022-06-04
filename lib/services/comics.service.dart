import 'dart:convert';

import 'package:http/http.dart';
import 'package:jii_comic_mobile/utils/api_constants.dart';

class ComicsService {
  Future<Response> getComics(
      {String? query, String? order, String? orderBy, int? limit}) async {
    final reqQuery = Uri(queryParameters: {
      "query": query ?? "",
      "order": order,
      "orderBy": orderBy,
      "limit": limit?.toString() ?? ""
    }).query;
    final url = Uri.parse("$API_HOST${AuthRoutes.getComics}?$reqQuery");

    print(url.toString());

    final Response response = await get(
      url,
      headers: {"Content-Type": "application/json", "api-key": API_KEY},
    );

    print('Status code: ${response.statusCode}');
    print("Data: ${response.body}");

    return response;
  }

  Future<Response> getComic({required String comicId}) async {
    final url = Uri.parse("$API_HOST${AuthRoutes.getComic(comicId: comicId)}");

    print(url.toString());

    final Response response = await get(
      url,
      headers: {"Content-Type": "application/json", "api-key": API_KEY},
    );

    print('Status code: ${response.statusCode}');
    print("Data: ${response.body}");

    return response;
  }

  Future<Response> getChapters({required String comicId}) async {
    final url =
        Uri.parse("$API_HOST${AuthRoutes.getChapters(comicId: comicId)}");

    print(url.toString());

    final Response response = await get(
      url,
      headers: {"Content-Type": "application/json", "api-key": API_KEY},
    );

    print('Status code: ${response.statusCode}');
    print("Data: ${response.body}");

    return response;
  }

  Future<Response> getChapter(context,
      {required String comicId, required String chapterId}) async {
    final url = Uri.parse(
        "$API_HOST${AuthRoutes.getChapter(comicId: comicId, chapterId: chapterId)}");

    print(url.toString());

    final Response response = await get(
      url,
      headers: {"Content-Type": "application/json", "api-key": API_KEY},
    );

    print('Status code: ${response.statusCode}');
    print("Data: ${response.body}");

    return response;
  }
}
