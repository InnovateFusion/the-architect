import 'package:architect/core/use_cases/usecase.dart';
import 'package:architect/features/architect/domains/repositories/post.dart';
import 'package:architect/features/architect/presentations/widget/post/post.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


import '../../../../../core/errors/failure.dart';

class AllPost implements UseCase<List<Post>, Params> {
  final PostRepository repository;

  const AllPost(this.repository);

  @override
  Future<Either<Failure, List<Post>>> call(Params params) async {
    return await repository.all();
  }
}

class Params extends Equatable {
  
  final List<String>? tags;
  final String? search;

  const Params({
    this.tags,
    this.search,
  });

  @override
  List<Object?> get props => [tags, search];
}