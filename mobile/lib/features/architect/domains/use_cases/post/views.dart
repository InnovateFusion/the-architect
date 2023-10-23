import '../../../../../core/errors/failure.dart';
import '../../entities/post.dart';
import '../../repositories/post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/use_cases/usecase.dart';

class ViewsPost extends UseCase<List<Post>, Params> {
  final PostRepository repository;

  ViewsPost(this.repository);

  @override
  Future<Either<Failure, List<Post>>> call(Params params) async {
    return await repository.views(params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
