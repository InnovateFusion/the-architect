import 'package:architect/features/architect/domains/use_cases/user/create.dart'
    as create_user;
import 'package:architect/features/architect/domains/use_cases/user/delete.dart'
    as delete_user;
import 'package:architect/features/architect/domains/use_cases/user/follow.dart'
    as follow_user;
import 'package:architect/features/architect/domains/use_cases/user/followers.dart'
    as followers_user;
import 'package:architect/features/architect/domains/use_cases/user/following.dart'
    as following_user;
import 'package:architect/features/architect/domains/use_cases/user/me.dart'
    as get_users;
import 'package:architect/features/architect/domains/use_cases/user/unfollow.dart'
    as unfollow_user;
import 'package:architect/features/architect/domains/use_cases/user/update.dart'
    as update_user;
import 'package:architect/features/architect/domains/use_cases/user/view.dart'
    as get_user;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../../domains/entities/user.dart';

part 'user_event.dart';
part 'user_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Something went wrong';
const String CACHE_FAILURE_MESSAGE = 'Something went wrong, please try again';

class UserBloc extends Bloc<UserEvent, UserState> {
  final create_user.UserCreate createUser;
  final delete_user.DeleteUser deleteUser;
  final get_user.ViewUser getUser;
  final get_users.Me getCurrentUser;
  final update_user.UserUpdate updateUser;
  final follow_user.FollowUser followUser;
  final unfollow_user.UnFollowUser unfollowUser;
  final following_user.UserFollowing followingUser;
  final followers_user.UserFollowers followersUser;

  UserBloc({
    required this.createUser,
    required this.deleteUser,
    required this.getUser,
    required this.getCurrentUser,
    required this.updateUser,
    required this.followUser,
    required this.unfollowUser,
    required this.followingUser,
    required this.followersUser,
  }) : super(UserInitial()) {
    on<CreateUserEvent>(_onCreateUser);
    on<UpdateUserEvent>(_onUpdate);
    on<DeleteUserEvent>(_onDelete);
    on<ViewUserEvent>(_onGetUser);
    on<ViewUsersEvent>(_onGetUsers);
    on<FollowUserEvent>(_onFollowUser);
    on<UnFollowUserEvent>(_onUnFollowUser);
    on<FollowingUserEvent>(_onFollowingUser);
    on<FollowersUserEvent>(_onFollowersUser);
  }

  Future<void> _onCreateUser(
      CreateUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await createUser(create_user.Params(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      image: event.image,
      bio: event.bio,
      country: event.country,
    ));
    result.fold(
      (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
      (user) => emit(UserCreated(user: user)),
    );
  }

  Future<void> _onUpdate(UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await updateUser(update_user.Params(
      id: event.id,
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      image: event.image,
      bio: event.bio,
      country: event.country,
    ));
    result.fold(
      (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
      (user) => emit(UserUpdated(user: user)),
    );
  }

  Future<void> _onDelete(DeleteUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await deleteUser(delete_user.Params(event.id));
    result.fold(
      (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
      (user) => emit(UserDeleted(user: user)),
    );
  }

  Future<void> _onGetUser(ViewUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await getUser(get_user.Params(event.id));
    result.fold(
      (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
      (user) => emit(UserLoaded(user: user)),
    );
  }

  Future<void> _onGetUsers(
      ViewUsersEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await getCurrentUser(NoParams());
    result.fold(
      (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
      (users) => emit(UserLoaded(user: users)),
    );
  }

  Future<void> _onFollowUser(
      FollowUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await followUser(follow_user.Params(event.id));
    result.fold(
      (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
      (user) => emit(UserUpdated(user: user)),
    );
  }

  Future<void> _onUnFollowUser(
      UnFollowUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await unfollowUser(unfollow_user.Params(event.id));
    result.fold(
      (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
      (user) => emit(UserUpdated(user: user)),
    );
  }

  Future<void> _onFollowingUser(
      FollowingUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await followingUser(following_user.Params(event.id));
    result.fold(
      (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
      (users) => emit(UsersViewsLoaded(users: users)),
    );
  }

  Future<void> _onFollowersUser(
      FollowersUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await followersUser(followers_user.Params(event.id));
    result.fold(
      (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
      (users) => emit(UsersViewsLoaded(users: users)),
    );
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
