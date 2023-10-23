import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/post.dart';
import '../../repositories/post.dart';

class ViewPost extends UseCase<Post, Params> {
  final PostRepository repository;

  ViewPost(this.repository);

  @override
  Future<Either<Failure, Post>> call(Params params) async {
    return await repository.view(params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}