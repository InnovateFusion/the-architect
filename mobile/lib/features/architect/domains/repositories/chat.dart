import 'package:architect/core/errors/failure.dart';
import 'package:architect/features/architect/domains/entities/chat.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<Failure, Chat>> create({
    required Map<String, dynamic> payload,
    required String userId,
    required String model,
  });

  Future<Either<Failure, Chat>> view(String id);
  Future<Either<Failure, Chat>> views(String userId);
}
