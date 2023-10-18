import 'package:architect/core/errors/failure.dart';
import 'package:architect/features/architect/domains/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  
  Future<Either<Failure, Post>> create({
    required String image,
    required String title,
    String? content,
    required String userId,
    required List<String> tags,
  });
  
  Future<Either<Failure, Post>> update({
    required String id,
    required String image,
    required String title,
    String? content,
    required String userId,
    required List<String> tags,
  });

  Future<Either<Failure, List<Post>>> all({
    List<String>? tags,
    String? search,
  });
  
  Future<Either<Failure, Post>> delete(String id);
  Future<Either<Failure, Post>> view(String id);
  Future<Either<Failure, Post>> like(String id);
  Future<Either<Failure, Post>> unlike(String id);
  Future<Either<Failure, Post>> clone(String id);
  Future<Either<Failure, Post>> unclone(String id);
  Future<Either<Failure, List<Post>>> views(String userId);
}
