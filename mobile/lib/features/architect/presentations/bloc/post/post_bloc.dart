import 'package:architect/features/architect/domains/entities/post.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:architect/features/architect/domains/use_cases/post/all.dart'
    as all_posts;

import '../../../../../core/errors/failure.dart';

part 'post_event.dart';
part 'post_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Something went wrong';
const String CACHE_FAILURE_MESSAGE = 'Something went wrong, please try again';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({
    required this.allPosts,
  }) : super(PostInitial()) {
    on<AllPosts>(_onAllPosts);
  }

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
