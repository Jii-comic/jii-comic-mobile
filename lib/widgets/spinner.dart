import 'package:flutter/cupertino.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GradientCircularProgressIndicator(
        radius: 24,
        gradient: Gradients.buildGradient(
          Alignment.centerLeft,
          Alignment.topRight,
          [
            ColorConstants.gradientFirstColor,
            ColorConstants.gradientSecondColor,
          ],
        ),
      ),
    );
  }
}
