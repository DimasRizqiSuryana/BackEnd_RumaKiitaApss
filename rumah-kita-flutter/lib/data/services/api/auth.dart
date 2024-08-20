import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/base/base.dart';
import '../../../utils/dio_client.dart';
import '../../../utils/logger.dart';
import '../../models/me/me_model.dart';
import '../key_value_store/app_kvs.dart';

class AuthApi {
  final DioClient _dioClient;
  final AppKVS _appKVS;

  AuthApi({
    required DioClient dioClient,
    required AppKVS appKVS,
  })  : _dioClient = dioClient,
        _appKVS = appKVS;

  Future<Either<Exception, bool>> login(
    String identifier,
    String password,
  ) async {
    try {
      final res = await _dioClient.dio.post('/api/auth/local', data: {
        'identifier': identifier,
        'password': password,
      });

      _appKVS.jwtToken = res.data['jwt'];

      return const Right(true);
    } on DioException catch (e, stacktrace) {
      logger.w(e.message, error: e, stackTrace: stacktrace);
      final res = e.response;

      if (res != null) {
        switch (res.statusCode) {
          case 400:
            return Left(ServerException(
              statusCode: res.statusCode!,
              error: res.data['error']['name'],
              message: res.data['error']['message'],
            ));
          default:
            return Left(ServerException(statusCode: res.statusCode!));
        }
      } else {
        return Left(ConnectionException());
      }
    } on DataParsingException catch (e, stacktrace) {
      logger.e(e.message, error: e.error, stackTrace: stacktrace);
      return Left(DataParsingException(
        operation: e.operation,
        error: e.error,
        message: e.message,
      ));
    } catch (e, stacktrace) {
      logger.e('UnhandledError', error: e, stackTrace: stacktrace);
      return Left(UnhandledError());
    }
  }

  Future<Either<Exception, bool>> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final res = await _dioClient.dio.post('/api/auth/local/register', data: {
        'username': username,
        'email': email,
        'password': password,
      });

      _appKVS.jwtToken = res.data['jwt'];
      _appKVS.userId = res.data['user']['id'];

      return const Right(true);
    } on DioException catch (e, stacktrace) {
      logger.w(e.message, error: e, stackTrace: stacktrace);
      final res = e.response;

      if (res != null) {
        switch (res.statusCode) {
          case 400:
            return Left(ServerException(
              statusCode: res.statusCode!,
              error: res.data['error']['name'],
              message: res.data['error']['message'],
            ));
          default:
            return Left(ServerException(statusCode: res.statusCode!));
        }
      } else {
        return Left(ConnectionException());
      }
    } on DataParsingException catch (e, stacktrace) {
      logger.e(e.message, error: e.error, stackTrace: stacktrace);
      return Left(DataParsingException(
        operation: e.operation,
        error: e.error,
        message: e.message,
      ));
    } catch (e, stacktrace) {
      logger.e('UnhandledError', error: e, stackTrace: stacktrace);
      return Left(UnhandledError());
    }
  }

  Future<Either<Exception, MeModel>> me({
    Map<String, dynamic>? qp,
  }) async {
    try {
      final res = await _dioClient.withToken.get(
        '/api/users/me',
        queryParameters: qp,
      );

      final model = MeModel.fromJson(res.data);
      _appKVS.userId = model.id;
      _appKVS.userDetailId = model.detail!.id;

      return Right(model);
    } on DioException catch (e, stacktrace) {
      logger.w(e.message, error: e, stackTrace: stacktrace);
      final res = e.response;

      if (res != null) {
        switch (res.statusCode) {
          case 400:
            return Left(ServerException(
              statusCode: res.statusCode!,
              error: res.data['error']['name'],
              message: res.data['error']['message'],
            ));
          default:
            return Left(ServerException(statusCode: res.statusCode!));
        }
      } else {
        return Left(ConnectionException());
      }
    } on DataParsingException catch (e, stacktrace) {
      logger.e(e.message, error: e.error, stackTrace: stacktrace);
      return Left(DataParsingException(
        operation: e.operation,
        error: e.error,
        message: e.message,
      ));
    } catch (e, stacktrace) {
      logger.e('UnhandledError', error: e, stackTrace: stacktrace);
      return Left(UnhandledError());
    }
  }
}
