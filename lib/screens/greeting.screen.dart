import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:jii_comic_mobile/widgets/secondary_btn.dart';

class GreetingScreen extends StatelessWidget {
  static const routeName = "/greeting";
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/greeting-bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Jii Comic".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      borderColor: Colors.white,
                      onPressed: () {},
                      child: Text(
                        "Đăng kí".toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: PrimaryButton(
                      child: Text("Đăng nhập".toUpperCase()),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }
}
