import 'package:architect/core/errors/failure.dart';
import 'package:architect/features/architect/domains/entities/post.dart';
import 'package:architect/features/architect/domains/repositories/post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/use_cases/usecase.dart';

class LikePost extends UseCase<Post, Params> {

  final PostRepository repository;

  LikePost(this.repository);

  @override
  Future<Either<Failure, Post>> call(Params params) async {
    return await repository.like(params.postId);
  }
}


class Params extends Equatable {
  final String postId;

  const Params({required this.postId});

  @override
  List<Object?> get props => [postId];
}
