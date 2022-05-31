import 'package:flutter/cupertino.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

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
      callback: () {},
      gradient:
          Gradients.buildGradient(Alignment.centerLeft, Alignment.topRight, [
        Color(0xffEE9D00),
        Color(0xffFF0000),
      ]),
      shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.25),
    );
  }
}
