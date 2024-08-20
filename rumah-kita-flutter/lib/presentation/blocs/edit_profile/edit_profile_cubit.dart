import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../core/base/base.dart';
import '../../../core/form_input/form_input.dart';
import '../../../data/services/api/api.dart';
import '../../../data/services/key_value_store/key_value_store.dart';

part 'edit_profile_state.dart';

/// EditProfileCubit
class EditProfileCubit extends Cubit<EditProfileState> {
  final AppKVS _appKVS;
  final UserApi _userApi;
  final UserDetailApi _userDetailApi;
  bool _lock = false;

  EditProfileCubit(
      {required AppKVS appKVS,
      required UserApi userApi,
      required UserDetailApi userDetailApi})
      : _appKVS = appKVS,
        _userApi = userApi,
        _userDetailApi = userDetailApi,
        super(const EditProfileState());

  void emailChanged(String val) {
    if (_lock) return;

    emit(state.copyWith(
      email: EmailInput.dirty(value: val),
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
      if (state.email.error != null) {
        return ValidationObject(
          identifier: 'email',
          name: state.email.error!.name,
          message: state.email.error!.errorMessage,
        );
      }

      if (state.fullname.error != null) {
        return ValidationObject(
          identifier: 'fullname',
          name: state.fullname.error!.name,
          message: state.fullname.error!.errorMessage,
        );
      }

      if (state.jenisKelamin.error != null) {
        return ValidationObject(
          identifier: 'jenis_kelamin',
          name: state.jenisKelamin.error!.name,
          message: state.jenisKelamin.error!.errorMessage,
        );
      }

      if (state.rw.error != null) {
        return ValidationObject(
          identifier: 'rw',
          name: state.rw.error!.name,
          message: state.rw.error!.errorMessage,
        );
      }

      if (state.rt.error != null) {
        return ValidationObject(
          identifier: 'rt',
          name: state.rt.error!.name,
          message: state.rt.error!.errorMessage,
        );
      }

      if (state.alamat.error != null) {
        return ValidationObject(
          identifier: 'alamat',
          name: state.alamat.error!.name,
          message: state.alamat.error!.errorMessage,
        );
      }

      if (state.domisili.error != null) {
        return ValidationObject(
          identifier: 'domisili',
          name: state.domisili.error!.name,
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

      final result = await _userApi.update(_appKVS.userId!, {
        'email': state.email.value,
      });

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

      final result2 = await _userDetailApi.update(_appKVS.userDetailId!, rd: {
        'data': {
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
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            error: ErrorObject.mapExceptionToErrMsg(err),
          ));
        },
        (res) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.success,
          ));
        },
      );
    }

    _lock = false;
  }

  void resetForm() {
    emit(const EditProfileState());
  }
}
