import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base.dart';
import '../../../data/models/surat_pengajuan/surat_pengajuan_model.dart';
import '../../../data/services/api/surat_pengajuan.dart';
import '../../../utils/constants.dart';

part 'surat_pengajuan_detail_state.dart';

/// SuratPengajuanDetailCubit
class SuratPengajuanDetailCubit extends Cubit<SuratPengajuanDetailState> {
  final SuratPengajuanApi _suratPengajuanApi;

  SuratPengajuanDetailCubit({
    required SuratPengajuanApi suratPengajuanApi,
  })  : _suratPengajuanApi = suratPengajuanApi,
        super(const SuratPengajuanDetailState());

  void dataRequested(int id) async {
    emit(state.copyWith(
      status: BlocState.loading,
    ));

    Map<String, dynamic> qp = {
      'populate[users_permissions_user][populate][0]': 'user_detail',
      'populate[jenis_surat_pengajuan]': 'jenis_surat_pengajuan',
      'populate[document_status]': 'document_status',
      'populate[documents]': 'documents',
    };

    final result = await _suratPengajuanApi.getDetail(id, qp: qp);

    result.fold(
      (err) {
        emit(state.copyWith(
          status: BlocState.failure,
          error: ErrorObject.mapExceptionToErrMsg(err),
        ));
      },
      (res) {
        emit(state.copyWith(
          status: BlocState.success,
          data: res,
        ));
      },
    );
  }
}
