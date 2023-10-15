import 'package:architect/core/errors/failure.dart';
import 'package:architect/core/use_cases/usecase.dart';
import 'package:architect/features/architect/domains/entities/chat.dart';
import 'package:architect/features/architect/domains/repositories/chat.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ViewsChat extends UseCase<Chat, Params> {
  ViewsChat({
    required this.repository,
  });

  final ChatRepository repository;

  @override
  Future<Either<Failure, Chat>> call(Params params) async {
    return await repository.views(params.id);
  }
}

class Params extends Equatable {
  const Params({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [
        id,
      ];
}
