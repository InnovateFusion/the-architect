import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/team.dart';
import '../../repositories/team.dart';

class TeamDelete implements UseCase<Team, Params> {
  final TeamRepository repository;

  TeamDelete(this.repository);

  @override
  Future<Either<Failure, Team>> call(Params params) async {
    return await repository.delete(params.teamId);
  }
}

class Params extends Equatable {
  final String teamId;

  const Params({
    required this.teamId,
  });

  @override
  List<Object?> get props => [teamId];
}
