import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/base/base.dart';
import '../../../utils/dio_client.dart';
import '../../../utils/logger.dart';

class UserApi {
  final DioClient _dioClient;

  UserApi({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  Future<Either<Exception, bool>> update(
    int userId,
    Map<String, dynamic> rd,
  ) async {
    try {
      final _ = await _dioClient.withToken.put(
        '/api/users/$userId',
        data: rd,
      );

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
}
