part of 'create_surat_pengajuan_cubit.dart';

/// CreateSuratPengajuanState
class CreateSuratPengajuanState extends Equatable with FormzMixin {
  final IdentifierInput jenisSuratPengajuan;
  final IdentifierInput documentStatus;
  final DefaultInput fullname;
  final EmailInput email;
  final DefaultInput alamat;
  final List<File> documents;
  final FormzSubmissionStatus status;
  final ValidationObject? validation;
  final ErrorObject? error;

  const CreateSuratPengajuanState({
    this.jenisSuratPengajuan = const IdentifierInput.pure(),
    this.documentStatus = const IdentifierInput.pure(),
    this.fullname = const DefaultInput.pure(),
    this.email = const EmailInput.pure(),
    this.alamat = const DefaultInput.pure(),
    this.documents = const [],
    this.status = FormzSubmissionStatus.initial,
    this.validation,
    this.error,
  });

  @override
  List<Object?> get props => [
        jenisSuratPengajuan,
        documentStatus,
        fullname,
        email,
        alamat,
        documents,
        status,
        validation,
        error,
      ];

  @override
  List<FormzInput> get inputs => [
        jenisSuratPengajuan,
        documentStatus,
        fullname,
        email,
        alamat,
      ];

  CreateSuratPengajuanState copyWith({
    IdentifierInput? jenisSuratPengajuan,
    IdentifierInput? documentStatus,
    DefaultInput? fullname,
    EmailInput? email,
    DefaultInput? alamat,
    List<File>? documents,
    FormzSubmissionStatus? status,
    ValidationObject? validation,
    ErrorObject? error,
  }) {
    return CreateSuratPengajuanState(
      jenisSuratPengajuan: jenisSuratPengajuan ?? this.jenisSuratPengajuan,
      documentStatus: documentStatus ?? this.documentStatus,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      alamat: alamat ?? this.alamat,
      documents: documents ?? this.documents,
      status: status ?? this.status,
      validation: validation,
      error: error,
    );
  }
}
