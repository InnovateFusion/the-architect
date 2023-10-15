part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserError extends UserState {
  const UserError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

final class UserCreated extends UserState {
  const UserCreated({required this.user});

  final User user;

  @override
  List<Object?> get props => [user];
}

final class UserUpdated extends UserState {
  const UserUpdated({required this.user});

  final User user;

  @override
  List<Object?> get props => [user];
}

final class UserDeleted extends UserState {
  const UserDeleted({required this.user});

  final User user;

  @override
  List<Object?> get props => [user];
}

final class UserLoaded extends UserState {
  const UserLoaded({required this.user});

  final User user;

  @override
  List<Object?> get props => [user];
}

final class UsersViewsLoaded extends UserState {
  const UsersViewsLoaded({required this.users});

  final List<User> users;

  @override
  List<Object?> get props => [users];
}

final class UserFollowingsLoaded extends UserState {
  const UserFollowingsLoaded({required this.user});

  final List<User> user;

  @override
  List<Object?> get props => [user];
}

final class UserFollowersLoaded extends UserState {
  const UserFollowersLoaded({required this.users});

  final List<User> users;

  @override
  List<Object?> get props => [users];
}
