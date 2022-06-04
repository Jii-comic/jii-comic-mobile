import 'package:flutter/material.dart';
import 'package:jii_comic_mobile/providers/auth.provider.dart';
import 'package:jii_comic_mobile/providers/comics.provider.dart';
import 'package:jii_comic_mobile/screens/comics.screen.dart';
import 'package:jii_comic_mobile/screens/greeting.screen.dart';
import 'package:jii_comic_mobile/screens/home.screen.dart';
import 'package:jii_comic_mobile/screens/login.screen.dart';
import 'package:jii_comic_mobile/screens/reading.page.dart';
import 'package:jii_comic_mobile/screens/profile.screen.dart';
import 'package:jii_comic_mobile/screens/register.screen.dart';
import 'package:jii_comic_mobile/themes/default.theme.dart';
import 'package:jii_comic_mobile/screens/detail.screen.dart';
import 'package:jii_comic_mobile/screens/updateProfile.screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const JiiComic());
}

class JiiComic extends StatelessWidget {
  const JiiComic({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => AuthProvider()),
          ChangeNotifierProvider(
            create: (ctx) => ComicsProvider(),
          )
        ],
        child: MaterialApp(
          title: 'Jii Comic',
          theme: defaultTheme,
          initialRoute: ProfileScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            GreetingScreen.routeName: (context) => const GreetingScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
            ReadingScreen.routeName: (context) => const ReadingScreen(),
            DetailScreen.routeName: (context) => const DetailScreen(),
            ProfileScreen.routeName: (context) => const ProfileScreen(),
            UpdateProfileScreen.routeName: (context) =>
                const UpdateProfileScreen(),
            ComicsScreen.routeName: (context) => const ComicsScreen(),
          },
        ));
  }
}
