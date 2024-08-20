import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base.dart';
import '../../../data/models/kegiatan/kegiatan_model.dart';
import '../../../data/services/api/kegiatan.dart';
import '../../../utils/constants.dart';

part 'kegiatan_detail_state.dart';

/// KegiatanDetailCubit
class KegiatanDetailCubit extends Cubit<KegiatanDetailState> {
  final KegiatanApi _kegiatanApi;

  KegiatanDetailCubit({
    required KegiatanApi kegiatanApi,
  })  : _kegiatanApi = kegiatanApi,
        super(const KegiatanDetailState());

  void dataRequested(int id) async {
    emit(state.copyWith(
      status: BlocState.loading,
    ));

    Map<String, dynamic> qp = {
      'populate[users_permissions_user][populate][0]': 'user_detail',
      'populate[kategori_kegiatan]': 'kategori_kegiatan',
      'populate[document_status]': 'document_status',
      'populate[kerja_bakti][populate][photos]': 'photos',
      'populate[election][populate][election_parties][populate][0]':
          'photo_ketua',
      'populate[election][populate][election_parties][populate][1]':
          'photo_wakil_ketua',
      'populate[attachment]': 'attachment',
    };

    final result = await _kegiatanApi.getDetail(id, qp: qp);

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
