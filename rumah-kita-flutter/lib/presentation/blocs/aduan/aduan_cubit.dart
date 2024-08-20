import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base.dart';
import '../../../data/models/aduan/aduan_model.dart';
import '../../../data/services/api/aduan.dart';
import '../../../utils/constants.dart';

part 'aduan_state.dart';

/// AduanCubit
class AduanCubit extends Cubit<AduanState> {
  final AduanApi _aduanApi;

  int _pageCount = 0;
  int _page = 1;
  int _limit = 25;
  final List<AduanModel> _data = [];

  AduanCubit({
    required AduanApi aduanApi,
  })  : _aduanApi = aduanApi,
        super(const AduanState());

  void dataRequested({
    bool refresh = false,
    int? userId,
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
      'populate[document_status]': 'document_status',
      'populate[attachment]': 'attachment',
      'pagination[page]': _page,
      'pagination[pageSize]': _limit,
    };

    if (userId != null) {
      qp['filters[users_permissions_user][\$eq]'] = userId;
    }

    if (documentStatusId != null) {
      qp['filters[document_status][\$eq]'] = documentStatusId;
    }

    final result = await _aduanApi.getAll(qp: qp);

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
