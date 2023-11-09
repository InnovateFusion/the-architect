import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/team.dart';
import '../../repositories/team.dart';

class TeamLeave implements UseCase<Team, Params> {
  final TeamRepository repository;

  TeamLeave(this.repository);

  @override
  Future<Either<Failure, Team>> call(Params params) async {
    return await repository.leave(params.teamId, params.userId);
  }
}

class Params extends Equatable {
  final String teamId;
  final String userId;

  const Params({
    required this.teamId,
    required this.userId
  });

  @override
  List<Object?> get props => [teamId, userId];
}
