import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/models/user.model.dart';
import 'package:jii_comic_mobile/providers/auth.provider.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:jii_comic_mobile/screens/updateProfile.screen.dart';
import 'package:jii_comic_mobile/widgets/custom_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushNamed(context, "/updateProfile");
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<AuthProvider>(context).currentUser;

    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          iconSize: 24,
          color: Colors.black,
          onPressed: () {},
        ),
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              size: 24,
            ),
            color: Colors.black,
          )
        ],
      ),
      body: getBody(),
      bottomNavigationBar: CustomBottomNavigationBar(
        activeRoute: ProfileScreen.routeName,
      ),
    );
  }

  Widget getBody() {
    return ClipPath(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffeeeeee),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/greeting-bg.jpg'),
                        fit: BoxFit.cover)),
              ),
              Container(
                padding: EdgeInsets.only(top: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          "myEmail@gmail.com",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(0, 0, 0, 0.38)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: _setting(),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _setting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cài đặt tài khoản",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: _settingItem(context))
      ],
    );
  }
}

Widget _settingItem(context) {
  return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/updateProfile");
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.userCircle,
                  size: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Thông tin cá nhân",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 16,
            ),
          ]),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Divider(),
          ),
        ],
      ));
}
