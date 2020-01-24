import 'package:moviedb/model/movies_response.dart';
import 'package:moviedb/util/constants.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart' hide Headers;

part 'movie_db_service.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/4")
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
}
