import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/team.dart';
import '../../repositories/team.dart';

class TeamUpdate implements UseCase<Team, Params> {
  final TeamRepository repository;

  TeamUpdate(this.repository);

  @override
  Future<Either<Failure, Team>> call(Params params) async {
    return await repository.update(
      title: params.title,
      description: params.description,
      image: params.image,
      teamId: params.teamId,
      members: params.members,
    );
  }
}

class Params extends Equatable {
  final String title;
  final String? description;
  final String? image;
  final String teamId;
  final List<String>? members;

  const Params({
    required this.title,
    required this.teamId,
    this.description,
    this.image,
    this.members,
  });

  @override
  List<Object?> get props => [title, description, image, teamId];
}
