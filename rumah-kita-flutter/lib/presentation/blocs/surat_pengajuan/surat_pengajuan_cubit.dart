import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base.dart';
import '../../../data/models/surat_pengajuan/surat_pengajuan_model.dart';
import '../../../data/services/api/surat_pengajuan.dart';
import '../../../utils/constants.dart';

part 'surat_pengajuan_state.dart';

/// SuratPengajuanCubit
class SuratPengajuanCubit extends Cubit<SuratPengajuanState> {
  final SuratPengajuanApi _suratPengajuanApi;

  int _pageCount = 0;
  int _page = 1;
  int _limit = 25;
  final List<SuratPengajuanModel> _data = [];

  SuratPengajuanCubit({
    required SuratPengajuanApi suratPengajuan,
  })  : _suratPengajuanApi = suratPengajuan,
        super(const SuratPengajuanState());

  void dataRequested({
    bool refresh = false,
    int? userId,
    int? jenisSuratPengajuanId,
    int? documentStatusId,
    int? limit,
  }) async {
    if (refresh) {
      _pageCount = 0;
      _page = 1;
      _limit = 25;
      _data.clear();
    }

    if (_pageCount != 0 && _page >= _pageCount) {
      return;
    }

    if (limit != null) {
      _limit = limit;
    }

    emit(state.copyWith(
      status: BlocState.loading,
    ));

    Map<String, dynamic> qp = {
      'populate[users_permissions_user][populate][0]': 'user_detail',
      'populate[jenis_surat_pengajuan]': 'jenis_surat_pengajuan',
      'populate[document_status]': 'document_status',
      'populate[documents]': 'documents',
      'pagination[page]': _page,
      'pagination[pageSize]': _limit,
    };

    if (userId != null) {
      qp['filters[users_permissions_user][\$eq]'] = userId;
    }

    if (jenisSuratPengajuanId != null) {
      qp['filters[jenis_surat_pengajuan][\$eq]'] = jenisSuratPengajuanId;
    }

    if (documentStatusId != null) {
      qp['filters[document_status][\$eq]'] = documentStatusId;
    }

    final result = await _suratPengajuanApi.getAll(qp: qp);

    result.fold(
      (err) {
        emit(state.copyWith(
          status: BlocState.failure,
          error: ErrorObject.mapExceptionToErrMsg(err),
        ));
      },
      (res) {
        _pageCount = res.pagination.pageCount;
        _page = res.pagination.page;
        _data.addAll(res.data);

        emit(state.copyWith(
          status: BlocState.success,
          data: _data,
        ));
      },
    );
  }
}
