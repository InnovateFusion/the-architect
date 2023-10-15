import 'package:architect/core/errors/failure.dart';
import 'package:architect/core/use_cases/usecase.dart';
import 'package:architect/features/architect/domains/entities/chat.dart';
import 'package:architect/features/architect/domains/repositories/chat.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateChat extends UseCase<Chat, Params> {
  CreateChat({
    required this.repository,
  });

  final ChatRepository repository;

  @override
  Future<Either<Failure, Chat>> call(Params params) async {
    return await repository.create(
      payload: params.payload,
      userId: params.userId,
      model: params.model,
    );
  }
}

class Params extends Equatable {
  const Params({
    required this.payload,
    required this.userId,
    required this.model,
  });

  final Map<String, dynamic> payload;
  final String userId;
  final String model;

  @override
  List<Object?> get props => [
        payload,
        userId,
        model,
      ];
}
