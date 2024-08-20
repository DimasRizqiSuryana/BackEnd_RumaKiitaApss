import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

import '../../../core/base/base.dart';
import '../../../utils/dio_client.dart';
import '../../../utils/logger.dart';
import '../../models/kegiatan/kegiatan_model.dart';
import '../../models/utils.dart';

class KegiatanApi {
  final DioClient _dioClient;

  KegiatanApi({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  Future<Either<Exception, Collection<KegiatanModel>>> getAll({
    Map<String, dynamic>? qp,
  }) async {
    try {
      final res = await _dioClient.withToken.get(
        '/api/kegiatans',
        queryParameters: qp,
      );

      final data = KegiatanListModel.fromJson(res.data);

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

  Future<Either<Exception, KegiatanModel>> getDetail(
    int kegiatanId, {
    Map<String, dynamic>? qp,
  }) async {
    try {
      final res = await _dioClient.withToken.get(
        '/api/kegiatans/$kegiatanId',
        queryParameters: qp,
      );

      return Right(KegiatanModel.fromJson(res.data['data']));
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

  Future<Either<Exception, bool>> create({
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

      final _ = await _dioClient.withToken.post(
        '/api/kegiatans',
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

  Future<Either<Exception, bool>> delete(int kegiatanId) async {
    try {
      final _ = await _dioClient.withToken.delete('/api/kegiatans/$kegiatanId');

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
