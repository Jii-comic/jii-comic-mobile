import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {Key? key,
      required this.child,
      this.borderColor,
      required this.onPressed});

  final Widget child;
  final void Function() onPressed;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(width: 1, color: borderColor ?? Colors.black),
      ),
      child: child,
      onPressed: onPressed,
    );
  }
}
