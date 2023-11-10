import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/sketch.dart';
import '../../repositories/sketch.dart';

class SketchViews extends UseCase<List<Sketch>, Params> {
  final SketchRepository repository;

  SketchViews(this.repository);

  @override
  Future<Either<Failure, List<Sketch>>> call(Params params) async {
    return await repository.views(teamId: params.teamId);
  }
}

class Params extends Equatable {
  final String teamId;

  const Params({required this.teamId});

  @override
  List<Object?> get props => [teamId];
}
