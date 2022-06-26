// Use your ip4 if using localhost
// const API_HOST = "https://jii-comic-api.herokuapp.com";
const API_HOST = "http://192.168.1.3:5000";
const API_KEY = "bc733e58-cdbd-4bc9-966b-d46baedb5dc1";

class ApiRoutes {
  static const login = "/auth/login";
  static const verifyToken = "/auth/verify-token";
  static const register = "/auth/register";
  static const getComics = "/comics";
  static String getComic({required String comicId}) => "/comics/$comicId";
  static String getChapters({required String comicId}) =>
      "/comics/$comicId/chapters";
  static String getChapter(
          {required String comicId, required String chapterId}) =>
      "/comics/$comicId/chapters/$chapterId";
  static String followComic({required String comicId}) =>
      "/comics/$comicId/follow";
  static String checkFollow({required String comicId}) =>
      "/comics/$comicId/check-follow-status";
  static String getGenres = "/genres";
  static String getComicRatings({required String comicId}) =>
      "/comics/$comicId/ratings";
}
