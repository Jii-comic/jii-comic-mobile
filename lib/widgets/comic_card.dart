import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComicCard extends StatelessWidget {
  const ComicCard({Key? key, required this.title, required this.desc})
      : super(key: key);

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Stack(
        children: [
          Container(
            width: 136,
            height: 204,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "http://res.cloudinary.com/ddkz3f3xa/image/upload/v1653370609/cwn2qfht5irwzqw5o7d7.jpg"),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    desc,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 12, color: Colors.white.withOpacity(0.78)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
