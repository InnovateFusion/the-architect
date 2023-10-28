import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domains/entities/post.dart';
import '../../domains/repositories/post.dart';
import '../datasources/local/auth.dart';
import '../datasources/remote/post.dart';

class PostRepositoryImpl extends PostRepository {
  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.authLocalDataSource,
  });

  final PostRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Future<Either<Failure, List<Post>>> all(
      {List<String>? tags, String? search}) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        ;
        final posts =
            await remoteDataSource.allPosts(search, tags, auth.accessToken);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> clone(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final post = await remoteDataSource.clonePost(id, auth.accessToken);
        return Right(post);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> create(
      {required String image,
      required String title,
      String? content,
      required String userId,
      required List<String> tags}) async {
    print("create post");

    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final post = await remoteDataSource.createPost(
          image: image,
          title: title,
          content: content,
          tags: tags,
          userId: userId,
          token: auth.accessToken,
        );
        print("create post success");
        return Right(post);
      } on ServerException {
        print("create post fail");
        return Left(ServerFailure());
      }
    } else {
      print("create post fail");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> delete(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final post = await remoteDataSource.deletePost(id, auth.accessToken);
        print("delete post success");
        return Right(post);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      print("delete post fail");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> like(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final post = await remoteDataSource.likePost(id, auth.accessToken);
        return Right(post);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> unclone(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final post = await remoteDataSource.unLikePost(id, auth.accessToken);
        return Right(post);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> unlike(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final post = await remoteDataSource.unLikePost(id, auth.accessToken);
        return Right(post);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> update(
      {required String id,
      required String image,
      required String title,
      String? content,
      required String userId,
      required List<String> tags}) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final post = await remoteDataSource.editPost(
          id: id,
          image: image,
          title: title,
          content: content,
          tags: tags,
          userId: userId,
          token: auth.accessToken,
        );
        print('update post success');
        return Right(post);
      } on ServerException {
        print('update post fail');
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> view(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final post = await remoteDataSource.viewPost(id, auth.accessToken);
        return Right(post);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> views(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final posts =
            await remoteDataSource.viewsPost(userId, auth.accessToken);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
