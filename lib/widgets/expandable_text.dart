import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new AnimatedSize(
          vsync: this,
          duration: const Duration(milliseconds: 200),
          child: ConstrainedBox(
              constraints: widget.isExpanded
                  ? const BoxConstraints()
                  : const BoxConstraints(maxHeight: 64.0),
              child: Text(
                widget.text,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: TextStyle(fontSize: 16),
              ))),
      widget.isExpanded
          ? TextButton(
              child: const Text(
                'Hiển thị ít hơn',
                style: TextStyle(color: Color(0xffF65600), fontSize: 12),
              ),
              onPressed: () => setState(() => widget.isExpanded = false))
          : TextButton(
              child: const Text(
                'Xem thêm',
                style: TextStyle(color: Color(0xffF65600), fontSize: 12),
              ),
              onPressed: () => setState(() => widget.isExpanded = true))
    ]);
  }
}
