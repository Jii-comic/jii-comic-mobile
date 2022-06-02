import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/widgets/comic_list.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:jii_comic_mobile/widgets/expandable_text.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = "/detail";
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String description =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  final chapters = [
    {
      "title": "chapter 1",
      "url":
          "http://res.cloudinary.com/ddkz3f3xa/image/upload/v1653370609/cwn2qfht5irwzqw5o7d7.jpg"
    },
    {
      "title": "chapter 2",
      "url":
          "http://res.cloudinary.com/ddkz3f3xa/image/upload/v1653370609/cwn2qfht5irwzqw5o7d7.jpg"
    },
    {
      "title": "chapter 3",
      "url":
          "http://res.cloudinary.com/ddkz3f3xa/image/upload/v1653370609/cwn2qfht5irwzqw5o7d7.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final lastUpdated = "23 phút";

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Jii Comic"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.bookmark))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderHighlightedComic(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _renderDescription(description),
                  SizedBox(height: 16),
                  Text(
                    "Số tập: ${chapters.length}",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    "Cập nhật $lastUpdated trước",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.6)),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  _renderChapterList(chapters: chapters)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _renderHighlightedComic() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: Stack(children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "http://res.cloudinary.com/ddkz3f3xa/image/upload/v1653370609/cwn2qfht5irwzqw5o7d7.jpg"),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          ),
        ),
        DefaultTextStyle(
          style: TextStyle(color: Colors.white),
          child: Container(
            margin: EdgeInsets.only(top: 88),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image(
                      width: 140,
                      height: 211,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "http://res.cloudinary.com/ddkz3f3xa/image/upload/v1653370609/cwn2qfht5irwzqw5o7d7.jpg"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Spy X Family",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 16),
                      Wrap(
                        spacing: 4,
                        children: [
                          _renderGenre(label: "Action"),
                          _renderGenre(label: "Comedy"),
                          _renderGenre(label: "Slice of life"),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text("Chapter: 13 / 21"),
                      // Spacer(),
                      SizedBox(height: 16),
                      PrimaryButton(
                          child: Text("Bắt đầu đọc".toUpperCase()),
                          onPressed: () {})
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _renderGenre({required String label}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        label,
        style: TextStyle(fontSize: 8),
      ),
    );
  }

  Widget _renderDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8),
          child: Text(
            "Mô tả",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        ExpandableText(text: description)
      ],
    );
  }

  Widget _renderChapterList({chapters = const []}) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: chapters
          .map<Widget>((chapter) => _renderChapter(chapter: chapter))
          .toList(),
    );
  }

  Widget _renderChapter({required chapter}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(chapter["url"]),
          ),
        ),
      ),
      title: Text(
        chapter["title"],
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        "2 phút trước",
        style: TextStyle(
          fontSize: 12,
          color: Color.fromRGBO(0, 0, 0, 0.6),
        ),
      ),
    );
  }
}

_onTapHandle() {}
