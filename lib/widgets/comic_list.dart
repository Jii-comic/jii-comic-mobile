import 'package:flutter/cupertino.dart';
import 'package:jii_comic_mobile/widgets/comic_card.dart';

class ComicList extends StatelessWidget {
  const ComicList(
      {Key? key, required this.title, required this.hasMore, this.onGetMore})
      : super(key: key);

  final String title;
  final bool hasMore;
  final void Function()? onGetMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            if (hasMore)
              GestureDetector(
                onTap: onGetMore,
                child: Text(
                  "More",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xffEE9D00),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 204,
          child: ListView.separated(
            itemCount: 4,
            separatorBuilder: (context, index) => SizedBox(
              width: 16,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                ComicCard(title: "Spy X Family", desc: "Slice of life, comedy"),
          ),
        ),
      ],
    );
  }
}
