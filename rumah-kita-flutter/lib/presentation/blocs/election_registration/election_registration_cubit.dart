import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../core/base/base.dart';
import '../../../core/form_input/form_input.dart';
import '../../../data/services/api/api.dart';
import '../../../data/services/key_value_store/app_kvs.dart';

part 'election_registration_state.dart';

/// ElectionRegistrationCubit
class ElectionRegistrationCubit extends Cubit<ElectionRegistrationState> {
  final AppKVS _appKVS;
  final ElectionRegistrationApi _electionRegistrationApi;
  final ElectionVoterApi _electionVoterApi;
  bool _lock = false;

  ElectionRegistrationCubit({
    required AppKVS appKVS,
    required ElectionRegistrationApi electionRegistrationApi,
    required ElectionVoterApi electionVoterApi,
  })  : _appKVS = appKVS,
        _electionRegistrationApi = electionRegistrationApi,
        _electionVoterApi = electionVoterApi,
        super(const ElectionRegistrationState());

  void electionChanged(int val) {
    if (_lock) return;

    emit(state.copyWith(
      election: IdentifierInput.dirty(value: val),
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

  void addVoter(String val) {
    if (_lock) return;

    final voters = state.voters;
    voters.add(const DefaultInput.pure());

    emit(state.copyWith(
      voters: voters,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void voterChanged(int index, String val) {
    if (_lock) return;

    var voters = state.voters;
    voters[index] = DefaultInput.dirty(value: val);

    emit(state.copyWith(
      voters: voters,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void removeVoter(int index) {
    if (_lock) return;

    final voters = state.voters;
    voters.removeAt(index);

    emit(state.copyWith(
      voters: voters,
      status: FormzSubmissionStatus.initial,
    ));
  }

  void clearVoter() {
    if (_lock) return;

    emit(state.copyWith(
      voters: [],
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
      if (state.election.error != null) {
        return ValidationObject(
          identifier: 'election',
          name: state.election.error!.name,
          message: state.election.error!.errorMessage,
        );
      }

      if (state.documentStatus.error != null) {
        return ValidationObject(
          identifier: 'document_status',
          name: state.documentStatus.error!.name,
          message: state.documentStatus.error!.errorMessage,
        );
      }

      for (var i = 0; i < state.voters.length; i++) {
        var e = state.voters[i];

        if (e.error != null) {
          return ValidationObject(
            identifier: 'voter_$i',
            name: 'Pemilih $i',
            message: e.error!.errorMessage,
          );
        }
      }

      return const ValidationObject();
    }

    return null;
  }

  Future<Either<Exception, bool>> _insertVoter(
    int electionRegistrationId,
    String name,
  ) async {
    return _electionVoterApi.create(rd: {
      'data': {
        'election_registration': electionRegistrationId,
        'name': name,
      }
    });
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
      int? id;

      final result = await _electionRegistrationApi.create(
        rd: {
          'users_permissions_user': _appKVS.userId!,
          'election': state.election.value,
          'document_status': state.documentStatus.value,
        },
        attachment: state.attachment.value,
      );

      result.fold(
        (err) => error = ErrorObject.mapExceptionToErrMsg(err),
        (res) => id = res,
      );

      if (error != null) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          error: error,
        ));
        return;
      }

      final result2 = await Future.wait(state.voters.map((e) {
        return _insertVoter(id!, e.value);
      }).toList());

      for (var i = 0; i < result2.length; i++) {
        var e = result2[i];
        if (e.isLeft()) {
          e.foldLeft<Exception?>(Exception(), (err, _) {
            emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
              error: ErrorObject.mapExceptionToErrMsg(err!),
            ));
            return;
          });
          return;
        }
      }

      emit(state.copyWith(
        election: const IdentifierInput.pure(),
        documentStatus: const IdentifierInput.pure(),
        voters: const [],
        attachment: const FileInput.pure(),
        status: FormzSubmissionStatus.success,
      ));
    }

    _lock = false;
  }

  void resetForm() {
    emit(const ElectionRegistrationState());
  }
}
