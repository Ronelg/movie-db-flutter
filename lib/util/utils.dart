

class Utils {

  static String getSmallImageUrl(String imagePath) => 'https://image.tmdb.org/t/p/w185/$imagePath';

  static String getMediumImageUrl(String imagePath) => 'https://image.tmdb.org/t/p/w300/$imagePath';

  static String getLargeImageUrl(String imagePath) => 'https://image.tmdb.org/t/p/w500/$imagePath';

//  static tmdbMovieImage(String url) => "https://image.tmdb.org/t/p/w300$url";

  static youtubeVideoThumbnail(String videoId) => "https://img.youtube.com/vi/$videoId/0.jpg";
}
