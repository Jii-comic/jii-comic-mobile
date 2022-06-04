import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/models/setting.model.dart';
import 'package:jii_comic_mobile/models/user.model.dart';
import 'package:jii_comic_mobile/providers/auth.provider.dart';
import 'package:jii_comic_mobile/screens/login.screen.dart';
import 'package:jii_comic_mobile/screens/register.screen.dart';
import 'package:jii_comic_mobile/utils/settings_constants.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:jii_comic_mobile/screens/updateProfile.screen.dart';
import 'package:jii_comic_mobile/widgets/custom_bottom_navigation_bar.dart';
import 'package:jii_comic_mobile/widgets/secondary_btn.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _currentUser;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushNamed(context, "/updateProfile");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        setState(
          () {
            _currentUser =
                Provider.of<AuthProvider>(context, listen: false).currentUser;
          },
        );
      },
    );
  }

  _goTo({required String route}) {
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    void _handleLogout() {
      Provider.of<AuthProvider>(context, listen: false).logout(context);
    }

    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          if (_currentUser != null)
            IconButton(
              onPressed: _handleLogout,
              icon: FaIcon(
                FontAwesomeIcons.arrowRightFromBracket,
                size: 24,
              ),
              color: Colors.black,
            )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _currentUser != null
              ? [_renderUser(), _renderUserSettings()]
              : [_renderGuest()],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        activeRoute: ProfileScreen.routeName,
      ),
    );
  }

  Widget _renderGuest() {
    return Column(
      children: [
        Text(
            "Bạn chưa đăng nhập. Vui lòng đăng nhập hoặc đăng kí tài khoản để được trải nghiệm đầy đủ!"),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                child: Text("Đăng nhập"),
                onPressed: () => _goTo(route: LoginScreen.routeName),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: SecondaryButton(
                child: Text(
                  "Đăng kí",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => _goTo(route: RegisterScreen.routeName),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _renderUser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/greeting-bg.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _currentUser?.name ?? "",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  _currentUser?.email ?? "",
                  style: TextStyle(
                      fontSize: 12, color: Color.fromRGBO(0, 0, 0, 0.38)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _renderUserSettings() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cài đặt tài khoản",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          _renderSettingsItem(context, setting: Settings.personalInfo)
        ],
      ),
    );
  }

  Widget _renderSettingsItem(context, {required Setting setting}) {
    return ListTile(
      onTap: () => setting.onPressed,
      leading: FaIcon(setting.icon),
      title: Text(setting.title),
    );
  }
}
