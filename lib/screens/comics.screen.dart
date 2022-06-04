import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/models/comic.model.dart';
import 'package:jii_comic_mobile/models/genre.model.dart';
import 'package:jii_comic_mobile/providers/comics.provider.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';
import 'package:jii_comic_mobile/widgets/comic_card.dart';
import 'package:jii_comic_mobile/widgets/custom_bottom_navigation_bar.dart';
import 'package:jii_comic_mobile/widgets/spinner.dart';
import 'package:provider/provider.dart';

class ComicsScreen extends StatefulWidget {
  static const routeName = "/comics";
  const ComicsScreen({Key? key}) : super(key: key);

  @override
  ComicsScreenState createState() => ComicsScreenState();
}

class ComicsScreenState extends State<ComicsScreen> {
  Future<List<Comic>>? _comicsFuture;
  Future<List<Genre>>? _genresFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        setState(() {
          _comicsFuture = Provider.of<ComicsProvider>(context, listen: false)
              .getComics(orderBy: "created_at", order: "DESC");
          _genresFuture =
              Provider.of<ComicsProvider>(context, listen: false).getGenres();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void _searchComicsByQuery(query) {
      setState(() {
        _comicsFuture =
            Provider.of<ComicsProvider>(context, listen: false).getComics(
          query: query,
          orderBy: "created_at",
          order: "DESC",
        );
      });
    }

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
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: TextField(
            onChanged: _searchComicsByQuery,
            decoration: InputDecoration(
              // Tránh đường kẻ màu đen xuất hiện ở trên và dưới thanh search.
              border: InputBorder.none,
              hintText: "Search...",
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              prefixIcon: Center(
                widthFactor: 1,
                heightFactor: 1,
                child: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: FutureBuilder(
            future: _genresFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Genre> genres = snapshot.data as List<Genre>;

                return Container(
                  height: 48,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: genres.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text(
                        genres[index].name,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }
              return Spinner(
                customColors: [Colors.white, Colors.transparent],
              );
            },
          ),
        ),
      ),
      body: FutureBuilder(
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
      bottomNavigationBar:
          CustomBottomNavigationBar(activeRoute: ComicsScreen.routeName),
    );
  }
}
