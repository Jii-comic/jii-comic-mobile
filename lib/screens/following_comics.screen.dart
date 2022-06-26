import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/models/comic.model.dart';
import 'package:jii_comic_mobile/models/genre.model.dart';
import 'package:jii_comic_mobile/providers/index.dart';
import 'package:jii_comic_mobile/screens/comics.screen.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';
import 'package:jii_comic_mobile/widgets/comic_card.dart';
import 'package:jii_comic_mobile/widgets/custom_bottom_navigation_bar.dart';
import 'package:jii_comic_mobile/widgets/spinner.dart';
import 'package:provider/provider.dart';

class FollowingComicsScreen extends StatefulWidget {
  static const routeName = "/following";
  const FollowingComicsScreen({Key? key}) : super(key: key);

  @override
  State<FollowingComicsScreen> createState() => _FollowingComicsScreenState();
}

class _FollowingComicsScreenState extends State<FollowingComicsScreen> {
  Future<List<Comic>>? _comicsFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        _fetchComics();
      },
    );
  }

  Future _fetchComics() async {
    final canAccessScreen =
        await context.read<AuthProvider>().checkActiveSession(context);
    if (!canAccessScreen) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Thông báo"),
          content: Text("Vui lòng đăng nhập!"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/profile");
                },
                child: Text("OK"))
          ],
        ),
      );

      return;
    }

    setState(() {
      _comicsFuture = Provider.of<ComicsProvider>(context, listen: false)
          .getFollowingComics(
        context,
        orderBy: "created_at",
        order: "DESC",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  ColorConstants.gradientFirstColor,
                  ColorConstants.gradientSecondColor,
                ],
              ),
            ),
          ),
          title: Center(child: Text("Truyện đang theo dõi"))),
      body: RefreshIndicator(
        onRefresh: _fetchComics,
        child: FutureBuilder(
          future: _comicsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Comic> comics = snapshot.data as List<Comic>;

              return GridView.count(
                padding: EdgeInsets.all(16),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2 / 3,
                children: comics
                    .map((e) => ComicCard(
                        comicId: e.comicId,
                        title: e.name,
                        thumbnailUrl: e.thumbnailUrl,
                        desc: e.genres?.map((e) => e.name).join(", ") ?? ""))
                    .toList(),
              );
            }
            return Spinner();
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          activeRoute: FollowingComicsScreen.routeName),
    );
  }
}
