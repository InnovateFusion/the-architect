part of 'user_bloc.dart';

@immutable
sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

final class CreateUserEvent extends UserEvent {
  const CreateUserEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.image,
    this.bio,
    this.country,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? image;
  final String? bio;
  final String? country;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        image,
        bio,
        country,
      ];
}

final class UpdateUserEvent extends UserEvent {
  const UpdateUserEvent({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.image,
    this.bio,
    this.country,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? image;
  final String? bio;
  final String? country;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        password,
        image,
        bio,
        country,
      ];
}

final class DeleteUserEvent extends UserEvent {
  const DeleteUserEvent({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

final class ViewUserEvent extends UserEvent {
  const ViewUserEvent({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

final class ViewUsersEvent extends UserEvent {}

final class FollowingUserEvent extends UserEvent {
  const FollowingUserEvent({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

final class FollowUserEvent extends UserEvent {
  const FollowUserEvent({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

final class UnFollowUserEvent extends UserEvent {
  const UnFollowUserEvent({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

final class FollowersUserEvent extends UserEvent {
  const FollowersUserEvent({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
