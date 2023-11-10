import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/team.dart';
import '../../repositories/team.dart';

class TeamAddMembers implements UseCase<Team, Params> {
  final TeamRepository repository;

  TeamAddMembers(this.repository);

  @override
  Future<Either<Failure, Team>> call(Params params) async {
    return await repository.addUsers(params.usersId, params.teamId);
  }
}

class Params extends Equatable {
  final List<String> usersId;
  final String teamId;

  const Params({required this.usersId, required this.teamId});

  @override
  List<Object?> get props => [usersId];
}
