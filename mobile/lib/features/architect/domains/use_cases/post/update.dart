import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/post.dart';
import '../../repositories/post.dart';

class UpdatePost implements UseCase<Post, Params> {
  final PostRepository repository;

  const UpdatePost(this.repository);

  @override
  Future<Either<Failure, Post>> call(Params params) async {
    return await repository.update(
      id: params.id,
      image: params.image,
      title: params.title,
      content: params.content,
      userId: params.userId,
      tags: params.tags,
    );
  }
}

class Params extends Equatable {
  final String id;
  final String image;
  final String title;
  final String? content;
  final String userId;
  final List<String> tags;

  const Params({
    required this.id,
    required this.image,
    required this.title,
    this.content,
    required this.userId,
    required this.tags,
  });

  @override
  List<Object?> get props => [image, title, content, userId, tags];
}
