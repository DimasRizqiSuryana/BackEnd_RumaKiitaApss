part of 'auth_bloc.dart';

/// AuthStatus
enum AuthStatus { none, unauthenticated, authenticated }

extension AuthStatusX on AuthStatus {
  bool get isNone => this == AuthStatus.none;
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
  bool get isAuthenticated => this == AuthStatus.authenticated;
}

/// AuthState
class AuthState extends Equatable {
  final AuthStatus status;
  final bool redirect;
  final MeModel? user;
  final ErrorObject? error;

  const AuthState._({
    required this.status,
    required this.redirect,
    this.user,
    this.error,
  });

  const AuthState.none()
      : this._(
          status: AuthStatus.none,
          redirect: true,
        );

  const AuthState.authenticated({
    bool? redirect,
    MeModel? user,
    ErrorObject? error,
  }) : this._(
          status: AuthStatus.authenticated,
          redirect: redirect ?? true,
          user: user,
          error: error,
        );

  const AuthState.unauthenticated({
    bool? redirect,
    ErrorObject? error,
  }) : this._(
          status: AuthStatus.unauthenticated,
          redirect: redirect ?? true,
          error: error,
        );

  @override
  List<Object?> get props => [
        status,
        redirect,
        user,
        error,
      ];
}
