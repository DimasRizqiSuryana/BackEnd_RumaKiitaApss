part of 'election_registration_cubit.dart';

/// ElectionRegistrationState
class ElectionRegistrationState extends Equatable with FormzMixin {
  final IdentifierInput election;
  final IdentifierInput documentStatus;
  final List<DefaultInput> voters;
  final FileInput attachment;
  final FormzSubmissionStatus status;
  final ValidationObject? validation;
  final ErrorObject? error;

  const ElectionRegistrationState({
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
        election,
        documentStatus,
        attachment,
      ];

  ElectionRegistrationState copyWith({
    IdentifierInput? election,
    IdentifierInput? documentStatus,
    List<DefaultInput>? voters,
    FileInput? attachment,
    FormzSubmissionStatus? status,
    ValidationObject? validation,
    ErrorObject? error,
  }) {
    return ElectionRegistrationState(
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
