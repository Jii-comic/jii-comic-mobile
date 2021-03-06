import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/models/setting.model.dart';
import 'package:jii_comic_mobile/models/user.model.dart';
import 'package:jii_comic_mobile/providers/auth.provider.dart';
import 'package:jii_comic_mobile/screens/login.screen.dart';
import 'package:jii_comic_mobile/screens/register.screen.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';
import 'package:jii_comic_mobile/utils/settings_constants.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:jii_comic_mobile/screens/update_profile.screen.dart';
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
  _goTo({required String route}) {
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = Provider.of<AuthProvider>(context).currentUser;

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
          if (currentUser != null)
            IconButton(
              onPressed: _handleLogout,
              icon: FaIcon(
                FontAwesomeIcons.arrowRightFromBracket,
                size: 20,
              ),
              color: Colors.black,
            )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: currentUser != null
              ? [_renderUser(user: currentUser), _renderUserSettings()]
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
            "B???n ch??a ????ng nh???p. Vui l??ng ????ng nh???p ho???c ????ng k?? t??i kho???n ????? ???????c tr???i nghi???m ?????y ?????!"),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: PrimaryButton(
                child: Text("????ng nh???p"),
                onPressed: () => _goTo(route: LoginScreen.routeName),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: SecondaryButton(
                child: Text(
                  "????ng k??",
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

  Widget _renderUser({required User user}) {
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
                user.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  user.email,
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
            "Ca??i ??????t ta??i khoa??n",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _renderSettingsItem(context,
                  setting: Settings.personalInfo);
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: 1,
          )
        ],
      ),
    );
  }

  Widget _renderSettingsItem(context, {required Setting setting}) {
    return ListTile(
      dense: true,
      onTap: () => setting.onPressed,
      leading: FaIcon(
        setting.icon,
        color: ColorConstants.regularColor,
        size: 20,
      ),
      title: Text(setting.title, style: TextStyle(fontSize: 16)),
    );
  }
}
