import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base.dart';
import '../../../data/models/election_registration/election_registration_model.dart';
import '../../../data/services/api/api.dart';
import '../../../utils/constants.dart';

part 'check_election_state.dart';

/// CheckElectionCubit
class CheckElectionCubit extends Cubit<CheckElectionState> {
  final ElectionRegistrationApi _electionRegistrationApi;

  CheckElectionCubit({
    required ElectionRegistrationApi electionRegistrationApi,
  })  : _electionRegistrationApi = electionRegistrationApi,
        super(const CheckElectionState());

  void dataRequested(int electionId) async {
    emit(state.copyWith(
      status: BlocState.loading,
    ));

    Map<String, dynamic> qp = {
      'populate[users_permissions_user][populate][0]': 'user_detail',
      'populate[document_status]': 'document_status',
      'populate[attachment]': 'attachment',
      'populate[election_voters]': 'election_voters',
      'filters[election][\$eq]': electionId,
    };

    final result = await _electionRegistrationApi.getAll(qp: qp);

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
          data: res.data[0],
        ));
      },
    );
  }
}
