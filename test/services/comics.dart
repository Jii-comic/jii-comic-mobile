// Import the test package and Counter class
import 'dart:convert';

import 'package:http/http.dart';
import 'package:jii_comic_mobile/services/comics.service.dart';
import 'package:test/test.dart';

void main() {
  test('Get comic list', () async {
    final comicService = ComicsService();

    final Response res = await comicService.getComics();
    final resData = json.decode(res.body);

    print(resData);

    // expect(counter.value, 1);
  });
}
