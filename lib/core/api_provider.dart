import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import '../utils/StringUtils.dart';

typedef RestResponse = Future<T> Function<T>(Response response);
typedef RestError = Future Function(DioError error);

class ApiProvider {
  Dio _dio = Dio();

  static ApiProvider _singleton;

  RestResponse _restResponse;
  RestError _restError;

  ApiProvider._internal();

  factory ApiProvider.builder(baseUrl,
      {ApiConfig config,
      InterceptorsWrapper interceptor,
      InterceptorWrapOther interceptorOther,
      RestResponse restResponse,
      RestError restError}) {
    if (_singleton == null) {
      _singleton = ApiProvider._internal()
        .._baseUrl(baseUrl)
        .._config(config)
        .._interceptor(interceptor)
        .._interceptorOther(interceptorOther)
        .._restResponse = restResponse
        .._restError = restError;
    }
    return _singleton;
  }

  ApiProvider _baseUrl(String baseUrl) {
    _dio.options..baseUrl = baseUrl;
    return _singleton;
  }

  ApiProvider _config([ApiConfig config]) {
    final configDio = config == null ? ApiConfigMixin() : config;
    _dio.options
      ..connectTimeout = configDio.connectTimeout
      ..receiveTimeout = configDio.receiveTimeout
      ..headers.addAll({
        ...{HttpHeaders.acceptHeader.capitalize(): "application/json"},
        ...configDio.headers
      });
    return _singleton;
  }

  ApiProvider _interceptorOther(InterceptorWrapOther interceptorOther) {
    if (interceptorOther != null)
      _dio.interceptors
          .add(InterceptorsWrapper(onResponse: (Response response) {
        return interceptorOther.response(response);
      }, onError: (DioError e) {
        return interceptorOther.error(e);
      }, onRequest: (RequestOptions options) {
        return interceptorOther.request(options);
      }));
    return _singleton;
  }

  ApiProvider _interceptor([InterceptorsWrapper interceptor]) {
    if (interceptor != null) _dio.interceptors.add(interceptor);
    return _singleton;
  }

  bool shouldRetry(DioError error) {
    return error.type == DioErrorType.DEFAULT &&
        error.error != null &&
        error.error is SocketException;
  }

  Future<T> get<T>(url,
      {Map<String, dynamic> queryParameters,
      Function cb,
      Map<String, String> headers}) async {
    try {
      final Options options = Options();
      if (headers != null) options.headers.addAll(headers);
      var response = await _dio.get<T>(url,
          queryParameters: queryParameters, options: options);
      return _restResponse<T>(response);
    } on DioError catch (e) {
      print(e.message.toString());
      return _restError(e);
    }
  }

  Future<T> post<T>(url,
      {body, Function cb, Map<String, String> headers, queryParameters}) async {
    try {
      final Options options = Options();
      if (headers != null) options.headers.addAll(headers);
      var response = await _dio.post<T>(url,
          data: body, options: options, queryParameters: queryParameters);
      return _restResponse<T>(response);
    } on DioError catch (e) {
      print(e.message.toString());
      return _restError(e);
    }
  }

  Future<T> put<T>(url,
      {body, Function cb, Map<String, String> headers, queryParameters}) async {
    try {
      final Options options = Options();
      if (headers != null) options.headers.addAll(headers);
      var response = await _dio.put<T>(url,
          data: body, options: options, queryParameters: queryParameters);
      return _restResponse<T>(response);
    } on DioError catch (e) {
      print(e.message.toString());
      return _restError(e);
    }
  }

  Future<T> delete<T>(url,
      {body, Function cb, Map<String, String> headers, queryParameters}) async {
    try {
      final Options options = Options();
      if (headers != null) options.headers.addAll(headers);
      var response = await _dio.delete<T>(url,
          data: body, options: options, queryParameters: queryParameters);
      return _restResponse<T>(response);
    } on DioError catch (e) {
      print(e.message.toString());
      return _restError(e);
    }
  }

  Future<T> patch<T>(url,
      {body, Function cb, Map<String, String> headers, queryParameters}) async {
    try {
      final Options options = Options();
      if (headers != null) options.headers.addAll(headers);
      var response = await _dio.patch<T>(url,
          data: body, options: options, queryParameters: queryParameters);
      return _restResponse<T>(response);
    } on DioError catch (e) {
      print(e.message.toString());
      return _restError(e);
    }
  }
}

abstract class ApiConfig {
  int connectTimeout = 5000;
  int receiveTimeout = 5000;
  Map<String, dynamic> headers = {};
}

class ApiConfigMixin extends ApiConfig {}

abstract class InterceptorWrapOther {
  response(Response response);

  error(DioError error);

  request(RequestOptions options);
}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
