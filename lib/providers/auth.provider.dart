import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jii_comic_mobile/models/user.model.dart';
import 'package:jii_comic_mobile/screens/home.screen.dart';
import 'package:jii_comic_mobile/screens/profile.screen.dart';
import 'package:jii_comic_mobile/services/user.service.dart';

class AuthProvider extends ChangeNotifier {
  final UserService userService = UserService();
  User? _currentUser;
  String? _accessToken;

  User? get currentUser => _currentUser;

  String? get accessToken => _accessToken;

  void removeSession() {
    _currentUser = null;
    _accessToken = null;

    notifyListeners();
  }

  void logout(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Alo?"),
        content: Text("Bạn thật sự muốn đăng xuất?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy')),
          TextButton(
            child: const Text('Đăng xuất', style: TextStyle(color: Colors.red)),
            onPressed: () {
              removeSession();

              Navigator.of(context).pushNamedAndRemoveUntil(
                  ProfileScreen.routeName, (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
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
        _accessToken = resData["access_token"];
        notifyListeners();

        return Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName, (Route<dynamic> route) => false);
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
