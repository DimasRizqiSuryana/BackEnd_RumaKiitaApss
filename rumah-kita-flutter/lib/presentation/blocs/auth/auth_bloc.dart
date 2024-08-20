import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rumah_kita/data/models/me/me_model.dart';

import '../../../core/base/base.dart';
import '../../../data/services/api/api.dart';
import '../../../data/services/key_value_store/key_value_store.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppKVS _appKVS;
  final AuthApi _authApi;

  AuthBloc({
    required AppKVS appKVS,
    required AuthApi authApi,
  })  : _appKVS = appKVS,
        _authApi = authApi,
        super(const AuthState.none()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  void _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (_appKVS.jwtToken.isNotEmpty) {
      final result = await _authApi.me(qp: {
        'populate[0]': 'user_detail',
      });

      result.fold(
        (err) {
          emit(AuthState.unauthenticated(
            redirect: event.redirect,
            error: ErrorObject.mapExceptionToErrMsg(err),
          ));
        },
        (res) {
          emit(AuthState.authenticated(
            user: res,
            redirect: event.redirect,
          ));
        },
      );
    } else {
      emit(AuthState.unauthenticated(redirect: event.redirect));
    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _appKVS.jwtToken = '';
    _appKVS.userId = null;
    emit(const AuthState.unauthenticated());
  }
}
