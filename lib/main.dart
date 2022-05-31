import 'package:flutter/material.dart';
import 'package:jii_comic_mobile/providers/auth.provider.dart';
import 'package:jii_comic_mobile/screens/greeting.screen.dart';
import 'package:jii_comic_mobile/screens/home.screen.dart';
import 'package:jii_comic_mobile/screens/login.screen.dart';
import 'package:jii_comic_mobile/screens/register.screen.dart';
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
        providers: [ChangeNotifierProvider(create: (ctx) => AuthProvider())],
        child: MaterialApp(
          title: 'Jii Comic',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          initialRoute: HomeScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            GreetingScreen.routeName: (context) => const GreetingScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen()
          },
        ));
  }
}
