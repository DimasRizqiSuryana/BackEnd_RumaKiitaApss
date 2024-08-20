part of 'create_aduan_cubit.dart';

/// CreateAduanState
class CreateAduanState extends Equatable with FormzMixin {
  final IdentifierInput documentStatus;
  final DefaultInput title;
  final DefaultInput description;
  final DefaultInput location;
  final DefaultInput dateofIncident;
  final FileInput attachment;
  final FormzSubmissionStatus status;
  final ValidationObject? validation;
  final ErrorObject? error;

  const CreateAduanState({
    this.documentStatus = const IdentifierInput.pure(),
    this.title = const DefaultInput.pure(),
    this.description = const DefaultInput.pure(),
    this.location = const DefaultInput.pure(),
    this.dateofIncident = const DefaultInput.pure(),
    this.attachment = const FileInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.validation,
    this.error,
  });

  @override
  List<Object?> get props => [
        documentStatus,
        title,
        description,
        location,
        dateofIncident,
        attachment,
        status,
        validation,
        error,
      ];

  @override
  List<FormzInput> get inputs => [
        documentStatus,
        title,
        description,
        location,
        dateofIncident,
        attachment,
      ];

  CreateAduanState copyWith({
    IdentifierInput? documentStatus,
    DefaultInput? title,
    DefaultInput? description,
    DefaultInput? location,
    DefaultInput? dateofIncident,
    FileInput? attachment,
    FormzSubmissionStatus? status,
    ValidationObject? validation,
    ErrorObject? error,
  }) {
    return CreateAduanState(
      documentStatus: documentStatus ?? this.documentStatus,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      dateofIncident: dateofIncident ?? this.dateofIncident,
      attachment: attachment ?? this.attachment,
      status: status ?? this.status,
      validation: validation,
      error: error,
    );
  }
}
