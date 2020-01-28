import 'package:moviedb/model/movies_response.dart';
import 'package:moviedb/util/constants.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart' hide Headers;

part 'movie_db_service.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class MovieDbService {
  static final MovieDbService instance = _createService();

  factory MovieDbService(Dio dio, {String baseUrl}) = _MovieDbService;

  static MovieDbService _createService() {
    var dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["Authorization"] = "Bearer " + ACCESS_TOKEN;

    return MovieDbService(dio);
  }

  @GET('/discover/movie')
  Future<MoviesResponse> discover(@Queries() Map<String, String> options);

  @GET('/movie/now_playing')
  Future<MoviesResponse> nowPlaying(@Queries() Map<String, String> options);

  @GET('/movie/popular')
  Future<MoviesResponse> popularMovies(@Queries() Map<String, String> options);

  @GET('/movie/top_rated')
  Future<MoviesResponse> topRatedMovies(@Queries() Map<String, String> options);

  @GET('/movie/upcoming')
  Future<MoviesResponse> upcomingMovies(@Queries() Map<String, String> options);
}
