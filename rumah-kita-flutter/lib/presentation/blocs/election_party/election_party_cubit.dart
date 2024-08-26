import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base.dart';
import '../../../data/models/election_party/election_party_model.dart';
import '../../../data/services/api/api.dart';
import '../../../utils/constants.dart';

part 'election_party_state.dart';

/// ElectionPartyCubit
class ElectionPartyCubit extends Cubit<ElectionPartyState> {
  final ElectionPartyApi _electionPartyApi;

  ElectionPartyCubit({
    required ElectionPartyApi electionPartyApi,
  })  : _electionPartyApi = electionPartyApi,
        super(const ElectionPartyState());

  void dataRequested(int id) async {
    emit(state.copyWith(
      status: BlocState.loading,
    ));

    Map<String, dynamic> qp = {
      'populate[0]': 'photo_ketua',
      'populate[1]': 'photo_wakil_ketua',
    };

    final result = await _electionPartyApi.getDetail(id, qp: qp);

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
