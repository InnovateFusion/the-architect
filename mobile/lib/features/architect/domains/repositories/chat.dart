import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/chat.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, Chat>> create({
    required Map<String, dynamic> payload,
    required String userId,
    required String model,
  });
  Future<Either<Failure, Message>> message({
    required Map<String, dynamic> payload,
    required String chatId,
    required String model,
    required String userId,
  });

  Future<Either<Failure, Chat>> view(String id);
  Future<Either<Failure, List<Chat>>> views(String userId);

}
