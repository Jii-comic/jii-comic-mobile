import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/models/chapter.model.dart';
import 'package:jii_comic_mobile/models/chapterDetailProps.dart';
import 'package:jii_comic_mobile/providers/comics.provider.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';
import 'package:jii_comic_mobile/widgets/spinner.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ReadingScreen extends StatefulWidget {
  static const routeName = "/reading";
  const ReadingScreen({Key? key}) : super(key: key);

  @override
  ReadingScreenState createState() => ReadingScreenState();
}

class ReadingScreenState extends State<ReadingScreen> {
  late String _comicId;
  late String _chapterId;
  Future<dynamic>? _chapterFuture;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) async {
        final props =
            ModalRoute.of(context)!.settings.arguments as ChapterDetailProps;

        setState(
          () {
            _comicId = props.comicId;
            _chapterId = props.chapterId;
            _chapterFuture = Provider.of<ComicsProvider>(context, listen: false)
                .getChapter(context,
                    comicId: props.comicId, chapterId: props.chapterId);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final props =
        ModalRoute.of(context)!.settings.arguments as ChapterDetailProps;
    final String comicId = props.comicId;
    final String chapterId = props.chapterId;

    void _handleToggleChapterListModal() {
      showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.all(16),
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Danh sách tập",
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: const <Widget>[
                    ListTile(
                      title: Text('Two-line ListTile'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return FutureBuilder(
      future: _chapterFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Chapter chapter = snapshot.data as Chapter;
          return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.black,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorConstants.gradientFirstColor,
                        ColorConstants.gradientSecondColor,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                    ),
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Center(
                  child: Text(
                    chapter.comic?.name ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                actions: [
                  IconButton(
                      icon: const FaIcon(FontAwesomeIcons.list),
                      onPressed: _handleToggleChapterListModal)
                ]),
            body: ListView(
              children: chapter.pages
                      ?.map(
                        (e) => Center(
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            child: Image.network(
                              e,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Spinner();
                              },
                            ),
                          ),
                        ),
                      )
                      .toList() ??
                  [],
            ),
            bottomNavigationBar: BottomAppBar(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, -4), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FaIcon(FontAwesomeIcons.arrowLeft),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Tập trước".toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                    Expanded(
                      child: Text(
                        chapter.name.toUpperCase(),
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorConstants.solidColor,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FaIcon(FontAwesomeIcons.arrowRight),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Tập sau".toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        }
        return Spinner();
      },
    );
  }
}
