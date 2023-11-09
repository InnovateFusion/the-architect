import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/team.dart';
import '../../repositories/team.dart';

class TeamViews implements UseCase<List<Team>, NoParams> {
  final TeamRepository repository;

  TeamViews(this.repository);

  @override
  Future<Either<Failure, List<Team>>> call(NoParams params) async {
    return await repository.views();
  }
}
