import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

import '../../../core/base/base.dart';
import '../../../utils/dio_client.dart';
import '../../../utils/logger.dart';
import '../../models/election_registration/election_registration_model.dart';
import '../../models/utils.dart';

class ElectionRegistrationApi {
  final DioClient _dioClient;

  ElectionRegistrationApi({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  Future<Either<Exception, Collection<ElectionRegistrationModel>>> getAll({
    Map<String, dynamic>? qp,
  }) async {
    try {
      final res = await _dioClient.withToken.get(
        '/api/election-registrations',
        queryParameters: qp,
      );

      final data = ElectionRegistrationListModel.fromJson(res.data);

      return Right(Collection(
        data: data.data,
        pagination: data.meta!.pagination!,
      ));
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

  Future<Either<Exception, ElectionRegistrationModel>> getDetail(
      int electionRegistrationId) async {
    try {
      final res = await _dioClient.withToken
          .get('/api/election-registrations/$electionRegistrationId');

      return Right(ElectionRegistrationModel.fromJson(res.data['data']));
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

  Future<Either<Exception, int>> create({
    Map<String, dynamic>? rd,
    File? attachment,
  }) async {
    try {
      final formData = FormData();

      formData.fields.add(MapEntry('data', jsonEncode(rd)));
      if (attachment != null) {
        formData.files.add(
          MapEntry(
            'files.attachment',
            MultipartFile.fromBytes(
              attachment.readAsBytesSync(),
              filename: p.basename(attachment.path),
            ),
          ),
        );
      }

      final res = await _dioClient.withToken.post(
        '/api/election-registrations',
        data: formData,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
        ),
      );

      final model = ElectionRegistrationModel.fromJson(res.data);

      return Right(model.id);
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

  Future<Either<Exception, bool>> delete(int electionRegistrationId) async {
    try {
      final _ = await _dioClient.withToken
          .delete('/api/election-registrations/$electionRegistrationId');

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
