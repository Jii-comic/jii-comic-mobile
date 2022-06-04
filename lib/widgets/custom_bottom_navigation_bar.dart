import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:jii_comic_mobile/models/comic.model.dart';
import 'package:jii_comic_mobile/screens/comics.screen.dart';
import 'package:jii_comic_mobile/screens/home.screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final String? activeRoute;
  final List<dynamic>? navList;

  CustomBottomNavigationBar({
    this.activeRoute,
    this.navList,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  List<dynamic> _navList = [
    {
      "icon": FontAwesomeIcons.house,
      "title": "HOME",
      "route": HomeScreen.routeName
    },
    {
      "icon": FontAwesomeIcons.list,
      "title": "MANGA",
      "route": ComicsScreen.routeName
    },
    {
      "icon": FontAwesomeIcons.solidBookmark,
      "title": "MY LIST",
    },
    {
      "icon": FontAwesomeIcons.solidUser,
      "title": "PROFILE",
    },
  ];

  _goTo({String? routeName}) {
    if (routeName == null || widget.activeRoute == routeName) {
      return;
    }
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.navList != null) {
      _navList = widget.navList!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      child: Row(
        children: _navList.map((e) => _buildNavBarItem(e)).toList(),
      ),
    );
  }

  Widget _buildNavBarItem(navItem) {
    return GestureDetector(
      onTap: () => _goTo(routeName: navItem["route"]),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / _navList.length,
        decoration: navItem["route"] == widget.activeRoute
            ? BoxDecoration(
                gradient: Gradients.buildGradient(
                    Alignment.centerLeft, Alignment.topRight, [
                Color(0xffEE9D00),
                Color(0xffFF0000),
              ])
                // color: index == _selectedItemIndex ? Colors.green : Colors.white,
                )
            : BoxDecoration(
                color: Colors.white,
              ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              navItem["icon"],
              color: navItem["route"] == widget.activeRoute
                  ? Colors.white
                  : Colors.black,
              size: 24,
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(navItem["title"],
                  style: TextStyle(
                    color: navItem["route"] == widget.activeRoute
                        ? Colors.white
                        : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ],
        )),
        // child: icon,
      ),
    );
  }
}
