part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoggedOut extends AuthState {}

final class Authenticated extends AuthState {
  const Authenticated({required this.auth});

  final Auth auth;

  @override
  List<Object?> get props => [auth];

}

final class AuthError extends AuthState {
  const AuthError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

final class AuthLogged extends AuthState {
  const AuthLogged({required this.auth});

  final Auth auth;

  @override
  List<Object?> get props => [auth];
}
