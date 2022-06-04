import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/models/chapter.model.dart';
import 'package:jii_comic_mobile/models/chapterDetailProps.dart';
import 'package:jii_comic_mobile/models/comic.model.dart';
import 'package:jii_comic_mobile/providers/chapter.provider.dart';
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
  late String _comicName;
  late String _comicId;
  late String _chapterId;
  Future<dynamic>? _chapterFuture;
  Future<dynamic>? _chapterListFuture;

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
            _comicName = props.comicName;
            _chapterFuture =
                Provider.of<ChaptersProvider>(context, listen: false)
                    .getChapter(context,
                        comicId: props.comicId, chapterId: props.chapterId);
            _chapterListFuture =
                Provider.of<ChaptersProvider>(context, listen: false)
                    .getChapters(comicId: props.comicId);
          },
        );
      },
    );
  }

  _goToChapter({required String chapterId}) {
    Navigator.of(context).pop(); // Pop the modal
    Navigator.of(context).pushReplacementNamed(
      ReadingScreen.routeName,
      arguments: ChapterDetailProps(
          chapterId: chapterId, comicId: _comicId, comicName: _comicName),
    ); // Replace and push the new chapter
  }

  _handleToggleChapterListModal() async {
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
              child: FutureBuilder(
                future: _chapterListFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final chapters = snapshot.data as List<Chapter>;

                    return ListView(
                        padding: EdgeInsets.zero,
                        children: chapters
                            .map(
                              (e) => ListTile(
                                  dense: true,
                                  onTap: () =>
                                      _goToChapter(chapterId: e.chapterId),
                                  title: Text(e.name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: e.chapterId == _chapterId
                                              ? ColorConstants.solidColor
                                              : Colors.black)),
                                  subtitle: e.chapterId == _chapterId
                                      ? Text("Đang đọc",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(0, 0, 0, 0.6),
                                          ))
                                      : null),
                            )
                            .toList());
                  }
                  return Spinner();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final props =
        ModalRoute.of(context)!.settings.arguments as ChapterDetailProps;
    final String comicId = props.comicId;
    final String chapterId = props.chapterId;
    final String? nextChapterId =
        Provider.of<ChaptersProvider>(context, listen: true).nextChapterId;
    final String? prevChapterId =
        Provider.of<ChaptersProvider>(context, listen: true).prevChapterId;

    return FutureBuilder(
      future: _chapterFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Chapter chapter = snapshot.data as Chapter;
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    _comicName,
                    maxLines: 1,
                  ),
                ),
                actions: [
                  IconButton(
                      icon: const FaIcon(FontAwesomeIcons.list),
                      onPressed: () => _handleToggleChapterListModal()),
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
                    _renderChapterNavigationBtn(
                        chapterId: prevChapterId,
                        icon: FontAwesomeIcons.arrowLeft,
                        label: "tập trước"),
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
                    _renderChapterNavigationBtn(
                        chapterId: nextChapterId,
                        icon: FontAwesomeIcons.arrowRight,
                        label: "tập sau")
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

  Widget _renderChapterNavigationBtn(
      {required String? chapterId,
      required IconData icon,
      required String label}) {
    final bool disabled = chapterId == null;

    return InkWell(
        onTap: () => {
              if (!disabled) {_goToChapter(chapterId: chapterId)}
            },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FaIcon(
              icon,
              color: !disabled
                  ? ColorConstants.regularColor
                  : ColorConstants.disabledColor,
            ),
            SizedBox(
              height: 4,
            ),
            Text(label.toUpperCase(),
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: !disabled
                          ? ColorConstants.regularColor
                          : ColorConstants.disabledColor,
                    )),
          ],
        ));
  }
}
