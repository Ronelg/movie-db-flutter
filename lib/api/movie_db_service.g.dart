// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_db_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MovieDbService implements MovieDbService {
  _MovieDbService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.themoviedb.org/4';
  }

  final Dio _dio;

  String baseUrl;

  @override
  discover() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/discover/movie?sort_by=popularity.desc',
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
}
