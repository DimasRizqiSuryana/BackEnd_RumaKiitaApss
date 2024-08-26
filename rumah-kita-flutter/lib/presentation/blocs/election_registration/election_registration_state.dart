part of 'election_registration_cubit.dart';

/// ElectionRegistrationState
class ElectionRegistrationState extends Equatable with FormzMixin {
  final IdentifierInput kegiatan;
  final IdentifierInput election;
  final IdentifierInput documentStatus;
  final List<DefaultInput> voters;
  final FileInput attachment;
  final FormzSubmissionStatus status;
  final ValidationObject? validation;
  final ErrorObject? error;

  const ElectionRegistrationState({
    this.kegiatan = const IdentifierInput.pure(),
    this.election = const IdentifierInput.pure(),
    this.documentStatus = const IdentifierInput.pure(),
    this.voters = const [],
    this.attachment = const FileInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.validation,
    this.error,
  });

  @override
  List<Object?> get props => [
        kegiatan,
        election,
        documentStatus,
        voters,
        attachment,
        status,
        validation,
        error,
      ];

  @override
  List<FormzInput> get inputs => [
        kegiatan,
        election,
        documentStatus,
        attachment,
      ];

  ElectionRegistrationState copyWith({
    IdentifierInput? kegiatan,
    IdentifierInput? election,
    IdentifierInput? documentStatus,
    List<DefaultInput>? voters,
    FileInput? attachment,
    FormzSubmissionStatus? status,
    ValidationObject? validation,
    ErrorObject? error,
  }) {
    return ElectionRegistrationState(
      kegiatan: kegiatan ?? this.kegiatan,
      election: election ?? this.election,
      documentStatus: documentStatus ?? this.documentStatus,
      voters: voters ?? this.voters,
      attachment: attachment ?? this.attachment,
      status: status ?? this.status,
      validation: validation,
      error: error,
    );
  }
}
