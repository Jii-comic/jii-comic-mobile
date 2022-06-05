import 'dart:convert';

import 'package:http/http.dart';
import 'package:jii_comic_mobile/utils/api_constants.dart';

class GenresService {
  Future<Response> getGenres(
      {String? order, String? orderBy, int? limit}) async {
    final url = Uri.parse("$API_HOST${ApiRoutes.getGenres}");

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
