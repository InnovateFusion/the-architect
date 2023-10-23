import 'package:architect/features/architect/domains/use_cases/post/all.dart'
    as all_posts;
import 'package:architect/features/architect/domains/use_cases/post/views.dart'
    as views_posts;
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
  }) : super(PostInitial()) {
    on<AllPosts>(_onAllPosts);
    on<ViewsPosts>(_onViewsPosts);
  }

  final views_posts.ViewsPost viewsPost;
  final all_posts.AllPost allPosts;

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
