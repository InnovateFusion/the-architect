import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/team.dart';

class TeamMembers implements UseCase<List<User>, Params> {
  final TeamRepository repository;

  const TeamMembers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(Params params) async {
    return await repository.teamMembers(params.id);
  }
}

class Params extends Equatable {
  final String id;

  const Params(this.id);

  @override
  List<Object?> get props => [id];
}
