import 'package:architect/features/architect/domains/use_cases/post/all.dart'
    as all_posts;
import 'package:architect/features/architect/domains/use_cases/post/clone.dart'
    as clone_posts;
import 'package:architect/features/architect/domains/use_cases/post/like.dart'
    as like_posts;
import 'package:architect/features/architect/domains/use_cases/post/unlike.dart'
    as unlike_posts;
import 'package:architect/features/architect/domains/use_cases/post/views.dart'
    as views_posts;
import 'package:architect/features/architect/domains/use_cases/post/create.dart'
    as create_posts;
import 'package:architect/features/architect/domains/use_cases/post/delete.dart'
    as delete_posts;
import 'package:architect/features/architect/domains/use_cases/post/update.dart'
    as update_posts;
import 'package:architect/features/architect/domains/use_cases/post/view.dart'
    as view_posts;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domains/entities/post.dart';

part 'post_event.dart';
part 'post_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Something went wrong';
const String CACHE_FAILURE_MESSAGE = 'Something went wrong, please try again';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({
    required this.allPosts,
    required this.viewsPost,
    required this.clonePost,
    required this.likePost,
    required this.unlikePost,
    required this.createPost,
    required this.deletePost,
    required this.updatePost,
    required this.viewPost,
  }) : super(PostInitial()) {
    on<AllPosts>(_onAllPosts);
    on<ViewsPosts>(_onViewsPosts);
    on<ClonePostEvent>(_onClonePosts);
    on<LikePostEvent>(_onLikePosts);
    on<UnLikePostEvent>(_onUnLikePosts);
    on<CreatePostEvent>(_onCreatePost);
    on<DeletePostEvent>(_onDeletePost);
    on<EditPostEvent>(_onUpdatePost);
    on<ViewPostEvent>(_onViewPost);
  }

  final clone_posts.ClonePost clonePost;
  final views_posts.ViewsPost viewsPost;
  final like_posts.LikePost likePost;
  final unlike_posts.UnlikePost unlikePost;
  final all_posts.AllPost allPosts;
  final create_posts.CreatePost createPost;
  final delete_posts.DeletePost deletePost;
  final update_posts.UpdatePost updatePost;
  final view_posts.ViewPost viewPost;

  Future<void> _onAllPosts(AllPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final failureOrPosts = await allPosts(all_posts.Params(
      tags: event.tags,
      search: event.search,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostError(message: _mapFailureToMessage(failure)),
        (posts) => PostsViewsLoaded(posts: posts),
      ),
    );
  }

  Future<void> _onViewsPosts(ViewsPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final failureOrPosts = await viewsPost(views_posts.Params(
      id: event.userId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostError(message: _mapFailureToMessage(failure)),
        (posts) => PostsViewsLoaded(posts: posts),
      ),
    );
  }

  Future<void> _onClonePosts(
      ClonePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final failureOrPosts = await clonePost(clone_posts.Params(
      postId: event.postId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostError(message: _mapFailureToMessage(failure)),
        (post) => PostLoaded(post: post),
      ),
    );
  }

  Future<void> _onLikePosts(
      LikePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final failureOrPosts = await likePost(like_posts.Params(
      postId: event.postId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostError(message: _mapFailureToMessage(failure)),
        (post) => PostLoaded(post: post),
      ),
    );
  }

  Future<void> _onUnLikePosts(
      UnLikePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final failureOrPosts = await unlikePost(unlike_posts.Params(
      postId: event.postId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostError(message: _mapFailureToMessage(failure)),
        (post) => PostLoaded(post: post),
      ),
    );
  }

  Future<void> _onCreatePost(
      CreatePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final failureOrPosts = await createPost(create_posts.Params(
      image: event.image,
      title: event.title,
      content: event.content,
      tags: event.tags,
      userId: event.userId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostError(message: _mapFailureToMessage(failure)),
        (post) => PostCreated(post: post),
      ),
    );
  }

  Future<void> _onDeletePost(
      DeletePostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final failureOrPosts = await deletePost(delete_posts.Params(
      postId: event.postId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostError(message: _mapFailureToMessage(failure)),
        (post) => PostDeleted(post: post),
      ),
    );
  }

  Future<void> _onUpdatePost(
      EditPostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final failureOrPosts = await updatePost(update_posts.Params(
      image: event.image,
      title: event.title,
      content: event.content,
      tags: event.tags,
      userId: event.userId,
      id: event.postId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostError(message: _mapFailureToMessage(failure)),
        (post) => PostUpdated(post: post),
      ),
    );
  }

  Future<void> _onViewPost(ViewPostEvent event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final failureOrPosts = await viewPost(view_posts.Params(
      id: event.postId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostError(message: _mapFailureToMessage(failure)),
        (post) => PostLoaded(post: post),
      ),
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
