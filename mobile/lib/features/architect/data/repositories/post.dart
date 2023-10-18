import 'package:architect/core/errors/failure.dart';
import 'package:architect/features/architect/domains/entities/post.dart';
import 'package:architect/features/architect/domains/repositories/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/remote/post.dart';

class PostRepositoryImpl extends PostRepository {
  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final PostRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Post>>> all(
      {List<String>? tags, String? search}) async {
    if (await networkInfo.isConnected) {
      try {
        String token =
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjM3OTg1NDEyMzcyLCJlbWFpbCI6ImRldkBiaXNyYXQudGVjaCIsImlkIjoiMzVhNzBmZGYtN2Q3ZC00ZjJmLWE5N2MtNWUxZWViNWJjMzNhIiwiZmlyc3RfbmFtZSI6ImJpc3JhdCIsImxhc3RfbmFtZSI6ImtlYmVyZSJ9.zmNKEcv9WYhEhe9J5ydYTsVkaF63oKBifrSPwQLXXoE';
        final posts = await remoteDataSource.allPosts(search, tags, token);
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
  Future<Either<Failure, List<Post>>> views(String userId) {
    // TODO: implement views
    throw UnimplementedError();
  }
}
