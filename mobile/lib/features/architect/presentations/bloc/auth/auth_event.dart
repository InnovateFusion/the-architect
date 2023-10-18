part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthInitialEvent extends AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  const AuthLoginEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

final class AuthCheckEvent extends AuthEvent {}
