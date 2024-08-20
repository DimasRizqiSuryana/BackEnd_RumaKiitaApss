part of 'auth_bloc.dart';

/// AuthEvent
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStatusChanged extends AuthEvent {
  final bool? redirect;

  const AuthStatusChanged({
    this.redirect,
  });

  @override
  List<Object?> get props => [redirect];
}

class AuthLogoutRequested extends AuthEvent {}
