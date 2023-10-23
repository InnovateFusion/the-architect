import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/chat.dart';
import '../../repositories/chat.dart';

class CreateChat extends UseCase<Chat, Params> {
  CreateChat(
    this.repository,
  );

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
