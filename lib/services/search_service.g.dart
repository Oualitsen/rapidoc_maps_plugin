// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SearchService implements SearchService {
  _SearchService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Prediction>> search(term, {lang, component}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'lang': lang,
      r'component': component
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = term;
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Prediction>>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/maps/places',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Prediction.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<LatLng> geocode(placeId, {lang}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'lang': lang};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LatLng>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/maps/places/get-place/$placeId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LatLng.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String> reverseGeocode(latLng, {lang}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'lang': lang};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = latLng;
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '/maps/places/reverse-geocode',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
