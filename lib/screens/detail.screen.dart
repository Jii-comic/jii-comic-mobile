import 'dart:ui';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/models/chapter.model.dart';
import 'package:jii_comic_mobile/models/chapterDetailProps.dart';
import 'package:jii_comic_mobile/models/comic.model.dart';
import 'package:jii_comic_mobile/models/comicDetailProps.dart';
import 'package:jii_comic_mobile/providers/comics.provider.dart';
import 'package:jii_comic_mobile/screens/reading.page.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';
import 'package:jii_comic_mobile/widgets/comic_list.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:jii_comic_mobile/widgets/spinner.dart';
import 'package:provider/provider.dart';
import "package:timeago/timeago.dart" as timeago;

class DetailScreen extends StatefulWidget {
  static const routeName = "/detail";
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String _comicId;
  Future<dynamic>? _comicFuture;

  void _goToChapter({required String chapterId}) {
    if (chapterId == "") {
      return;
    }
    Navigator.of(context).pushNamed(
      ReadingScreen.routeName,
      arguments: ChapterDetailProps(chapterId: chapterId, comicId: _comicId),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        final props =
            ModalRoute.of(context)!.settings.arguments as ComicDetailProps;
        setState(() {
          _comicId = props.comicId;
          _comicFuture = Provider.of<ComicsProvider>(context, listen: false)
              .getComic(context, comicId: props.comicId);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages("vi", timeago.ViMessages());

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Jii Comic"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {}, icon: FaIcon(FontAwesomeIcons.bookmark))
          ],
        ),
        body: FutureBuilder(
          future: _comicFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final Comic _comic = snapshot.data as Comic;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _renderHighlightedComic(comic: _comic),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _renderDescription(_comic.description ?? ""),
                          SizedBox(height: 16),
                          Text(
                            "Danh sách tập",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            "Cập nhật lần cuối: ${timeago.format(_comic.updatedAt, locale: 'vi')}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(0, 0, 0, 0.6)),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          _renderChapterList(chapters: _comic.chapters ?? [])
                        ],
                      ),
                    ),
                  )
                ],
              );
            }

            return Spinner();
          },
        ));
  }

  Widget _renderHighlightedComic({required Comic comic}) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      child: Stack(children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(comic.thumbnailUrl ??
                    "http://res.cloudinary.com/ddkz3f3xa/image/upload/v1653370609/cwn2qfht5irwzqw5o7d7.jpg"),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          ),
        ),
        DefaultTextStyle(
          style: TextStyle(color: Colors.white),
          child: Container(
            margin: EdgeInsets.only(top: 88),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image(
                      width: 140,
                      height: 211,
                      fit: BoxFit.cover,
                      image: NetworkImage(comic.thumbnailUrl ??
                          "http://res.cloudinary.com/ddkz3f3xa/image/upload/v1653370609/cwn2qfht5irwzqw5o7d7.jpg"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comic.name,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: comic.genres
                                  ?.map((e) => _renderGenre(label: e.name))
                                  .toList() ??
                              []),
                      SizedBox(height: 16),
                      PrimaryButton(
                        child: Text("Bắt đầu đọc".toUpperCase()),
                        onPressed: () => _goToChapter(
                            chapterId: comic.chapters?[0].chapterId ?? ""),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _renderGenre({required String label}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        label,
        style: TextStyle(fontSize: 8),
      ),
    );
  }

  Widget _renderDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8),
          child: Text(
            "Mô tả",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        ExpandableText(
          description,
          expandText: "Xem thêm",
          collapseText: "Thu gọn",
          maxLines: 3,
          linkColor: ColorConstants.solidColor,
        )
      ],
    );
  }

  Widget _renderChapterList({List<Chapter> chapters = const []}) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: chapters
          .map<Widget>((chapter) => _renderChapter(chapter: chapter))
          .toList(),
    );
  }

  Widget _renderChapter({required Chapter chapter}) {
    return ListTile(
      onTap: () => _goToChapter(chapterId: chapter.chapterId),
      dense: true,
      title: Text(
        chapter.name,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        timeago.format(chapter.createdAt, locale: "vi"),
        style: TextStyle(
          fontSize: 12,
          color: Color.fromRGBO(0, 0, 0, 0.6),
        ),
      ),
    );
  }
}
