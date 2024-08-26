import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base.dart';
import '../../../data/models/election_registration/election_registration_model.dart';
import '../../../data/models/kegiatan/kegiatan_model.dart';
import '../../../data/services/api/api.dart';
import '../../../data/services/key_value_store/key_value_store.dart';
import '../../../utils/constants.dart';

part 'kegiatan_detail_state.dart';

/// KegiatanDetailCubit
class KegiatanDetailCubit extends Cubit<KegiatanDetailState> {
  final AppKVS _appKVS;
  final KegiatanApi _kegiatanApi;
  final ElectionRegistrationApi _electionRegistrationApi;

  KegiatanDetailCubit({
    required AppKVS appKVS,
    required KegiatanApi kegiatanApi,
    required ElectionRegistrationApi electionRegistrationApi,
  })  : _appKVS = appKVS,
        _kegiatanApi = kegiatanApi,
        _electionRegistrationApi = electionRegistrationApi,
        super(const KegiatanDetailState());

  void dataRequested(int id) async {
    emit(state.copyWith(
      status: BlocState.loading,
    ));

    ErrorObject? error;
    KegiatanModel? data;

    final result = await _kegiatanApi.getDetail(id, qp: {
      'populate[users_permissions_user][populate][0]': 'user_detail',
      'populate[kategori_kegiatan]': 'kategori_kegiatan',
      'populate[document_status]': 'document_status',
      'populate[kerja_bakti][populate][photos]': 'photos',
      'populate[election][populate][election_parties][populate][0]':
          'photo_ketua',
      'populate[election][populate][election_parties][populate][1]':
          'photo_wakil_ketua',
      'populate[attachment]': 'attachment',
    });

    result.fold(
      (err) => error = ErrorObject.mapExceptionToErrMsg(err),
      (res) => data = res,
    );

    if (error != null) {
      emit(state.copyWith(
        status: BlocState.failure,
        error: error,
      ));
      return;
    }

    final result2 = await _electionRegistrationApi.getAll(qp: {
      'populate[users_permissions_user][populate][0]': 'user_detail',
      'populate[document_status]': 'document_status',
      'populate[attachment]': 'attachment',
      'populate[election_voters]': 'election_voters',
      'filters[users_permissions_user][\$eq]': _appKVS.userId,
      'filters[kegiatan][\$eq]': id,
    });

    result2.fold(
      (err) {
        emit(state.copyWith(
          status: BlocState.failure,
          error: ErrorObject.mapExceptionToErrMsg(err),
        ));
      },
      (res) {
        emit(state.copyWith(
          status: BlocState.success,
          data: data,
          userElection: res.data.isNotEmpty ? res.data.first : null,
        ));
      },
    );
  }
}
