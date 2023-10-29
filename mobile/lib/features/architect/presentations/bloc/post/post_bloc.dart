import 'package:architect/features/architect/domains/use_cases/post/all.dart'
    as all_posts;
import 'package:architect/features/architect/domains/use_cases/post/clone.dart'
    as clone_posts;
import 'package:architect/features/architect/domains/use_cases/post/create.dart'
    as create_posts;
import 'package:architect/features/architect/domains/use_cases/post/delete.dart'
    as delete_posts;
import 'package:architect/features/architect/domains/use_cases/post/like.dart'
    as like_posts;
import 'package:architect/features/architect/domains/use_cases/post/unlike.dart'
    as unlike_posts;
import 'package:architect/features/architect/domains/use_cases/post/update.dart'
    as update_posts;
import 'package:architect/features/architect/domains/use_cases/post/view.dart'
    as view_posts;
import 'package:architect/features/architect/domains/use_cases/post/views.dart'
    as views_posts;
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domains/entities/post.dart';

part 'post_event.dart';
part 'post_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Something went wrong';
const String CACHE_FAILURE_MESSAGE = 'Something went wrong, please try again';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

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
  }) : super(const PostState()) {
    on<AllPosts>(
      _onAllPosts,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ViewsPosts>(
      _onViewsPosts,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ClonePostEvent>(
      _onClonePosts,
      transformer: throttleDroppable(throttleDuration),
    );
    on<LikePostEvent>(
      _onLikePosts,
      transformer: throttleDroppable(throttleDuration),
    );
    on<UnLikePostEvent>(
      _onUnLikePosts,
      transformer: throttleDroppable(throttleDuration),
    );
    on<CreatePostEvent>(
      _onCreatePost,
      transformer: throttleDroppable(throttleDuration),
    );
    on<DeletePostEvent>(
      _onDeletePost,
      transformer: throttleDroppable(throttleDuration),
    );
    on<EditPostEvent>(
      _onUpdatePost,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ViewPostEvent>(
      _onViewPost,
      transformer: throttleDroppable(throttleDuration),
    );
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
    if (state.posts.isEmpty) {
      emit(state.copyWith(status: PostStatusAll.loading));
    }

    final haveTagorSearch = (event.tags != null && event.tags!.isNotEmpty) ||
        (event.search != null && event.search!.isNotEmpty);

    if (state.hasReachedMax &&
        !haveTagorSearch &&
        (event.tags != null && event.tags!.isEmpty)) {
      if (state.posts.isNotEmpty) {
        emit(state.copyWith(status: PostStatusAll.success));
      }
    }

    final failureOrPosts = await allPosts(all_posts.Params(
      tags: event.tags,
      search: event.search,
      skip: haveTagorSearch || (event.tags != null && event.tags!.isEmpty)
          ? 0
          : state.posts.length,
      limit: haveTagorSearch ? 100 : 8,
    ));

    if (haveTagorSearch || state.posts.isEmpty || event.tags != null) {
      emit(state.copyWith(status: PostStatusAll.loading));
    }

    emit(
      failureOrPosts.fold(
        (failure) => const PostState(status: PostStatusAll.failure, posts: []),
        (posts) {
          if (haveTagorSearch) {
            return PostState(
              hasReachedMax: true,
              status: PostStatusAll.success,
              posts: posts,
            );
          } else {
            if (posts.isEmpty) {
              return state.copyWith(
                  hasReachedMax: true,
                  status: PostStatusAll.success,
                  posts: state.posts);
            } else {
              return PostState(
                hasReachedMax: false,
                status: PostStatusAll.success,
                posts: event.tags != null && event.tags!.isEmpty
                    ? posts
                    : state.posts + posts,
              );
            }
          }
        },
      ),
    );
  }

  Future<void> _onViewsPosts(ViewsPosts event, Emitter<PostState> emit) async {
    emit(state.copyWith(otherPostStatus: PostStatus.loading));
    final failureOrPosts = await viewsPost(views_posts.Params(
      id: event.userId,
    ));
    print('viewsPosts');
    print(failureOrPosts);
    emit(failureOrPosts.fold(
      (failure) => PostState(
        status: state.status,
        otherPostStatus: PostStatus.failure,
        posts: state.posts,
      ),
      (posts) => PostState(
        status: state.status,
        posts: state.posts,
        otherPostStatus: PostStatus.success,
        userPosts: posts,
      ),
    ));
  }

  Future<void> _onLikePosts(
      LikePostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(otherPostStatus: PostStatus.loading));
    final failureOrPosts = await likePost(like_posts.Params(
      postId: event.postId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostState(
          otherPostStatus: PostStatus.failure,
          posts: state.posts,
          status: state.status,
        ),
        (post) {
          final index =
              state.posts.indexWhere((element) => element.id == post.id);
          if (index != -1) {
            final List<Post> updatedPosts = List.from(state.posts);
            updatedPosts[index] = post;

            return PostState(
              otherPostStatus: PostStatus.success,
              post: post,
              posts: updatedPosts,
              status: state.status,
            );
          } else {
            return PostState(
              otherPostStatus: PostStatus.success,
              post: post,
              posts: state.posts,
              status: state.status,
            );
          }
        },
      ),
    );
  }

  Future<void> _onUnLikePosts(
      UnLikePostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(otherPostStatus: PostStatus.loading));
    final failureOrPosts = await unlikePost(unlike_posts.Params(
      postId: event.postId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostState(
          otherPostStatus: PostStatus.failure,
          posts: state.posts,
          status: state.status,
        ),
        (post) {
          final index =
              state.posts.indexWhere((element) => element.id == post.id);
          if (index != -1) {
            final List<Post> updatedPosts = List.from(state.posts);
            updatedPosts[index] = post;

            return PostState(
              otherPostStatus: PostStatus.success,
              post: post,
              posts: updatedPosts,
              status: state.status,
            );
          } else {
            return PostState(
              otherPostStatus: PostStatus.success,
              post: post,
              posts: state.posts,
              status: state.status,
            );
          }
        },
      ),
    );
  }

  Future<void> _onClonePosts(
      ClonePostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(otherPostStatus: PostStatus.loading));
    final failureOrPosts = await clonePost(clone_posts.Params(
      postId: event.postId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostState(
          otherPostStatus: PostStatus.failure,
          posts: state.posts,
          status: state.status,
        ),
        (post) {
          final index =
              state.posts.indexWhere((element) => element.id == post.id);
          if (index != -1) {
            final List<Post> updatedPosts = List.from(state.posts);
            updatedPosts[index] = post;

            return PostState(
              otherPostStatus: PostStatus.success,
              post: post,
              posts: updatedPosts,
              status: state.status,
            );
          } else {
            return PostState(
              otherPostStatus: PostStatus.success,
              post: post,
              posts: state.posts,
              status: state.status,
            );
          }
        },
      ),
    );
  }

  Future<void> _onCreatePost(
      CreatePostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(otherPostStatus: PostStatus.loading));
    final failureOrPosts = await createPost(create_posts.Params(
      image: event.image,
      title: event.title,
      content: event.content,
      tags: event.tags,
      userId: event.userId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostState(
          otherPostStatus: PostStatus.failure,
          posts: state.posts,
          status: state.status,
        ),
        (post) {
          return PostState(
            otherPostStatus: PostStatus.success,
            post: post,
            status: state.status,
            posts: [post] + state.posts,
          );
        },
      ),
    );
  }

  Future<void> _onUpdatePost(
      EditPostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(otherPostStatus: PostStatus.loading));
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
        (failure) => PostState(
          otherPostStatus: PostStatus.failure,
          posts: state.posts,
          status: state.status,
        ),
        (post) {
          final index =
              state.posts.indexWhere((element) => element.id == post.id);
          if (index != -1) {
            final List<Post> updatedPosts = List.from(state.posts);
            updatedPosts[index] = post;

            return PostState(
              otherPostStatus: PostStatus.success,
              post: post,
              posts: updatedPosts,
              status: state.status,
            );
          } else {
            return PostState(
              otherPostStatus: PostStatus.success,
              post: post,
              posts: state.posts,
              status: state.status,
            );
          }
        },
      ),
    );
  }

  Future<void> _onDeletePost(
      DeletePostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(otherPostStatus: PostStatus.loading));
    final failureOrPosts = await deletePost(delete_posts.Params(
      postId: event.postId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostState(
          otherPostStatus: PostStatus.failure,
          posts: state.posts,
          status: state.status,
        ),
        (post) {
          final index =
              state.posts.indexWhere((element) => element.id == post.id);
          if (index != -1) {
            final List<Post> updatedPosts = List.from(state.posts);
            updatedPosts.removeAt(index);
            return PostState(
              otherPostStatus: PostStatus.success,
              post: post,
              posts: updatedPosts,
              status: state.status,
            );
          } else {
            return PostState(
              otherPostStatus: PostStatus.success,
              post: post,
              posts: state.posts,
              status: state.status,
            );
          }
        },
      ),
    );
  }

  Future<void> _onViewPost(ViewPostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(otherPostStatus: PostStatus.loading));
    final failureOrPosts = await viewPost(view_posts.Params(
      id: event.postId,
    ));
    emit(
      failureOrPosts.fold(
        (failure) => PostState(
          otherPostStatus: PostStatus.failure,
          status: state.status,
          posts: state.posts,
        ),
        (post) {
          return PostState(
            otherPostStatus: PostStatus.success,
            post: post,
            posts: state.posts,
            status: state.status,
          );
        },
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
