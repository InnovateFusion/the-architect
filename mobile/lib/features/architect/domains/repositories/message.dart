import 'package:architect/core/errors/failure.dart';
import 'package:architect/features/architect/domains/entities/message.dart';

import 'package:dartz/dartz.dart';

abstract class MessageRepository {
  Future<Either<Failure, Message>> createMessage({
    required String model,
    required Map<String, dynamic> payload,
    required String chatId,
  });
}
