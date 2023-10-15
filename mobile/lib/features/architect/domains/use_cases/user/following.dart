import 'package:architect/core/use_cases/usecase.dart';
import 'package:architect/features/architect/domains/entities/user.dart';
import 'package:architect/features/architect/domains/repositories/user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';

class UserFollowing implements UseCase<List<User>, Params> {
  final UserRepository repository;

  const UserFollowing(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(Params params) async {
    return await repository.followings(params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params(this.id);

  @override
  List<Object?> get props => [id];
}
