import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jii_comic_mobile/utils/api_constants.dart';

class ComicsProvider extends ChangeNotifier {
  final List _comics = [];

  List get comics => _comics;
}
