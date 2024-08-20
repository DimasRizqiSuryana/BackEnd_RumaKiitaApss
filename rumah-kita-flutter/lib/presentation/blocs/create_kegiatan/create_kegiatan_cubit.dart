import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../core/base/base.dart';
import '../../../core/form_input/form_input.dart';
import '../../../data/services/api/api.dart';
import '../../../data/services/key_value_store/app_kvs.dart';

part 'create_kegiatan_state.dart';

/// CreateKegiatanCubit
class CreateKegiatanCubit extends Cubit<CreateKegiatanState> {
  final AppKVS _appKVS;
  final KegiatanApi _kegiatanApi;
  bool _lock = false;

  CreateKegiatanCubit({
    required AppKVS appKVS,
    required KegiatanApi kegiatanApi,
  })  : _appKVS = appKVS,
        _kegiatanApi = kegiatanApi,
        super(const CreateKegiatanState());

  void kategoriKegiatanChanged(int val) {
    if (_lock) return;

    emit(state.copyWith(
      kategoriKegiatan: IdentifierInput.dirty(value: val),
      status: FormzSubmissionStatus.initial,
    ));
  }

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

  void startDateChanged(String val) {
    if (_lock) return;

    emit(state.copyWith(
      startDate: DefaultInput.dirty(value: val),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void finishDateChanged(String val) {
    if (_lock) return;

    emit(state.copyWith(
      finishDate: DefaultInput.dirty(value: val),
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
      if (state.kategoriKegiatan.error != null) {
        return const ValidationObject(
          identifier: 'kategori_kegiatan',
          name: 'Kategori Kegiatan',
          message: 'Input tidak boleh kosong',
        );
      }

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

      if (state.startDate.error != null) {
        return ValidationObject(
          identifier: 'start_date',
          name: 'Mulai Kegiatan',
          message: state.startDate.error!.errorMessage,
        );
      }

      if (state.finishDate.error != null) {
        return ValidationObject(
          identifier: 'finish_date',
          name: 'Selesai Kegiatan',
          message: state.finishDate.error!.errorMessage,
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

      final result = await _kegiatanApi.create(
        rd: {
          'users_permissions_user': _appKVS.userId!,
          'kategori_kegiatan': state.kategoriKegiatan.value,
          'document_status': state.documentStatus.value,
          'title': state.title.value,
          'description': state.description.value,
          'start_date': state.startDate.value,
          'finish_date': state.finishDate.value,
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
            kategoriKegiatan: const IdentifierInput.pure(),
            title: const DefaultInput.pure(),
            description: const DefaultInput.pure(),
            startDate: const DefaultInput.pure(),
            finishDate: const DefaultInput.pure(),
            status: FormzSubmissionStatus.success,
          ));
        },
      );
    }

    _lock = false;
  }

  void resetForm() {
    emit(const CreateKegiatanState());
  }
}
