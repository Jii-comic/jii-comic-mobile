import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/widgets/comic_list.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = "/";
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String description = "Lorem Ipsum Dono";

  List chapters = [
    "chapter1",
    "chapter2",
    "chapter3",
    "chapter4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Jii Comic"),
        actions: [
          IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.search))
        ],
      ),
      body: Column(
        children: [
          _renderHighlightedComic(),
          Container(
            width: double.infinity,
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "http://res.cloudinary.com/ddkz3f3xa/image/upload/v1653370609/cwn2qfht5irwzqw5o7d7.jpg")),
              ),
              itemCount: 12,
              separatorBuilder: (context, index) => SizedBox(
                width: 4,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _description(description),
                    _chapterList(chapters),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: ComicList(
                        title: "Các truyện cùng thể loại",
                        hasMore: false,
                      ),
                    ),
                  ],
                ),
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
            padding: EdgeInsets.only(top: 104, left: 16, right: 16, bottom: 16),
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
}

Widget _description(String description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.only(bottom: 8),
        child: Text("Mô tả"),
      ),
      Container(
        padding: EdgeInsets.only(bottom: 8),
        child: Text(description),
      ),
    ],
  );
}

Widget _chapterList(List chapters) {
  const latest_update = "23 phút";

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Số tập: ${chapters.length}"),
      Text("Cập nhật $latest_update} trước"),
      ListView(
        children: chapters
            .map((chapter) => ListTile(
                  leading: Image.network(
                      "http://res.cloudinary.com/ddkz3f3xa/image/upload/v1653370609/cwn2qfht5irwzqw5o7d7.jpg"),
                  title: chapter,
                ))
            .toList(),
      )
    ],
  );
}