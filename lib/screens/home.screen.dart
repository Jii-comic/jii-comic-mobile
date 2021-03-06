// import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/models/comic.model.dart';
import 'package:jii_comic_mobile/models/comic_detail_props.dart';
import 'package:jii_comic_mobile/models/user.model.dart';
import 'package:jii_comic_mobile/providers/auth.provider.dart';
import 'package:jii_comic_mobile/providers/comics.provider.dart';
import 'package:jii_comic_mobile/screens/comics.screen.dart';
import 'package:jii_comic_mobile/screens/comic_detail.screen.dart';
import 'package:jii_comic_mobile/screens/login.screen.dart';
import 'package:jii_comic_mobile/widgets/comic_list.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:jii_comic_mobile/widgets/custom_bottom_navigation_bar.dart';
import 'package:jii_comic_mobile/widgets/spinner.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Comic>? _recentUpdatedComics;
  Future<List<Comic>>? _newComicsFuture;
  Future<List<Comic>>? _followingComicsFuture;
  Comic? _highlightedComic;

  _highlightComic({Comic? comic}) => () {
        setState(() {
          _highlightedComic = comic;
        });
      };

  _goToComic({required String comicId}) => () {
        if (comicId == "") {
          return;
        }

        Navigator.pushNamed(
          context,
          DetailScreen.routeName,
          arguments: ComicDetailProps(comicId: comicId),
        );
      };

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchComics();
    });
  }

  Future _fetchComics() async {
    final recentUpdatedComics = await context
        .read<ComicsProvider>()
        .getComics(limit: 10, orderBy: "updated_at", order: "DESC");
    setState(() {
      _recentUpdatedComics = recentUpdatedComics;
      if (recentUpdatedComics.isNotEmpty) {
        _highlightedComic = recentUpdatedComics[0];
      }
    });

    final newComics = context
        .read<ComicsProvider>()
        .getComics(limit: 5, orderBy: "created_at", order: "DESC");
    setState(() {
      _newComicsFuture = newComics;
    });

    bool hasFollowingComics =
        await context.read<AuthProvider>().checkActiveSession(context);
    if (hasFollowingComics) {
      setState(() {
        _followingComicsFuture = context
            .read<ComicsProvider>()
            .getFollowingComics(context,
                limit: 5, orderBy: "updated_at", order: "DESC");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Jii Comic"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(ComicsScreen.routeName),
              icon: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                size: 20,
              ))
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        activeRoute: HomeScreen.routeName,
      ),
      body: Column(
        children: [
          _renderHighlightedComic(),
          Container(
            height: 48,
            width: double.infinity,
            child: _renderRecentUpdatedComics(),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchComics,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      _renderNewComics(),
                      SizedBox(
                        height: 16,
                      ),
                      if (_followingComicsFuture != null)
                        _renderFollowingComics()
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _renderHighlightedComic() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: ClipRRect(
        key: ValueKey<String>(_highlightedComic?.comicId ?? ""),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        child: _highlightedComic == null
            ? Container(
                height: 211 + 64,
              )
            : Stack(children: [
                Positioned.fill(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.darken),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(_highlightedComic?.thumbnailUrl ??
                              "http://res.cloudinary.com/ddkz3f3xa/image/upload/v1653370609/cwn2qfht5irwzqw5o7d7.jpg"),
                        ),
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
                    padding: EdgeInsets.only(
                        top: 104, left: 16, right: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: Image(
                              width: 140,
                              height: 211,
                              fit: BoxFit.cover,
                              image: NetworkImage(_highlightedComic
                                      ?.thumbnailUrl ??
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
                                _highlightedComic?.name ?? "",
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              SizedBox(height: 16),
                              Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: _highlightedComic?.genres
                                        ?.map(
                                            (e) => _renderGenre(label: e.name))
                                        .toList() ??
                                    [],
                              ),
                              SizedBox(height: 16),
                              Text(
                                  "${_highlightedComic?.chapters?.length ?? 0} t???p"),
                              // Spacer(),
                              SizedBox(height: 16),
                              PrimaryButton(
                                child: Text("?????c ngay".toUpperCase()),
                                onPressed: _goToComic(
                                  comicId: _highlightedComic?.comicId ?? "",
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
      ),
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

  Widget _renderNewComics() {
    return FutureBuilder(
      future: _newComicsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ComicList(
              title: "M???i",
              hasMore: false,
              comics: snapshot.data as List<Comic>);
        } else {
          return Spinner();
        }
      },
    );
  }

  Widget _renderFollowingComics() {
    return FutureBuilder(
      future: _followingComicsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ComicList(
              title: "??ang theo d??i",
              hasMore: false,
              comics: snapshot.data as List<Comic>);
        } else {
          return Spinner();
        }
      },
    );
  }

  Widget _renderRecentUpdatedComics() {
    return _recentUpdatedComics == null
        ? Spinner()
        : ListView.separated(
            itemCount: _recentUpdatedComics?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => IconButton(
              onPressed: _highlightComic(comic: _recentUpdatedComics?[index]),
              icon: CircleAvatar(
                  backgroundImage: NetworkImage(_recentUpdatedComics?[index]
                          .thumbnailUrl ??
                      "http://res.cloudinary.com/ddkz3f3xa/image/upload/v1653370609/cwn2qfht5irwzqw5o7d7.jpg")),
            ),
            separatorBuilder: (context, index) => SizedBox(
              width: 4,
            ),
          );
  }
}
