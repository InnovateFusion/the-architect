import '../../../../../core/errors/failure.dart';
import '../../entities/post.dart';
import '../../repositories/post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/use_cases/usecase.dart';

class DeletePost extends UseCase<Post, Params> {
  final PostRepository repository;

  DeletePost(this.repository);

  @override
  Future<Either<Failure, Post>> call(Params params) async {
    return await repository.delete(params.postId);
  }
}

class Params extends Equatable {
  final String postId;

  const Params({required this.postId});

  @override
  List<Object?> get props => [postId];
}
