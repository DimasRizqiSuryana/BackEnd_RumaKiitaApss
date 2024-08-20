import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/base/base.dart';
import '../../../utils/dio_client.dart';
import '../../../utils/logger.dart';

class ElectionVoterApi {
  final DioClient _dioClient;

  ElectionVoterApi({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  Future<Either<Exception, bool>> create({
    Map<String, dynamic>? rd,
  }) async {
    try {
      Response _ = await _dioClient.withToken.post(
        '/api/election-voters',
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

  Future<Either<Exception, bool>> delete(int electionVoterId) async {
    try {
      Response _ = await _dioClient.withToken
          .delete('/api/election-voters/$electionVoterId');

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
