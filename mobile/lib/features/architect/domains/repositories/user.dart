import 'package:architect/features/architect/domains/entities/user.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> create({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? image,
    String? bio,
    String? country,
  });
  Future<Either<Failure, User>> update({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? password,
    String? image,
    String? bio,
    String? country,
  });

  Future<Either<Failure, User>> delete(String id);
  Future<Either<Failure, User>> view(String id);
  Future<Either<Failure, List<User>>> views();
  Future<Either<Failure, User>> follow(String id);
  Future<Either<Failure, User>> unfollow(String id);
  Future<Either<Failure, List<User>>> followers(String id);
  Future<Either<Failure, List<User>>> followings(String id);
}
