import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rumah_kita/data/services/key_value_store/app_kvs.dart';

import '../../../core/base/base.dart';
import '../../../core/form_input/form_input.dart';
import '../../../data/services/api/api.dart';

part 'create_aduan_state.dart';

/// CreateAduanCubit
class CreateAduanCubit extends Cubit<CreateAduanState> {
  final AppKVS _appKVS;
  final AduanApi _aduanApi;
  bool _lock = false;

  CreateAduanCubit({
    required AppKVS appKVS,
    required AduanApi aduanApi,
  })  : _appKVS = appKVS,
        _aduanApi = aduanApi,
        super(const CreateAduanState());

  void documentStatusChanged(int val) {
    if (_lock) return;

    emit(state.copyWith(
      documentStatus: IdentifierInput.dirty(value: val),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void titleChanged(String val) {
    if (_lock) return;

    emit(state.copyWith(
      title: DefaultInput.dirty(value: val),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void descriptionChanged(String val) {
    if (_lock) return;

    emit(state.copyWith(
      description: DefaultInput.dirty(value: val),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void locationChanged(String val) {
    if (_lock) return;

    emit(state.copyWith(
      location: DefaultInput.dirty(value: val),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void dateofIncident(String val) {
    if (_lock) return;

    emit(state.copyWith(
      dateofIncident: DefaultInput.dirty(value: val),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void attachmentChanged(File? val) {
    if (_lock) return;

    emit(state.copyWith(
      attachment: FileInput.dirty(value: val),
      status: FormzSubmissionStatus.initial,
    ));
  }

  ValidationObject? _validate() {
    if (state.isNotValid) {
      if (state.documentStatus.error != null) {
        return ValidationObject(
          identifier: 'document_status',
          name: state.documentStatus.error!.name,
          message: state.documentStatus.error!.errorMessage,
        );
      }

      if (state.title.error != null) {
        return ValidationObject(
          identifier: 'title',
          name: 'Title',
          message: state.title.error!.errorMessage,
        );
      }

      if (state.description.error != null) {
        return ValidationObject(
          identifier: 'description',
          name: 'Keterangan',
          message: state.description.error!.errorMessage,
        );
      }

      if (state.location.error != null) {
        return ValidationObject(
          identifier: 'location',
          name: 'Lokasi',
          message: state.location.error!.errorMessage,
        );
      }

      if (state.dateofIncident.error != null) {
        return ValidationObject(
          identifier: 'date_of_incident',
          name: 'Waktu kejadian',
          message: state.dateofIncident.error!.errorMessage,
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

      final result = await _aduanApi.create(
        rd: {
          'users_permissions_user': _appKVS.userId!,
          'document_status': state.documentStatus.value,
          'title': state.title.value,
          'description': state.description.value,
          'location': state.location.value,
          'date_of_incident': state.dateofIncident.value,
        },
        attachment: state.attachment.value,
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
            title: const DefaultInput.pure(),
            description: const DefaultInput.pure(),
            location: const DefaultInput.pure(),
            dateofIncident: const DefaultInput.pure(),
            status: FormzSubmissionStatus.success,
          ));
        },
      );
    }

    _lock = false;
  }

  void resetForm() {
    emit(const CreateAduanState());
  }
}
