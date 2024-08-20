import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../core/base/base.dart';
import '../../../core/form_input/form_input.dart';
import '../../../data/services/api/api.dart';
import '../../../data/services/key_value_store/app_kvs.dart';

part 'register_state.dart';

/// RegisterCubit
class RegisterCubit extends Cubit<RegisterState> {
  final AppKVS _appKVS;
  final AuthApi _authApi;
  final UserDetailApi _userDetailApi;
  bool _lock = false;

  RegisterCubit({
    required AppKVS appKVS,
    required AuthApi authApi,
    required UserDetailApi userDetailApi,
  })  : _appKVS = appKVS,
        _authApi = authApi,
        _userDetailApi = userDetailApi,
        super(const RegisterState());

  void usernameChanged(String val) {
    if (_lock) return;

    final input = UsernameInput.dirty(value: val);

    emit(state.copyWith(
      username: input,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void emailChanged(String val) {
    if (_lock) return;

    final input = EmailInput.dirty(value: val);

    emit(state.copyWith(
      email: input,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void passwordChanged(String val) {
    if (_lock) return;

    final input = PasswordInput.dirty(value: val);

    emit(state.copyWith(
      password: input,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void fullnameChanged(String val) {
    if (_lock) return;

    final input = DefaultInput.dirty(value: val);

    emit(state.copyWith(
      fullname: input,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void jenisKelaminChanged(String val) {
    if (_lock) return;

    final input = DefaultInput.dirty(value: val);

    emit(state.copyWith(
      jenisKelamin: input,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void rwChanged(String val) {
    if (_lock) return;

    final input = DefaultInput.dirty(value: val);

    emit(state.copyWith(
      rw: input,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void rtChanged(String val) {
    if (_lock) return;

    final input = DefaultInput.dirty(value: val);

    emit(state.copyWith(
      rt: input,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void alamatChanged(String val) {
    if (_lock) return;

    final input = DefaultInput.dirty(value: val);

    emit(state.copyWith(
      alamat: input,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void domisiliChanged(String val) {
    if (_lock) return;

    final input = DefaultInput.dirty(value: val);

    emit(state.copyWith(
      domisili: input,
      status: FormzSubmissionStatus.initial,
    ));
  }

  ValidationObject? _validate() {
    if (state.isNotValid) {
      if (state.username.error != null) {
        return ValidationObject(
          identifier: 'username',
          name: state.username.error!.name,
          message: state.username.error!.errorMessage,
        );
      }

      if (state.email.error != null) {
        return ValidationObject(
          identifier: 'email',
          name: state.email.error!.name,
          message: state.email.error!.errorMessage,
        );
      }

      if (state.password.error != null) {
        return ValidationObject(
          identifier: 'password',
          name: state.password.error!.name,
          message: state.password.error!.errorMessage,
        );
      }

      if (state.fullname.error != null) {
        return ValidationObject(
          identifier: 'fullname',
          name: 'Nama lengkap',
          message: state.fullname.error!.errorMessage,
        );
      }

      if (state.jenisKelamin.error != null) {
        return ValidationObject(
          identifier: 'jenis_kelamin',
          name: 'Jenis kelamin',
          message: state.jenisKelamin.error!.errorMessage,
        );
      }

      if (state.rw.error != null) {
        return ValidationObject(
          identifier: 'rw',
          name: 'RW',
          message: state.rw.error!.errorMessage,
        );
      }

      if (state.rt.error != null) {
        return ValidationObject(
          identifier: 'rt',
          name: 'RT',
          message: state.rt.error!.errorMessage,
        );
      }

      if (state.alamat.error != null) {
        return ValidationObject(
          identifier: 'alamat',
          name: 'Alamat',
          message: state.alamat.error!.errorMessage,
        );
      }

      if (state.domisili.error != null) {
        return ValidationObject(
          identifier: 'domisili',
          name: 'Domisili',
          message: state.domisili.error!.errorMessage,
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

      ErrorObject? error;

      final result = await _authApi.register(
        state.username.value,
        state.email.value,
        state.password.value,
      );

      result.fold(
        (err) => error = ErrorObject.mapExceptionToErrMsg(err),
        (_) {},
      );

      if (error != null) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          error: error,
        ));
        return;
      }

      final result2 = await _userDetailApi.create(rd: {
        'data': {
          'users_permissions_user': _appKVS.userId,
          'fullname': state.fullname.value,
          'jenis_kelamin': state.jenisKelamin.value,
          'rw': state.rw.value,
          'rt': state.rt.value,
          'alamat': state.alamat.value,
          'domisili': state.domisili.value,
        },
      });

      result2.fold(
        (err) {
          error = ErrorObject.mapExceptionToErrMsg(err);
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            error: ErrorObject.mapExceptionToErrMsg(err),
          ));
        },
        (res) {
          emit(state.copyWith(
            username: const UsernameInput.pure(),
            email: const EmailInput.pure(),
            password: const PasswordInput.pure(),
            status: FormzSubmissionStatus.success,
          ));
        },
      );
    }

    _lock = false;
  }

  void resetForm() {
    emit(const RegisterState());
  }
}
