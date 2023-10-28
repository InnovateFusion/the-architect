import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/post.dart';
import '../../repositories/post.dart';

class CreatePost implements UseCase<Post, Params> {
  final PostRepository repository;

  const CreatePost(this.repository);

  @override
  Future<Either<Failure, Post>> call(Params params) async {
    return await repository.create(
      image: params.image,
      title: params.title,
      content: params.content,
      userId: params.userId,
      tags: params.tags,
    );
  }
}

class Params extends Equatable {
  final String image;
  final String title;
  final String? content;
  final String userId;
  final List<String> tags;

  const Params({
    required this.image,
    required this.title,
    this.content,
    required this.userId,
    required this.tags,
  });

  @override
  List<Object?> get props => [image, title, content, userId, tags];
}
