part of 'post_bloc.dart';

@immutable
sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostError extends PostState {
  const PostError({required this.message});

  final String message;
}

final class PostCreated extends PostState {
  const PostCreated({required this.post});

  final Post post;

  @override
  List<Object?> get props => [post];
}

final class PostUpdated extends PostState {
  const PostUpdated({required this.post});

  final Post post;

  @override
  List<Object?> get props => [post];
}

final class PostDeleted extends PostState {
  const PostDeleted({required this.post});

  final Post post;

  @override
  List<Object?> get props => [post];
}

final class PostLoaded extends PostState {
  const PostLoaded({required this.post});

  final Post post;

  @override
  List<Object?> get props => [post];
}

final class PostsViewsLoaded extends PostState {
  const PostsViewsLoaded({required this.posts});

  final List<Post> posts;

  @override
  List<Object?> get props => [posts];
}
