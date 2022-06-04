// Use your ip4 if using localhost
const API_HOST = "http://192.168.31.28:5000";
const API_KEY = "bc733e58-cdbd-4bc9-966b-d46baedb5dc1";

class AuthRoutes {
  static const login = "/auth/login";
  static const register = "/auth/register";
  static const getComics = "/comics";
  static String getComic({required String comicId}) => "/comics/$comicId";
  static String getChapters({required String comicId}) => "/comics/$comicId";
  static String getChapter(
          {required String comicId, required String chapterId}) =>
      "/comics/$comicId/chapters/$chapterId";
  static String getGenres = "/genres";
}
