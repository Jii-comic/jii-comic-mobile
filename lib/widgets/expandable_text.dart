import 'package:flutter/material.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText({required this.text});

  final String text;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedSize(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 200),
          child: Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Text(
              widget.text,
              maxLines: !isExpanded ? 3 : null,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        isExpanded
            ? InkWell(
                child: Text(
                  'Hiển thị ít hơn',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: ColorConstants.solidColor),
                ),
                onTap: () => setState(() => isExpanded = false))
            : InkWell(
                child: Text(
                  'Xem thêm',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: ColorConstants.solidColor),
                ),
                onTap: () => setState(() => isExpanded = true),
              )
      ],
    );
  }
}
