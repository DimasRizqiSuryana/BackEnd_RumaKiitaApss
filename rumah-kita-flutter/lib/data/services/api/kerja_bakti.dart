import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

import '../../../core/base/base.dart';
import '../../../utils/dio_client.dart';
import '../../../utils/logger.dart';

class KerjaBaktiApi {
  final DioClient _dioClient;

  KerjaBaktiApi({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  Future<Either<Exception, bool>> create({
    Map<String, dynamic>? rd,
    List<File> photos = const [],
  }) async {
    try {
      final formData = FormData();

      formData.fields.add(MapEntry('data', jsonEncode(rd)));
      formData.files.addAll(photos.map((e) {
        return MapEntry(
          'files.photos',
          MultipartFile.fromBytes(
            e.readAsBytesSync(),
            filename: p.basename(e.path),
          ),
        );
      }).toList());

      final _ = await _dioClient.withToken.post(
        '/api/kerja-baktis',
        data: formData,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
        ),
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

  Future<Either<Exception, bool>> delete(int kerjaBaktiId) async {
    try {
      final _ =
          await _dioClient.withToken.delete('/api/kerja-baktis/$kerjaBaktiId');

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
