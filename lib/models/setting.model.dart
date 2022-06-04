import 'package:flutter/cupertino.dart';

class Setting {
  IconData icon;
  String title;
  void onPressed;

  Setting({required this.onPressed, required this.title, required this.icon});
}
