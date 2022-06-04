import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key? key, this.customColors}) : super(key: key);

  final List<Color>? customColors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GradientCircularProgressIndicator(
        radius: 64,
        gradient: Gradients.buildGradient(
          Alignment.centerLeft,
          Alignment.topRight,
          customColors ??
              [
                ColorConstants.gradientFirstColor,
                ColorConstants.gradientSecondColor,
              ],
        ),
      ),
    );
  }
}
