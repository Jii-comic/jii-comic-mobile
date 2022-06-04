// import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/widgets/comic_list.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:jii_comic_mobile/widgets/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List _iconList = [
    Icons.home,
    Icons.list,
    Icons.bookmark,
    Icons.person,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushNamed(context, "/detail");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Jii Comic"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.search))
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        iconList: [
          {
            "icon": FontAwesomeIcons.house,
            "title": "HOME",
          },
          {
            "icon": FontAwesomeIcons.list,
            "title": "MANGA",
          },
          {
            "icon": FontAwesomeIcons.solidBookmark,
            "title": "MY LIST",
          },
          {
            "icon": FontAwesomeIcons.solidUser,
            "title": "PROFILE",
          },
        ],
        onChange: (val) {
          setState(() {
            _selectedIndex = val;
          });
        },
        defaultSelectedIndex: 1,
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
                    ComicList(
                      title: "Mới",
                      hasMore: false,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ComicList(
                      title: "Tiếp tục cuộc hành trình còn dang dở",
                      hasMore: false,
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
                          child: Text("Đọc ngay".toUpperCase()),
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
