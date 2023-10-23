import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> getAuth({
    required String email,
    required String password,
  });

  Future<Either<Failure, bool>> checkAuth();
}
