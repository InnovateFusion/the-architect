import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/sketch.dart';
import '../../repositories/sketch.dart';

class SketchView extends UseCase<Sketch, Params> {
  final SketchRepository repository;

  SketchView(this.repository);

  @override
  Future<Either<Failure, Sketch>> call(Params params) async {
    return await repository.view(params.sketchId);
  }
}

class Params extends Equatable {
  final String sketchId;

  const Params({required this.sketchId});

  @override
  List<Object?> get props => [sketchId];
}
