import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String avatarUrl;
  final double radius;

  const Avatar({required this.avatarUrl, required this.radius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: (avatarUrl == null || avatarUrl == "null")
            ? CircleAvatar(
                radius: radius,
                backgroundImage: AssetImage('assets/images/greeting-bg.jpg'),
              )
            : CircleAvatar(
                radius: radius,
                backgroundImage: NetworkImage(avatarUrl),
              ),
      ),
    );
  }
}
