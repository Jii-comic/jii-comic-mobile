import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jii_comic_mobile/models/chapter.model.dart';
import 'package:jii_comic_mobile/models/comic.model.dart';
import 'package:jii_comic_mobile/models/genre.model.dart';
import 'package:jii_comic_mobile/models/rating.model.dart';
import 'package:jii_comic_mobile/providers/auth.provider.dart';
import 'package:jii_comic_mobile/services/comics.service.dart';
import 'package:jii_comic_mobile/services/genres.service.dart';
import 'package:jii_comic_mobile/utils/api_constants.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';
import 'package:provider/provider.dart';

class ComicsProvider extends ChangeNotifier {
  ComicsService comicsService = ComicsService();
  GenresService genresService = GenresService();

  Future<List<Comic>> getComics(
      {String? order,
      String? orderBy,
      int? limit,
      String? query,
      String? genreId}) async {
    final res = await comicsService.getComics(
        query: query,
        order: order,
        orderBy: orderBy,
        limit: limit,
        genreId: genreId);

    final resData = json.decode(res.body);

    return List.from(resData).map((e) => Comic.fromJson(e)).toList();
  }

  Future<List<Comic>> getFollowingComics(BuildContext context,
      {String? order, String? orderBy, int? limit, String? query}) async {
    final authProvider = context.read<AuthProvider>();
    final accessToken = authProvider.accessToken;

    final res = await comicsService.getComics(
        query: query,
        order: order,
        orderBy: orderBy,
        limit: limit,
        accessToken: accessToken,
        isFollowing: true);

    final resData = json.decode(res.body);

    return List.from(resData).map((e) => Comic.fromJson(e)).toList();
  }

  Future<dynamic> getComic(context, {required String comicId}) async {
    final res = await comicsService.getComic(comicId: comicId);
    final resData = json.decode(res.body);

    if (resData == "") {
      Navigator.of(context).pop();
      return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Thông báo"),
          content: Text("Không tìm thấy truyện!"),
          actions: [
            TextButton(
              child: Text(
                'Quay lại',
                style: TextStyle(color: ColorConstants.solidColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
    return Comic.fromJson(resData);
  }

  Future<dynamic> getMyRating(BuildContext context,
      {required String comicId}) async {
    final authProvider = context.read<AuthProvider>();
    final accessToken = authProvider.accessToken;

    final res = await comicsService.getMyRating(
        comicId: comicId, accessToken: accessToken);
    switch (res.statusCode) {
      case (401):
        return null;
      case (200):
        final resData = json.decode(res.body);
        if (resData != null && resData != "") {
          return Rating.fromJson(resData);
        }

        return null;
    }

    return null;
  }

  Future<Map<String, dynamic>> getRatings({required String comicId}) async {
    final res = await comicsService.getRatings(comicId: comicId);

    final resData = json.decode(res.body);

    return {
      "averageRatingScore": resData["avg_rating_score"],
      "ratings":
          List.from(resData["ratings"]).map((e) => Rating.fromJson(e)).toList(),
    };
  }

  Future<bool> rateComic(BuildContext context,
      {required comicId,
      String? ratingId,
      required double ratingScore,
      required String content}) async {
    final authProvider = context.read<AuthProvider>();
    final accessToken = authProvider.accessToken;

    final res = await comicsService.rate(
        ratingId: ratingId,
        comicId: comicId,
        accessToken: accessToken ?? "",
        ratingData: {"rating_score": ratingScore, "content": content});

    switch (res.statusCode) {
      case (401):
        authProvider.removeSession();

        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text("Vui lòng đăng nhập!"),
          ),
        );
        return false;
      case (200):
        final resData = json.decode(res.body);

        Fluttertoast.showToast(msg: "Lưu đánh giá thành công!");

        return true;
      default:
        Fluttertoast.showToast(msg: "Đã có lỗi xảy ra!");
        return false;
    }
  }

  Future<List<Genre>> getGenres() async {
    final res = await genresService.getGenres();

    final resData = json.decode(res.body);

    return List.from(resData).map((e) => Genre.fromJson(e)).toList();
  }

  Future<bool> checkFollowStatus(BuildContext context,
      {required String comicId}) async {
    final authProvider = context.read<AuthProvider>();
    final accessToken = authProvider.accessToken;

    final res = await comicsService.checkFollow(
        comicId: comicId, accessToken: accessToken ?? "");

    switch (res.statusCode) {
      case (200):
        final resData = json.decode(res.body);
        final followed = resData as bool;

        return followed;
      default:
        return false;
    }
  }

  Future<bool> follow(BuildContext context, {required String comicId}) async {
    final authProvider = context.read<AuthProvider>();
    final accessToken = authProvider.accessToken;

    final res = await comicsService.follow(
        comicId: comicId, accessToken: accessToken ?? "");

    switch (res.statusCode) {
      case (401):
        authProvider.removeSession();
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text("Vui lòng đăng nhập để sử dụng tính năng này!"),
          ),
        );
        return false;
      case (200):
        final resData = json.decode(res.body);
        final followed = resData["status"] == "FOLLOWED";

        Fluttertoast.showToast(
          msg: followed
              ? "Bạn đã theo dõi truyện này!"
              : "Bạn đã bỏ theo dõi truyện này!",
        );

        return followed;
      default:
        Fluttertoast.showToast(msg: "Đã có lỗi xảy ra!");
        return false;
    }
  }
}
