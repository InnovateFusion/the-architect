import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/message.dart';
import '../../repositories/chat.dart';

class MakeChat extends UseCase<Message, Params> {
  MakeChat(
    this.repository,
  );

  final ChatRepository repository;

  @override
  Future<Either<Failure, Message>> call(Params params) async {
    return await repository.message(
      payload: params.payload,
      chatId: params.chatId,
      model: params.model,
      userId: params.userId,
      isTeam: params.isTeam,
    );
  }
}

class Params extends Equatable {
  const Params({
    required this.payload,
    required this.chatId,
    required this.model,
    required this.userId,
    this.isTeam,
  });

  final Map<String, dynamic> payload;
  final String chatId;
  final String model;
  final String userId;
  final bool? isTeam;

  @override
  List<Object?> get props => [
        payload,
        chatId,
        model,
        userId,
      ];
}
