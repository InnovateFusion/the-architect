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
      final auth = await authLocalDataSource.getToken();;
        final posts = await remoteDataSource.allPosts(search, tags, auth.accessToken);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> clone(String id) {
    // TODO: implement clone
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Post>> create(
      {required String image,
      required String title,
      String? content,
      required String userId,
      required List<String> tags}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Post>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Post>> like(String id) {
    // TODO: implement like
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Post>> unclone(String id) {
    // TODO: implement unclone
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Post>> unlike(String id) {
    // TODO: implement unlike
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Post>> update(
      {required String id,
      required String image,
      required String title,
      String? content,
      required String userId,
      required List<String> tags}) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Post>> view(String id) {
    // TODO: implement view
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Post>>> views(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final auth = await authLocalDataSource.getToken();
        final posts = await remoteDataSource.viewsPost(userId, auth.accessToken);
        return Right(posts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
