part of 'edit_profile_cubit.dart';

/// EditProfileState
class EditProfileState extends Equatable with FormzMixin {
  final EmailInput email;
  final DefaultInput fullname;
  final DefaultInput jenisKelamin;
  final DefaultInput rw;
  final DefaultInput rt;
  final DefaultInput alamat;
  final DefaultInput domisili;
  final FormzSubmissionStatus status;
  final ValidationObject? validation;
  final ErrorObject? error;

  const EditProfileState({
    this.email = const EmailInput.pure(),
    this.fullname = const DefaultInput.pure(),
    this.jenisKelamin = const DefaultInput.pure(),
    this.rw = const DefaultInput.pure(),
    this.rt = const DefaultInput.pure(),
    this.alamat = const DefaultInput.pure(),
    this.domisili = const DefaultInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.validation,
    this.error,
  });

  @override
  List<Object?> get props => [
        email,
        fullname,
        jenisKelamin,
        rw,
        rt,
        alamat,
        domisili,
        status,
        validation,
        error,
      ];

  @override
  List<FormzInput> get inputs => [
        email,
        fullname,
        jenisKelamin,
        rw,
        rt,
        alamat,
        domisili,
      ];

  EditProfileState copyWith({
    EmailInput? email,
    DefaultInput? fullname,
    DefaultInput? jenisKelamin,
    DefaultInput? rw,
    DefaultInput? rt,
    DefaultInput? alamat,
    DefaultInput? domisili,
    FormzSubmissionStatus? status,
    ValidationObject? validation,
    ErrorObject? error,
  }) {
    return EditProfileState(
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      rw: rw ?? this.rw,
      rt: rt ?? this.rt,
      alamat: alamat ?? this.alamat,
      domisili: domisili ?? this.domisili,
      status: status ?? this.status,
      validation: validation,
      error: error,
    );
  }
}
