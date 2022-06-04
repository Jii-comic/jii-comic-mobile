import 'dart:convert';

import 'package:http/http.dart';
import 'package:jii_comic_mobile/utils/api_constants.dart';

class UserService {
  Future<Response> login(
      {required String email, required String password}) async {
    final url = Uri.parse(API_HOST + AuthRoutes.login);

    try {
      final Response response = await post(
        url,
        body: json.encode(
          {"email": email, "password": password},
        ),
        headers: {"Content-Type": "application/json", "api-key": API_KEY},
      );
      final data = json.decode(response.body);

      print('Status code: ${response.statusCode}');
      print('Data: $data');

      return response;
    } catch (e) {
      rethrow;
    }
  }
}