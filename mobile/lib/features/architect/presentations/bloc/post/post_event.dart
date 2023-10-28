part of 'post_bloc.dart';

@immutable
sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}



final class AllPosts extends PostEvent {
  const AllPosts({
    this.search,
    this.tags,
  });

  final String? search;
  final List<String>? tags;

  @override
  List<Object?> get props => [search, tags];
}

final class ViewsPosts extends PostEvent {
  const ViewsPosts({
    required this.userId,
  });

  final String userId;

  @override
  List<Object> get props => [userId];
}

final class ClonePostEvent extends PostEvent {
  final String postId;
  const ClonePostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}

final class LikePostEvent extends PostEvent {
  final String postId;
  const LikePostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}

final class UnLikePostEvent extends PostEvent {
  final String postId;
  const UnLikePostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}

final class ViewPostEvent extends PostEvent {
  final String postId;
  const ViewPostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}

final class CreatePostEvent extends PostEvent {
  final String image;
  final String title;
  final String? content;
  final List<String> tags;
  final String userId;
  const CreatePostEvent({
    required this.image,
    required this.title,
    this.content,
    required this.tags,
    required this.userId,
  });
  @override
  List<Object> get props => [image, title, tags, userId];
}

final class EditPostEvent extends PostEvent {
  final String image;
  final String title;
  final String? content;
  final List<String> tags;
  final String userId;
  final String postId;
  const EditPostEvent({
    required this.image,
    required this.title,
    this.content,
    required this.tags,
    required this.userId,
    required this.postId,
  });
  @override
  List<Object> get props => [image, title, tags, userId, postId];
}

final class DeletePostEvent extends PostEvent {
  final String postId;
  const DeletePostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}
