import 'package:architect/core/errors/failure.dart';
import 'package:architect/features/architect/domains/entities/auth.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> getAuth({
    required String email,
    required String password,
  });
}
