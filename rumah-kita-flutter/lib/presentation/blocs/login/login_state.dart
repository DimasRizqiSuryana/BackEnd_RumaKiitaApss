part of 'login_cubit.dart';

/// LoginState
class LoginState extends Equatable with FormzMixin {
  final DefaultInput identifier;
  final DefaultInput password;
  final FormzSubmissionStatus status;
  final ValidationObject? validation;
  final ErrorObject? error;

  const LoginState({
    this.identifier = const DefaultInput.pure(),
    this.password = const DefaultInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.validation,
    this.error,
  });

  @override
  List<Object?> get props => [
        identifier,
        password,
        status,
        validation,
        error,
      ];

  @override
  List<FormzInput> get inputs => [identifier, password];

  LoginState copyWith({
    DefaultInput? identifier,
    DefaultInput? password,
    FormzSubmissionStatus? status,
    ValidationObject? validation,
    ErrorObject? error,
  }) {
    return LoginState(
      identifier: identifier ?? this.identifier,
      password: password ?? this.password,
      status: status ?? this.status,
      validation: validation,
      error: error,
    );
  }
}
