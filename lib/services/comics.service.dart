import 'dart:convert';

import 'package:http/http.dart';
import 'package:jii_comic_mobile/utils/api_constants.dart';

class ComicsService {
  Future<Response> checkFollow(
      {required String comicId, required String accessToken}) async {
    final url =
        Uri.parse("$API_HOST${ApiRoutes.checkFollow(comicId: comicId)}");

    print(url.toString());

    final Response response = await get(
      url,
      headers: {
        "Content-Type": "application/json",
        "api-key": API_KEY,
        "authorization": "Bearer $accessToken"
      },
    );

    print('Status code: ${response.statusCode}');
    print("Data: ${response.body}");

    return response;
  }

  Future<Response> follow(
      {required String comicId, required String accessToken}) async {
    final url =
        Uri.parse("$API_HOST${ApiRoutes.followComic(comicId: comicId)}");

    print(url.toString());

    final Response response = await get(
      url,
      headers: {
        "Content-Type": "application/json",
        "api-key": API_KEY,
        "authorization": "Bearer $accessToken"
      },
    );

    print('Status code: ${response.statusCode}');
    print("Data: ${response.body}");

    return response;
  }

  Future<Response> getComics(
      {String? query, String? order, String? orderBy, int? limit, String? accessToken, bool isFollowing = false}) async {
    final reqQuery = Uri(queryParameters: {
      "query": query ?? "",
      "order": order,
      "orderBy": orderBy,
      "limit": limit?.toString() ?? ""
    }).query;

    Uri url = Uri.parse("$API_HOST${ApiRoutes.getComics}?$reqQuery");
    if (isFollowing) {
      url = Uri.parse("$API_HOST${ApiRoutes.getComics}/following?$reqQuery");
    }

    print(url.toString());

    final Response response = await get(
      url,
      headers: {
        "Content-Type": "application/json", 
        "api-key": API_KEY, 
        "Authorization": "Bearer ${accessToken ?? ""}"
      },
    );

    print('Status code: ${response.statusCode}');
    print("Data: ${response.body}");

    return response;
  }

  Future<Response> getComic({required String comicId}) async {
    final url = Uri.parse("$API_HOST${ApiRoutes.getComic(comicId: comicId)}");

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
        Uri.parse("$API_HOST${ApiRoutes.getChapters(comicId: comicId)}");

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
        "$API_HOST${ApiRoutes.getChapter(comicId: comicId, chapterId: chapterId)}");

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
