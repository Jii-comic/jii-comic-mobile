import 'dart:convert';

import 'package:http/http.dart';
import 'package:jii_comic_mobile/utils/api_constants.dart';

class UserService {
  Future<Response> login(
      {required String email, required String password}) async {
    final url = Uri.parse(API_HOST + ApiRoutes.login);

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
  }

  Future<Response> register({required dynamic registerData}) async {
    final url = Uri.parse(API_HOST + ApiRoutes.register);

    final Response response = await post(
      url,
      body: json.encode(registerData),
      headers: {"Content-Type": "application/json", "api-key": API_KEY},
    );
    final data = json.decode(response.body);

    print('Status code: ${response.statusCode}');
    print('Data: $data');

    return response;
  }

  Future<Response> loginUsingAccessToken({required String accessToken}) async {
    final url = Uri.parse(API_HOST + ApiRoutes.verifyToken);

    print(url.toString());

    try {
      final Response response = await post(
        url,
        headers: {
          "Content-Type": "application/json",
          "api-key": API_KEY,
          "authorization": "Bearer $accessToken"
        },
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
