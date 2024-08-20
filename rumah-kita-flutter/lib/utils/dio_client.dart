import 'package:dio/dio.dart';

import '../data/services/key_value_store/app_kvs.dart';
import 'constants.dart';

/// Dio client
class DioClient {
  final AppKVS _appKVS;
  Dio _dio = Dio();

  // base options
  final BaseOptions _options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 15),
    contentType: Headers.jsonContentType,
  );

  // interceptor
  final InterceptorsWrapper _interceptor = InterceptorsWrapper(
    onRequest: (options, handler) {
      return handler.next(options);
    },
    onResponse: (response, handler) async {
      return handler.next(response);
    },
    onError: (DioException e, handler) async {
      return handler.next(e);
    },
  );

  DioClient({
    required AppKVS appKVS,
  }) : _appKVS = appKVS {
    _dio = Dio(_options);
    _dio.interceptors.add(_interceptor);
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  // token interceptor
  InterceptorsWrapper _tokenInterceptor() => InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer ${_appKVS.jwtToken}';

          return handler.next(options);
        },
      );

  Dio get dio => _dio;

  // with Token
  Dio get withToken {
    _dio.interceptors.add(_tokenInterceptor());

    return _dio;
  }
}
