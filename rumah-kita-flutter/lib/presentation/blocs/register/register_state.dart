part of 'register_cubit.dart';

/// RegisterState
class RegisterState extends Equatable with FormzMixin {
  final UsernameInput username;
  final EmailInput email;
  final PasswordInput password;
  final DefaultInput fullname;
  final DefaultInput jenisKelamin;
  final DefaultInput rw;
  final DefaultInput rt;
  final DefaultInput alamat;
  final DefaultInput domisili;
  final FormzSubmissionStatus status;
  final ValidationObject? validation;
  final ErrorObject? error;

  const RegisterState({
    this.username = const UsernameInput.pure(),
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
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
        username,
        email,
        password,
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
        username,
        email,
        password,
        fullname,
        jenisKelamin,
        rw,
        rt,
        alamat,
        domisili,
      ];

  RegisterState copyWith({
    UsernameInput? username,
    EmailInput? email,
    PasswordInput? password,
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
    return RegisterState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
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
