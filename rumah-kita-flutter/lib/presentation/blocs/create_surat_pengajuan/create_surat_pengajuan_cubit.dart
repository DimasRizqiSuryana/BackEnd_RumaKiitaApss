import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../core/base/base.dart';
import '../../../core/form_input/form_input.dart';
import '../../../data/services/api/api.dart';
import '../../../data/services/key_value_store/app_kvs.dart';

part 'create_surat_pengajuan_state.dart';

/// CreateSuratPengajuanCubit
class CreateSuratPengajuanCubit extends Cubit<CreateSuratPengajuanState> {
  final AppKVS _appKVS;
  final SuratPengajuanApi _suratPengajuanApi;
  bool _lock = false;

  CreateSuratPengajuanCubit({
    required AppKVS appKVS,
    required SuratPengajuanApi suratPengajuanApi,
  })  : _appKVS = appKVS,
        _suratPengajuanApi = suratPengajuanApi,
        super(const CreateSuratPengajuanState());

  void jenisSuratPengajuanChanged(int val) {
    if (_lock) return;

    emit(state.copyWith(
      jenisSuratPengajuan: IdentifierInput.dirty(value: val),
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

  void fullnameChanged(String val) {
    if (_lock) return;

    emit(state.copyWith(
      fullname: DefaultInput.dirty(value: val),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void emailChanged(String val) {
    if (_lock) return;

    emit(state.copyWith(
      email: EmailInput.dirty(value: val),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void alamatChanged(String val) {
    if (_lock) return;

    emit(state.copyWith(
      alamat: DefaultInput.dirty(value: val),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void documentsChanged(List<File> file) {
    if (_lock) return;

    emit(state.copyWith(
      documents: file,
      status: FormzSubmissionStatus.initial,
    ));
  }

  ValidationObject? _validate() {
    if (state.isNotValid) {
      if (state.jenisSuratPengajuan.error != null) {
        return const ValidationObject(
          identifier: 'jenis_surat_pengajuan',
          name: 'Jenis Surat Pengajuan',
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

      if (state.fullname.error != null) {
        return ValidationObject(
          identifier: 'fullname',
          name: 'Nama lengkap',
          message: state.fullname.error!.errorMessage,
        );
      }

      if (state.email.error != null) {
        return ValidationObject(
          identifier: 'email',
          name: state.email.error!.name,
          message: state.email.error!.errorMessage,
        );
      }

      if (state.alamat.error != null) {
        return ValidationObject(
          identifier: 'alamat',
          name: 'Alamat',
          message: state.alamat.error!.errorMessage,
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

      final result = await _suratPengajuanApi.create(
        rd: {
          'users_permissions_user': _appKVS.userId!,
          'jenis_surat_pengajuan': state.jenisSuratPengajuan.value,
          'document_status': state.documentStatus.value,
          'fullname': state.fullname.value,
          'email': state.email.value,
          'alamat': state.alamat.value,
        },
        documents: state.documents,
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
            jenisSuratPengajuan: const IdentifierInput.pure(),
            fullname: const DefaultInput.pure(),
            email: const EmailInput.pure(),
            alamat: const DefaultInput.pure(),
            documents: [],
            status: FormzSubmissionStatus.success,
          ));
        },
      );
    }

    _lock = false;
  }

  void resetForm() {
    emit(const CreateSuratPengajuanState());
  }
}
