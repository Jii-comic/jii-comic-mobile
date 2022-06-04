import 'package:flutter/cupertino.dart';
import 'package:jii_comic_mobile/models/comic.model.dart';
import 'package:jii_comic_mobile/widgets/comic_card.dart';

class ComicList extends StatelessWidget {
  const ComicList(
      {Key? key,
      required this.title,
      required this.hasMore,
      this.onGetMore,
      this.comics = const []})
      : super(key: key);

  final List<Comic> comics;
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Flexible(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
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
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: comics.length,
            separatorBuilder: (context, index) => SizedBox(
              width: 16,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final List<String> genres =
                  comics[index].genres?.map((item) => item.name).toList() ?? [];
              return Container(
                width: 136,
                height: 204,
                child: ComicCard(
                  comicId: comics[index].comicId,
                  title: comics[index].name,
                  desc: genres.join(", "),
                  thumbnailUrl: comics[index].thumbnailUrl,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
