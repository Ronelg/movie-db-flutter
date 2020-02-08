// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_db_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MovieDbService implements MovieDbService {
  _MovieDbService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.themoviedb.org/3';
  }

  final Dio _dio;

  String baseUrl;

  @override
  discover(options) async {
    ArgumentError.checkNotNull(options, 'options');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(options ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/discover/movie',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MoviesResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  nowPlaying(options) async {
    ArgumentError.checkNotNull(options, 'options');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(options ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/movie/now_playing',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MoviesResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  popularMovies(options) async {
    ArgumentError.checkNotNull(options, 'options');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(options ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/movie/popular',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MoviesResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  topRatedMovies(options) async {
    ArgumentError.checkNotNull(options, 'options');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(options ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/movie/top_rated',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MoviesResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  upcomingMovies(options) async {
    ArgumentError.checkNotNull(options, 'options');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(options ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/movie/upcoming',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MoviesResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getMovieDetails(id, options) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(options, 'options');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(options ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/movie/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MovieDetailsResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getMovieVideos(id, options) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(options, 'options');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(options ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/movie/$id/videos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MovieVideosResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getMovieSimilar(id, options) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(options, 'options');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(options ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/movie/$id/similar',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MoviesResponse.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getMovieCredits(id, options) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(options, 'options');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(options ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/movie/$id/credits',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MovieCreditsResponse.fromJson(_result.data);
    return Future.value(value);
  }
}
