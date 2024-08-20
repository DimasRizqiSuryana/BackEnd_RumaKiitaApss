part of 'create_kegiatan_cubit.dart';

/// CreateKegiatanState
class CreateKegiatanState extends Equatable with FormzMixin {
  final IdentifierInput kategoriKegiatan;
  final IdentifierInput documentStatus;
  final DefaultInput title;
  final DefaultInput description;
  final DefaultInput startDate;
  final DefaultInput finishDate;
  final FileInput attachment;
  final FormzSubmissionStatus status;
  final ValidationObject? validation;
  final ErrorObject? error;

  const CreateKegiatanState({
    this.kategoriKegiatan = const IdentifierInput.pure(),
    this.documentStatus = const IdentifierInput.pure(),
    this.title = const DefaultInput.pure(),
    this.description = const DefaultInput.pure(),
    this.startDate = const DefaultInput.pure(),
    this.finishDate = const DefaultInput.pure(),
    this.attachment = const FileInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.validation,
    this.error,
  });

  @override
  List<Object?> get props => [
        kategoriKegiatan,
        documentStatus,
        title,
        description,
        startDate,
        finishDate,
        attachment,
        status,
        validation,
        error,
      ];

  @override
  List<FormzInput> get inputs => [
        kategoriKegiatan,
        documentStatus,
        title,
        description,
        startDate,
        finishDate,
        attachment,
      ];

  CreateKegiatanState copyWith({
    IdentifierInput? kategoriKegiatan,
    IdentifierInput? documentStatus,
    DefaultInput? title,
    DefaultInput? description,
    DefaultInput? startDate,
    DefaultInput? finishDate,
    FileInput? attachment,
    FormzSubmissionStatus? status,
    ValidationObject? validation,
    ErrorObject? error,
  }) {
    return CreateKegiatanState(
      kategoriKegiatan: kategoriKegiatan ?? this.kategoriKegiatan,
      documentStatus: documentStatus ?? this.documentStatus,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      finishDate: finishDate ?? this.finishDate,
      attachment: attachment ?? this.attachment,
      status: status ?? this.status,
      validation: validation,
      error: error,
    );
  }
}
