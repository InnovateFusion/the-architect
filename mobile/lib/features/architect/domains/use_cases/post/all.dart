import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/post.dart';
import '../../repositories/post.dart';

class AllPost implements UseCase<List<Post>, Params> {
  final PostRepository repository;

  const AllPost(this.repository);

  @override
  Future<Either<Failure, List<Post>>> call(Params params) async {
    return await repository.all(
      search: params.search,
      tags: params.tags,
      skip: params.skip,
      limit: params.limit,
    );
  }
}

class Params extends Equatable {
  final List<String>? tags;
  final String? search;
  final int? skip;
  final int? limit;

  const Params({
    this.tags,
    this.search,
    this.skip,
    this.limit,
  });

  @override
  List<Object?> get props => [tags, search];
}
