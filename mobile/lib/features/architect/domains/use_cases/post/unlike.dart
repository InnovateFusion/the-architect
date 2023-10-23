import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/post.dart';
import '../../repositories/post.dart';


class UnlikePost extends UseCase<Post, Params> {

  final PostRepository repository;

  UnlikePost(this.repository);

  @override
  Future<Either<Failure, Post>> call(Params params) async {
    return await repository.unlike(params.postId);
  }
}

class Params extends Equatable {
  final String postId;

  const Params({required this.postId});

  @override
  List<Object?> get props => [postId];
}
