import 'package:flutter/cupertino.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key, required this.child, required this.onPressed});

  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      shapeRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      increaseWidthBy: double.infinity,
      child: child,
      callback: onPressed,
      gradient: Gradients.buildGradient(
        Alignment.centerLeft,
        Alignment.topRight,
        [
          ColorConstants.gradientFirstColor,
          ColorConstants.gradientSecondColor,
        ],
      ),
      shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.25),
    );
  }
}
