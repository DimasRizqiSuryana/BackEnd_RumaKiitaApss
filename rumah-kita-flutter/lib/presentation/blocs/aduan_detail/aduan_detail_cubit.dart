import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base.dart';
import '../../../data/models/aduan/aduan_model.dart';
import '../../../data/services/api/aduan.dart';
import '../../../utils/constants.dart';

part 'aduan_detail_state.dart';

/// AduanDetailCubit
class AduanDetailCubit extends Cubit<AduanDetailState> {
  final AduanApi _aduanApi;

  AduanDetailCubit({
    required AduanApi aduanApi,
  })  : _aduanApi = aduanApi,
        super(const AduanDetailState());

  void dataRequested(int id) async {
    emit(state.copyWith(
      status: BlocState.loading,
    ));

    Map<String, dynamic> qp = {
      'populate[users_permissions_user][populate][0]': 'user_detail',
      'populate[document_status]': 'document_status',
      'populate[attachment]': 'attachment',
    };

    final result = await _aduanApi.getDetail(id, qp: qp);

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
