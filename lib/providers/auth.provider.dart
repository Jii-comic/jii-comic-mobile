import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jii_comic_mobile/models/user.model.dart';
import 'package:jii_comic_mobile/screens/home.screen.dart';
import 'package:jii_comic_mobile/services/user.service.dart';

class AuthProvider extends ChangeNotifier {
  final UserService userService = UserService();
  User? _currentUser;

  User? get currentUser => _currentUser;

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  Future<dynamic> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    final Response res =
        await userService.login(email: email, password: password);
    final resData = json.decode(res.body);

    switch (res.statusCode) {
      case 201:
      case 200:
        _currentUser = User.fromJson(resData["user"]);
        notifyListeners();

        return Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      case 401:
        return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Thông báo"),
            content: Text(resData["errors"]?[0]),
          ),
        );
      default:
        return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Thông báo"),
            content: Text("Đã có lỗi từ phía server"),
          ),
        );
    }
  }
}
