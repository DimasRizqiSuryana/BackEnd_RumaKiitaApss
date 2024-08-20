import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../core/base/base.dart';
import '../../../core/form_input/form_input.dart';
import '../../../data/services/api/api.dart';

part 'login_state.dart';

/// LoginCubit
class LoginCubit extends Cubit<LoginState> {
  final AuthApi _authApi;
  bool _lock = false;

  LoginCubit({
    required AuthApi authApi,
  })  : _authApi = authApi,
        super(const LoginState());

  void identifierChanged(String val) {
    if (_lock) return;

    final input = DefaultInput.dirty(value: val);

    emit(state.copyWith(
      identifier: input,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void passwordChanged(String val) {
    if (_lock) return;

    final input = DefaultInput.dirty(value: val);

    emit(state.copyWith(
      password: input,
      status: FormzSubmissionStatus.initial,
    ));
  }

  ValidationObject? _validate() {
    if (state.isNotValid) {
      final identifier = DefaultInput.dirty(value: state.identifier.value);
      if (identifier.error != null) {
        return ValidationObject(
          name: 'Username / Email',
          message: identifier.error!.errorMessage,
        );
      }

      final password = DefaultInput.dirty(value: state.password.value);
      if (password.error != null) {
        return ValidationObject(
          name: 'Password',
          message: password.error!.errorMessage,
        );
      }

      return const ValidationObject();
    }

    return null;
  }

  void formSubmitted() async {
    _lock = true;

    emit(state.copyWith(
      validation: _validate(),
    ));

    if (state.isNotValid) {
      emit(state.copyWith()); // reset
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final result = await _authApi.login(
        state.identifier.value,
        state.password.value,
      );

      result.fold(
        (err) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            error: ErrorObject.mapExceptionToErrMsg(err),
          ));
        },
        (res) {
          emit(state.copyWith(
            identifier: const DefaultInput.pure(),
            password: const DefaultInput.pure(),
            status: FormzSubmissionStatus.success,
          ));
        },
      );
    }

    _lock = false;
  }

  void resetForm() {
    emit(const LoginState());
  }
}
