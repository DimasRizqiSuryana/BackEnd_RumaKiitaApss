import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/base/base.dart';
import '../../../utils/dio_client.dart';
import '../../../utils/logger.dart';
import '../../models/jenis_surat_pengajuan/jenis_surat_pengajuan_model.dart';
import '../../models/utils.dart';

class JenisSuratPengajuanApi {
  final DioClient _dioClient;

  JenisSuratPengajuanApi({
    required DioClient dioClient,
  }) : _dioClient = dioClient;

  Future<Either<Exception, Collection<JenisSuratPengajuanModel>>> getAll({
    Map<String, dynamic>? qp,
  }) async {
    try {
      final res = await _dioClient.withToken.get(
        '/api/jenis-surat-pengajuans',
        queryParameters: qp,
      );

      final data = JenisSuratPengajuanListModel.fromJson(res.data);

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
}
