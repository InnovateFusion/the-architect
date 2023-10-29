part of 'post_bloc.dart';

enum PostStatusAll { initial, loading, success, failure }

enum PostStatus { initial, loading, success, failure }

class PostState extends Equatable {
  const PostState({
    this.status = PostStatusAll.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
    this.userPosts = const <Post>[],
    this.otherPostStatus = PostStatus.initial,
    this.post,
  });

  final PostStatusAll status;
  final List<Post> posts;
  final bool hasReachedMax;
  final List<Post> userPosts;
  final Post? post;
  final PostStatus otherPostStatus;

  PostState copyWith({
    PostStatusAll? status,
    List<Post>? posts,
    bool? hasReachedMax,
    List<Post>? userPosts,
    Post? post,
    PostStatus? otherPostStatus,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      userPosts: userPosts ?? this.userPosts,
      post: post ?? this.post,
      otherPostStatus: otherPostStatus ?? this.otherPostStatus,
    );
  }

  @override
  String toString() {
    return '''PostState(
      status: $status,
      posts: $posts,
      hasReachedMax: $hasReachedMax,
      userPosts: $userPosts,
      post: $post,
      otherPostStatus: $otherPostStatus,

    )''';
  }

  @override
  List<Object> get props => [
        status,
        posts,
        hasReachedMax,
        userPosts,
        otherPostStatus,
      ];
}
