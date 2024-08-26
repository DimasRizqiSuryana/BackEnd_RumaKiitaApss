import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../core/base/base.dart';
import '../../../core/form_input/form_input.dart';
import '../../../data/services/api/api.dart';
import '../../../data/services/key_value_store/key_value_store.dart';

part 'edit_profile_picture_state.dart';

/// EditProfilePictureCubit
class EditProfilePictureCubit extends Cubit<EditProfilePictureState> {
  final AppKVS _appKVS;
  final UserDetailApi _userDetailApi;
  bool _lock = false;

  EditProfilePictureCubit({
    required AppKVS appKVS,
    required UserDetailApi userDetailApi,
  })  : _appKVS = appKVS,
        _userDetailApi = userDetailApi,
        super(const EditProfilePictureState());

  void photoChanged(File? val) {
    if (_lock) return;

    emit(state.copyWith(
      photo: FileInput.dirty(value: val),
      status: FormzSubmissionStatus.initial,
    ));

    formSubmitted();
  }

  ValidationObject? _validate() {
    if (state.isNotValid) {
      if (state.photo.error != null) {
        return ValidationObject(
          identifier: 'photo',
          name: state.photo.error!.name,
          message: state.photo.error!.errorMessage,
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

      final result2 = await _userDetailApi.update(
        _appKVS.userDetailId!,
        rd: {},
        photo: state.photo.value,
      );

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
    emit(const EditProfilePictureState());
  }
}
