import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/chat.dart';
import '../../repositories/chat.dart';

class ViewChat extends UseCase<Chat, Params> {
  ViewChat(
    this.repository,
  );

  final ChatRepository repository;

  @override
  Future<Either<Failure, Chat>> call(Params params) async {
    return await repository.view(params.id);
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
