import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/sketch.dart';
import '../../repositories/sketch.dart';

class SketchUpdate extends UseCase<Sketch, Params> {
  final SketchRepository repository;

  SketchUpdate(this.repository);

  @override
  Future<Either<Failure, Sketch>> call(Params params) async {
    return await repository.update(
      title: params.title,
      teamId: params.teamId,
      sketchId: params.sketchId,
    );
  }
}

class Params extends Equatable {
  final String title;
  final String teamId;
  final String sketchId;

  const Params(
      {required this.title, required this.teamId, required this.sketchId});

  @override
  List<Object?> get props => [teamId, title, sketchId];
}
