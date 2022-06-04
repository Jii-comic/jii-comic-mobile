import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jii_comic_mobile/models/comicDetailProps.dart';
import 'package:jii_comic_mobile/screens/detail.screen.dart';

class ComicCard extends StatelessWidget {
  const ComicCard(
      {Key? key,
      required this.comicId,
      required this.title,
      required this.desc,
      this.thumbnailUrl})
      : super(key: key);

  final String title;
  final String desc;
  final String? thumbnailUrl;
  final String comicId;

  @override
  Widget build(BuildContext context) {
    void _goToComic() => Navigator.of(context).pushNamed(DetailScreen.routeName,
        arguments: ComicDetailProps(comicId: comicId));

    return InkWell(
      onTap: () => _goToComic(),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(thumbnailUrl ??
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      desc,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12, color: Colors.white.withOpacity(0.78)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
